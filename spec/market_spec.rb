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

end