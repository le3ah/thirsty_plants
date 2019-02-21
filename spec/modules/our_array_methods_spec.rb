require "rails_helper"
require "./lib/modules/our_array_methods"

describe OurArrayMethods do
  describe '.spread_evenly' do
    it 'base case' do
      result = OurArrayMethods::spread_evenly(7, 0.5)
      expect(result).to eq([0, 1, 0, 1, 0, 1, 0])
    end
    it 'with preload set to 1' do
      result = OurArrayMethods::spread_evenly(7, 0.5, 1)
      expect(result).to eq([1,1,0,1,0,1,0])
    end
    it 'with preload set to 0.5' do
      result = OurArrayMethods::spread_evenly(7, 0.5, 0.5)
      expect(result).to eq([1,0,1,0,1,0,1])
    end
    it 'with preload set to 3' do
      result = OurArrayMethods::spread_evenly(7, 0.5, 3)
      expect(result).to eq([3, 1, 0, 1, 0, 1, 0])
    end
    it 'with 1/7' do
      result = OurArrayMethods::spread_evenly(8, (1.to_f / 7))
      expect(result).to eq([0, 0, 0, 0, 0, 0, 0, 1])
    end
    it 'with 1/7 and preload 0' do
      result = OurArrayMethods::spread_evenly(10, (1.to_f / 7), 0)
      expect(result).to eq([0, 0, 0, 0, 0, 0, 0, 1, 0, 0])
    end
    it 'with 1/7 and preload 0.99' do
      result = OurArrayMethods::spread_evenly(10, (1.to_f / 7), 1)
      expect(result).to eq([1, 0, 0, 0, 0, 0, 0, 1, 0, 0])
    end
    it 'with 1.5' do
      result = OurArrayMethods::spread_evenly(7, 1.5)
      expect(result).to eq([1, 2, 1, 2, 1, 2, 1])
    end
    it 'with 1.34' do
      result = OurArrayMethods::spread_evenly(10, 1.34)
      expect(result).to eq([1, 1, 2, 1, 1, 2, 1, 1, 2, 1])
    end
  end
end
