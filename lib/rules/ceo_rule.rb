module Rules
  class CeoRule
    def initialize(item)
      @item = item
    end

    def valid_for?(item)
      @item == item
    end

    def total_for(checkout)
      item_count = checkout.count { |co_item| co_item == @item }
      item_count = (item_count / 2.0).ceil
      @item.amount.times(item_count)
      
    end
  end
end
