module OurArrayMethods
  def self.spread_evenly(element, length, step, offset = 0)
    i = step + offset
    arr = []
    length.times do
      sub_array = []
      require 'pry'; binding.pry
      (i.to_i / 1).times do
        i = i % 1
        sub_array << element
      end
      i += step
      arr << sub_array
    end
    arr
  end
end
