require './lib/checkout'
require './lib/pricing_rules.rb'
require './lib/item.rb'
require './lib/amount.rb'
require './lib/rules.rb'

RSpec.describe 'TestData' do
  let(:green_tea) { Item.new('GR1', 'Green tea', Amount.new(3.11, '£')) }
  let(:strawberries) { Item.new('SR1', 'Strawberries', Amount.new(5.00, '£')) }
  let(:coffee) { Item.new('CF1', 'Coffee', Amount.new(11.23, '£')) }

  let(:two_for_one_on_green_tea) { Rules.ceo_rule_on(green_tea) }
  let(:bulk_price_strawberries) { Rules.coo_rule_on(strawberries, bulk_size: 3, amount: Amount.new(4.50, '£')) }
  let(:bulk_discount_coffee) { Rules.cto_rule_on(coffee, bulk_size: 3, discount: 2.0/3) }

  let(:pricing_rules) { PricingRules.new(items: [green_tea, strawberries, coffee], rules: [two_for_one_on_green_tea, bulk_price_strawberries, bulk_discount_coffee]) }

  context 'having 1 item checkout' do
    it 'computes the total' do
      expected_price = '£3.11'

      co = Checkout.new(pricing_rules)
      co.scan(green_tea)
      price = co.total

      expect(price).to eq(expected_price)
    end
  end

  context 'having 2 of buy-one-get-one-free items' do
    it 'computes the total' do
      expected_price = '£3.11'

      co = Checkout.new(pricing_rules)
      co.scan(green_tea)
      co.scan(green_tea)
      price = co.total

      expect(price).to eq(expected_price)
    end
  end

  context 'having 3 or more bulk-price items' do
    it 'computes the total with a bulk price' do
      expected_price = '£13.50'

      co = Checkout.new(pricing_rules)
      co.scan(strawberries)
      co.scan(strawberries)
      co.scan(strawberries)
      price = co.total

      expect(price).to eq(expected_price)
    end
  end

  context 'having 3 or more bulk-discount items' do
    it 'computes the total with a bulk price' do
      expected_price = '£22.46'

      co = Checkout.new(pricing_rules)
      co.scan(coffee)
      co.scan(coffee)
      co.scan(coffee)
      price = co.total

      expect(price).to eq(expected_price)
    end
  end

  context 'README tests' do
    it 'should compute checkout amount' do
      [
        {
          checkout: [green_tea, strawberries, green_tea, green_tea, coffee],
          expected_total: '£22.45'
        },
        {
          checkout: [green_tea, green_tea],
          expected_total: '£3.11'
        },
        {
          checkout: [strawberries, strawberries, green_tea, strawberries],
          expected_total: '£16.61'
        },
        {
          checkout: [green_tea, coffee, strawberries, coffee, coffee],
          expected_total: '£30.57'
        },
      ].each do |test_case|
          co = Checkout.new(pricing_rules)
          test_case[:checkout].each { |item| co.scan(item) }

          expect(co.total).to eq(test_case[:expected_total])
        end
    end
  end
end
