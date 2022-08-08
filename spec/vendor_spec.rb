require 'spec_helper'
require './lib/item'
require './lib/vendor'

RSpec.describe Vendor do

  before :each do
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  it 'exists' do
    expect(@vendor).to be_a(Vendor)
  end

  it 'has attributes' do
    expect(@vendor.name).to eq 'Rocky Mountain Fresh'
  end

  it 'has nothing in its inventory at beginning' do
    expect(@vendor.inventory).to eq({})
  end

  it 'can check stock of specific items' do
    expect(@vendor.check_stock(@item1)).to eq 0
  end

  it 'can stock an item and quantity and then show inventory' do
    @vendor.stock(@item1, 30)
    expect(@vendor.stock).to eq({@item1 => 30})
  end

end