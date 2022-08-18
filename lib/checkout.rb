class Checkout
  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @items = []
  end

  def scan(item)
    @items << item
  end

  def total
    pricing_rules.total_for(items).to_s
  end

  private

  def pricing_rules
    @pricing_rules
  end

  def items
    @items
  end
end
