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

  def total_inventory
    result = Hash.new{|h,k| h[k] = {quantity: 0, vendors: [] }}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        result[item][:quantity] += quantity
        result[item][:vendors] << vendor
      end
    end
    result
  end

  def overstocked_items
    result = []
    total_inventory.each do |item, vendor|
      if vendor.length > 1 && vendor[:quantity] > 50
        result << item
      end
    end
    result
  end

  def sorted_item_list
    sorted = []
    @vendors.flat_map do |vendor|
      vendor.inventory.each do |item, quantity|
        sorted << item.name
      end
    end
    sorted.uniq.sort
  end

end
