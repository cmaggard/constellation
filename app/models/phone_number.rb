class PhoneNumber
  attr_accessor :area_code, :exchange, :local, :extension
  def initialize(ac,ex,loc,ext)
    @area_code = ac
    @exchange = ex
    @local = loc
    @extension = ext
  end
  
  def to_s
    ph = [@area_code, @exchange, @local].compact.join("-")
    if extension.empty?
      ph
    else 
      ph + "x#{@extension}"
    end
  end
end