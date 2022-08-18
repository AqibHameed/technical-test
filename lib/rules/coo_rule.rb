module Rules
  class CooRule
    def initialize(item, bulk_size, amount)
      @item = item
      @bulk_size = bulk_size
      @amount = amount
    end

    def valid_for?(item)
      @item == item
    end

    def total_for(checkout)
      item_count = checkout.count { |co_item| co_item == @item }
      return @amount.times(item_count) if item_count >= @bulk_size

      @item.amount.times(item_count)
    end
  end
end
