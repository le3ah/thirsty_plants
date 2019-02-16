module OurArrayMethods
  def self.spread_evenly(length, step, offset = 0)
    n = step + offset
    arr = []
    length.times do
      integer = n.to_i
      arr << integer
      n = n % 1
      n += step
    end
    arr
  end
end
