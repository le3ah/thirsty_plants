require 'rails_helper'

describe ZipcodeFinder do
  it 'can find latitudes and longitudes', :vcr do
    zip = '80203'
    finder = ZipcodeFinder.new(zip)
    
    expect(finder.latitude).to eq('39.7312095')
    expect(finder.longitude).to eq('-104.9826965')
  end
  
  it 'can return existing zip' do
    zip = '80203'
    zip_code = Zipcode.create(zip_code: zip, latitude: '39.7312095', longitude: '-104.9826965')
    finder = ZipcodeFinder.new(zip)
    
    expect(finder.find_zip).to eq(zip_code)
  end
end