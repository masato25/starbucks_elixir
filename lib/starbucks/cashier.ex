defmodule Cashier do

  @name :cashier

  def start do
    pid = spawn(__MODULE__, :loop, [])
    :global.register_name(@name, pid)
    IO.puts("Cashier: ")
    IO.inspect(pid)
  end

  def stop do
    Process.delete(myid)
    :global.unregister_name(@name)
  end

  def myid(name \\ @name) do
    :global.whereis_name(name)
  end

  def loop do
    receive do
      {:new_order, customer_name } ->
        IO.puts("Cashier: Got new order, write down coustomer name on cup - #{customer_name}. ")
        :timer.sleep 3000
        Queue.push(customer_name, %Order.Struct{name: customer_name})
        Barista.addcup(customer_name)
        send myid(customer_name), { :request_payment, @name}
        loop
      {:paymoney, customer_name } ->
        IO.puts("Cashier: Customer paid (#{customer_name})")
        Queue.update(customer_name,:paid)
        loop
    end
  end

end
