defmodule StarbucksElixir do

  def start do

    Customer.start
    Cashier.start
    #Barista.start
    Queue.start_link(HashDict.new)
  end

end
