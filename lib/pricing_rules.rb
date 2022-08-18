require './lib/rules'

class PricingRules
  def initialize(items: [], rules: [])
    @items = items
    @rules = rules
  end
  # Calculate total amount
  def total_for(checkout)
    uniq_items.map do |item|
      rule_for(item).total_for(checkout)
    end.inject do |sum, amount|
      sum += amount
    end
  end

  private
  # Find rule against product if rule not find then no rule will be apply
  def rule_for(item)
    @rules.find { |rule| rule.valid_for?(item) } ||
      Rules.no_rule_on(item)
  end

  def uniq_items
    @uniq_items ||= @items.uniq
  end
end
