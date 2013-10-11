module Ov
  class OA < Array 
    #alias :o :fetch
    def where(*types)

    end

    private 
    def compare(a, b)
      return false if a.size != b.size
      !a.zip(b).map do |arr| 
        first, last = arr 
        true if (first == Ov::Any) || (last == Ov::Any) || (first == last)  
      end.include?(nil)
    end
  end
end