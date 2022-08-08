class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    result = []
    @vendors.each do |vendor|
      result << vendor.name
    end
    result
  end

  def vendors_that_sell(item)
    result = []
    @vendors.each do |vendor|
      if vendor.check_stock(item) > 0
        result << vendor
      end
    end
    result
  end

end
