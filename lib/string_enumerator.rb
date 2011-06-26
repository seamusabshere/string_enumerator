require "string_enumerator/version"

class StringEnumerator
  # Get all the possible enumerations of <tt>str</tt> given the <tt>replacements</tt> you defined
  def enumerate(str)
    enumerations = [str] # seed it
    str.scan(pattern) do |placeholder|
      placeholder = placeholder[0]
      if r = stringified_replacements[placeholder]
        enumerations = enumerations.map do |e|
          r.map { |replacement| e.gsub(%{[#{placeholder}]}, replacement) }
        end.flatten
      end
    end
    enumerations
  end
  
  # Your class should override this
  #
  # For example:
  #     class ColorsAndTastes < StringEnumerator
  #       def replacements
  #         {
  #           :color => [ 'red', 'blue' ],
  #           :taste => [ 'savory', 'sweet' ]
  #         }
  #       end
  #     end
  def replacements
    raise "[StringEnumerator] Override this method with your replacements"
  end
  
  private
  
  def stringified_replacements
    @stringified_replacements ||= replacements.inject({}) do |memo, (k, v)|
      memo[k.to_s] = v
      memo
    end
  end
  
  def pattern
    @pattern ||= /#{::Regexp.escape(start_mark)}([^#{::Regexp.escape(end_mark)}]+)#{::Regexp.escape(end_mark)}/
  end
  
  def start_mark
    '['
  end
  
  def end_mark
    ']'
  end
end
