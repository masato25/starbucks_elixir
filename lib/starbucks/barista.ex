defmodule Barista do

  @name :barista

  def start do
    pid = spawn(__MODULE__, :loop, [])
    :global.register_name(@name, pid)
    IO.puts("Barista: ")
    IO.inspect(pid)
  end

  def stop do
    Process.delete(myid)
    :global.unregister_name(@name)
  end

  def myid do
    :global.whereis_name(@name)
  end

  def loop do
    receive do

      {:new_order, customer_pid} ->
        IO.puts("got new order")
        :timer.sleep 3000
        send customer_pid, { :request_payment, myid}
        loop
      {:paymoney, _customer_pid } ->
        IO.puts("customer paid")
        loop

    end
  end

end
