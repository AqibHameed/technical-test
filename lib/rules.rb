require_relative './rules/no_rule'
require_relative './rules/ceo_rule'
require_relative './rules/coo_rule'
require_relative './rules/cto_rule'

module Rules
  def self.no_rule_on(item)
    NoRule.new(item)
  end

  def self.ceo_rule_on(item)
    CeoRule.new(item)
  end

  def self.coo_rule_on(item, bulk_size:, amount:)
    CooRule.new(item, bulk_size, amount)
  end

  def self.cto_rule_on(item, bulk_size:, discount:)
    CtoRule.new(item, bulk_size, discount)
  end
end

