defmodule Customer do

  @name :customer

  def start do
    pid = spawn(__MODULE__, :loop, [])
    :global.register_name(@name, pid)
    IO.puts("Customer: ")
    IO.inspect(pid)
  end

  def stop do
    Process.delete(myid)
    :global.unregister_name(@name)
  end

  def myid do
    :global.whereis_name(@name)
  end

  def want_coffe do
    send :global.whereis_name(:cashier), {:new_order,myid}
  end

  def loop do

    receive do
      { :request_payment, cashier_pid } ->
        IO.puts("cashier request payment")
        ansert = IO.gets("please paid! yea or no?\n")
        send cashier_pid, {:paymoney, myid}
        loop
    end

  end

end
