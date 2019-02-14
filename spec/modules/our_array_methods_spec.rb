require "rails_helper"
require "./lib/modules/our_array_methods"

describe OurArrayMethods do
  describe '.spread_evenly' do
    it 'base case' do
      result = OurArrayMethods::spread_evenly(:x, 7, 0.5)
      expect(result).to eq([[],[:x],[],[:x],[],[:x],[]])
    end
    it 'with offset' do
      result = OurArrayMethods::spread_evenly(:x, 7, 0.5, 0.5)
      expect(result).to eq([[:x],[],[:x],[],[:x],[],[:x]])
    end
  
  end

end
