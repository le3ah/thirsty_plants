class ZipcodeFinder
  def initialize(zip_code)
    @zip_code = zip_code
  end
  
  def latitude
    existing_latitude = Zipcode.find_by(zip_code: @zip_code).latitude
    if existing_latitude
      existing_latitude
    else
      LocationService.new(@zip_code).get_latitude
    end
  end
  
  def longitude
    existing_longitude = Zipcode.find_by(zip_code: @zip_code).longitude
    if existing_longitude
      existing_longitude
    else
      LocationService.new(@zip_code).get_longitude
    end
  end
end