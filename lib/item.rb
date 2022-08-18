class Item
  attr_reader :code, :name, :amount

  def initialize(code, name, amount)
    @code = code
    @name = name
    @amount = amount
  end

  def ==(item)
    code == item.code
  end
end
