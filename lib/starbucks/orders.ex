defmodule Orders do

  @name :orders

  def start do
    pid = spawn(__MODULE__, :queue, [[]])
    :global.register_name(@name, pid)
    IO.puts("Orders: ")
    IO.inspect(pid)
  end

  def stop do
    Process.delete(myid)
    :global.unregister_name(@name)
  end

  def myid do
    :global.whereis_name(@name)
  end

  def queue(qu = ["a"]) do
    tmpqu = qu
    receive do
      {:add, item} ->
        tmpqu = tmpqu ++ [item]
        queue(tmpqu)
      :stats ->
        IO.puts("hello")
        queue(tmpqu)
    end
  end
end
