require "string_enumerator/version"

class StringEnumerator
  def initialize(replacements)
    @replacements = replacements.inject({}) do |memo, (k, v)|
      memo[k.to_s] = v
      memo
    end
  end

  attr_reader :replacements
  
  attr_writer :start_mark
  def start_mark
    @start_mark || '['
  end
  
  attr_writer :end_mark
  def end_mark
    @end_mark || ']'
  end
  
  # Get all the possible enumerations of <tt>str</tt> given the <tt>replacements</tt> you defined
  def enumerate(str)
    enumerations = [str] # seed it
    str.scan(pattern) do |placeholder|
      placeholder = placeholder[0]
      if r = replacements[placeholder]
        # "recursion"
        enumerations = enumerations.map do |e|
          r.map { |replacement| e.gsub(%{#{start_mark}#{placeholder}#{end_mark}}, replacement) }
        end.flatten
      end
    end
    enumerations
  end
  
  private

  def pattern
    @pattern ||= /#{::Regexp.escape(start_mark)}([^#{::Regexp.escape(end_mark)}]+)#{::Regexp.escape(end_mark)}/
  end
end
