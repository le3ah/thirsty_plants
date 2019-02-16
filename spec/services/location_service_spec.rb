require 'rails_helper'

describe LocationService do
  it 'returns the latitude and longitude of a zip code', :vcr do
    zip = 80203
    lat = '39.7312095'
    long = '-104.9826965'
    user = create(:user)
    garden = user.gardens.create(name: 'Garden', zip_code: zip)
    
    expect(garden.lat).to eq(lat)
    expect(garden.long).to eq(long)
  end
  it 'returns the latitude and longitude of a different zip code', :vcr do
    zip = 96814
    lat = '21.2966976'
    long = '-157.8480364'
    user = create(:user)
    garden = user.gardens.create(name: 'Garden', zip_code: zip)
    
    expect(garden.lat).to eq(lat)
    expect(garden.long).to eq(long)
  end
end