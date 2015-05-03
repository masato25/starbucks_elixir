defmodule StarbucksElixir do

  def start do

    {:ok, masato1} = Customer.start("masato1")
    {:ok, masato2} = Customer.start("masato2")
    {:ok, masato3} = Customer.start("masato3")
    {:ok, masato4} = Customer.start("masato4")
    {:ok, masato5} = Customer.start("masato5")
    Customer.start
    Cashier.start
    Barista.start_link([])
    pid = spawn(Barista, :loop, [])
    :global.register_name(:baristawork,pid)
    Queue.start_link(HashDict.new)

  end

end
