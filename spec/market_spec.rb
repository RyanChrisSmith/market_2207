require 'spec_helper'
require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do

  before :each do
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: "$0.50"})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
  end

  it 'exists' do
    expect(@market).to be_a(Market)
  end

  it 'has attributes' do
    expect(@market.name).to eq 'South Pearl Street Farmers Market'
  end

  it 'has zero vendors in the beginning' do
    expect(@market.vendors).to eq([])
  end

  it 'can add vendors and list them' do
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
  end

  it 'can list the vendors by name' do
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.vendor_names).to eq (['Rocky Mountain Fresh', 'Ba-Nom-a-Nom', 'Palisade Peach Shack'])
  end

  it 'can list the vendors that have an item in stock' do
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
    expect(@market.vendors_that_sell(@item3)).to eq([@vendor2])
    expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])
  end

  it 'can show total inventory of all vendors' do
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @vendor3.stock(@item3, 10)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.total_inventory).to eq({@item1 => {quantity: 100, vendors: [@vendor1, @vendor3]}, @item2 => {quantity: 7, vendors: [@vendor1]}, @item4 => {quantity: 50, vendors: [@vendor2]}, @item3 => {quantity: 35, vendors: [@vendor2, @vendor3]}})
  end

  it 'can show if item is overstocked' do
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @vendor3.stock(@item3, 10)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.overstocked_items).to eq([@item1])
  end

  it 'can show a sorted item list' do
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @vendor3.stock(@item3, 10)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
  end

  it 'can shows todays date' do
    allow_any_instance_of(Market).to receive(:date).and_return('08/08/2022')
    expect(@market.date).to eq('08/08/2022')
  end

  it 'can sell items from inventory' do
    @item5 = Item.new({name: 'Onion', price: '$0.25'})
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.sell(@item1, 200)).to be false
    expect(@market.sell(@item5, 1)).to be false
    expect(@market.sell(@item4, 5)).to be true
    expect(@vendor2.check_stock(@item4)).to eq 45
    expect(@market.sell(@item1, 40)).to be true
    expect(@vendor1.check_stock(@item1)).to eq 0
    expect(@vendor3.check_stock(@item1)).to eq 60
  end
end