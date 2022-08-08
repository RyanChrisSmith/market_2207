class Vendor
  attr_reader :name,
              :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    if @inventory.has_key?(item)
      @inventory[item]
    else
      0
    end
  end

  def stock(item, quantity)
    if @inventory.has_key?(item)
      @inventory[item] += quantity
    else
      @inventory[item] = quantity
    end
  end

  def potential_revenue
    sum_of_all = 0
    @inventory.each do |item|
      sum_of_all += ((item[0].price.delete('$').to_f) * item[1])
    end
    sum_of_all
  end

end
