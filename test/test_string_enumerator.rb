require 'helper'
require 'brighter_planet_metadata'
require 'active_support/core_ext'

class UrlFiller < StringEnumerator
  # this has to return a Hash of placeholder => replacement pairs
  def replacements
    {
      :certified_emitter_underscore_plural  => BrighterPlanet.metadata.certified_emitters.map { |emitter| emitter.underscore.pluralize },
      :emission_estimate_service_color      => %w{red blue},
      :emitter_underscore_plural            => BrighterPlanet.metadata.emitters.map { |emitter| emitter.underscore.pluralize },
      :resource_underscore                  => BrighterPlanet.metadata.resources.map { |resource| resource.underscore }
    }
  end
end

class TestStringEnumerator < Test::Unit::TestCase
  def setup
    @f = UrlFiller.new
  end
  
  def test_001_enumerates_emitters
    automatically_enumerated = @f.enumerate("http://carbon.brighterplanet.com/[emitter_underscore_plural]/options.html")
    manually_enumerated = BrighterPlanet.metadata.emitters.map do |emitter|
      "http://carbon.brighterplanet.com/#{emitter.underscore.pluralize}/options.html"
    end
    assert_equal automatically_enumerated.sort, manually_enumerated.sort
  end

  def test_002_enumerates_emitters_and_colors
    automatically_enumerated = @f.enumerate("http://cm1-production-[emission_estimate_service_color].carbon.brighterplanet.com/[emitter_underscore_plural]/options.html")
    manually_enumerated = BrighterPlanet.metadata.emitters.map do |emitter|
      %w{red blue}.map do |color|
        "http://cm1-production-#{color}.carbon.brighterplanet.com/#{emitter.underscore.pluralize}/options.html"
      end
    end.flatten
    assert_equal automatically_enumerated.sort, manually_enumerated.sort
  end
  
  # sanity check, we'd never do this
  def test_003_enumerates_emitters_and_colors_and_resources
    enumerated = @f.enumerate("http://cm1-production-[emission_estimate_service_color].carbon.brighterplanet.com/[emitter_underscore_plural]/options.html?foobar=[resource_underscore]")
    assert enumerated.include?("http://cm1-production-red.carbon.brighterplanet.com/flights/options.html?foobar=flight_segment")
    assert enumerated.include?("http://cm1-production-blue.carbon.brighterplanet.com/flights/options.html?foobar=flight_segment")
    assert enumerated.include?("http://cm1-production-red.carbon.brighterplanet.com/automobile_trips/options.html?foobar=flight_segment")
    assert enumerated.include?("http://cm1-production-blue.carbon.brighterplanet.com/automobile_trips/options.html?foobar=flight_segment")
  end
  
  def test_004_edge_case_empty_placeholder
    enumerated = @f.enumerate("http://carbon.brighterplanet.com/[]/options.html")
    assert_equal ["http://carbon.brighterplanet.com/[]/options.html"], enumerated
  end
end
