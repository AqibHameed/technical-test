class Amount
  require 'pry'
  attr_reader :price, :symbol

  def initialize(price, symbol)
    @price = price
    @symbol = symbol
  end

  def +(amount)
    raise NoMatchCurrencyError if symbol != amount.symbol
    Amount.new(price + amount.price, symbol)
  end
  #price multiply with the counter of the product 
  def times(operand)
    Amount.new(price * operand, symbol)
  end

  def ==(amount)
    symbol == amount.symbol && price == amount.price
  end

  def to_s
    "%s%.2f" % [symbol, price]
  end

  class NoMatchCurrencyError < StandardError; end
end
