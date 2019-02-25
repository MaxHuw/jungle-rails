require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before :each do
      @category = Category.new name: 'Apparel'
      @product = Product.new({name: "TestName", price: 10, quantity: 5, category: @category})
    end

    it 'all four fields save' do
      @product.save!
      expect(@product).to be_persisted
    end

    it 'should require a name' do
      @product.name = nil
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:name]).to include('can\'t be blank')
    end

    it 'should require a price' do
      @product.price_cents = nil
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:price]).to include('is not a number')
    end
   
    it 'should require a quantity' do
      @product.quantity = nil
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:quantity]).to include('can\'t be blank')
    end

    it 'should require a category' do
      @product.category = nil
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:category]).to include('can\'t be blank')
    end

  end
end
