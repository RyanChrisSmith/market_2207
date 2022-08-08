require 'spec_helper'
require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do

  before :each do
    @market = Market.new("South Pearl Street Farmers Market")
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
end