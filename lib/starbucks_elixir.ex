defmodule StarbucksElixir do

  def start do

    Customer.start
    Cashier.start
    Barista.start_link([])
    pid = spawn(Barista, :loop, [])
    :global.register_name(:baristawork,pid)
    Queue.start_link(HashDict.new)

  end

end
