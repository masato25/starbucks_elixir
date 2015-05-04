defmodule StarbucksElixir do

  def start do

    Customer.start
    Cashier.start
    Queue.start_link(HashDict.new)
    Barista.start_link([])
    pid = spawn(Barista, :loop, [])
    :global.register_name(:baristawork,pid)

  end

end
