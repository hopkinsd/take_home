require_relative '../spec_helper'
require "minitest/autorun"


describe ShoppingCart do

  describe '#can_modify?' do
    it 'will be false when cart has been purchased' do
      instance = ShoppingCart.new user_id: 1, purchase_date: Time.now
      (instance.send :can_modify?).must_equal false
    end

    it 'will be true when cart has not been purchased' do
      instance = ShoppingCart.new user_id: 1, purchase_date: nil
      (instance.send :can_modify?).must_equal true
    end
  end

  describe '#add_item' do
  end
end
