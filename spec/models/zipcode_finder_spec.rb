require 'rails_helper'

describe ZipcodeFinder do
  it 'can find latitudes and longitudes' do
    zip = '80203'
    finder = ZipcodeFinder.new(zip)
    
    expect(finder.latitude).to eq('39.7312095')
    expect(finder.longitude).to eq('-104.9826965')
  end
end