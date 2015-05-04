defmodule Customer do

  @name :customer

  def start(name \\ @name) do
    pid = spawn(__MODULE__, :loop , [name])
    :global.register_name(name, pid)
    IO.puts("Customer: ")
    IO.inspect(pid)
    {:ok, name}
  end

  def stop(name) do
    Process.delete(myid(name))
    :global.unregister_name(name)
  end

  def myid(name \\ @name) do
    :global.whereis_name(name)
  end

  def want_coffee(name \\ @name) do
    IO.puts("Customer(#{name}): I want a coffee!")
    send :global.whereis_name(:cashier), {:new_order,name}
  end

  def loop(name) do

    receive do
      { :request_payment, cashier_name } ->
        IO.puts("Cashier: request payment")
        _ansert = IO.gets("Cashier: hi #{name} please paid! yes or no?\n")
        send myid(cashier_name), {:paymoney, name}
        loop(name)
      { :coffee_ready, _name} ->
        IO.puts("Customer(#{name}): got coffee")
        loop(name)
    end

  end

end
