defmodule Barista do
  use GenServer

  def start_link(cup_list) do
    GenServer.start_link(__MODULE__, cup_list, name: __MODULE__)
  end

  def takecup do
    GenServer.call __MODULE__, :takecup
  end

  def status do
    GenServer.call __MODULE__, :status
  end

  def addcup(name) do
    GenServer.cast __MODULE__, {:addcup,name}
  end

  def handle_call(:takecup, _from, cup_list) do
    if !is_list(cup_list) or cup_list == [] do
      {:reply, nil, cup_list}
    else
      [one | new_list] = cup_list
      {:reply, one, new_list}
    end
  end

  def handle_call(:status, _from, cup_list) do
    {:reply, cup_list, cup_list}
  end

  def handle_cast({:addcup,name}, cup_list) do
    new_list = cup_list ++ [name]
    {:noreply, new_list}
  end

  def loop do
    receive do
      {:make_coffee, name} ->
        IO.puts("Basrista: start to make coffee for (#{name})")
        :timer.sleep 5000
        IO.puts("Basrista: #{name}'s coffee is ready!")
        Queue.update(name,:orderdone)
        loop
    after
      6000 ->
        current_cup = Barista.takecup
        if current_cup != nil do
          send :global.whereis_name(:baristawork), {:make_coffee, current_cup}
        end
        loop
    end
  end
end
