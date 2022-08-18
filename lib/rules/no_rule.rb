module Rules
  class NoRule
    def initialize(item)
      @item = item
    end

    def valid_for?(_)
      true
    end

    def total_for(checkout)
      item_count = checkout.count { |co_item| co_item == @item }
      @item.amount.times(item_count)
    end
  end
end
