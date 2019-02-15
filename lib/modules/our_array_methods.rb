module OurArrayMethods
  def self.spread_evenly(length, step, offset = 0)
    i = step + offset
    arr = []
    length.times do
      num = 0
      (i.to_i / 1).times do
        i = i % 1
        num += 1
      end
      i += step
      arr << num
    end
    arr
  end
end
