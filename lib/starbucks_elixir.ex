defmodule StarbucksElixir do
  def start do
    Customer.start
    Cashier.start
  end
end
