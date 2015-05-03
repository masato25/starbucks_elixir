defmodule Queue do
  use GenServer

  def start_link(myqueue) do
    GenServer.start_link(__MODULE__, myqueue,name: __MODULE__)
  end

  def status do
    GenServer.call __MODULE__, :status
  end

  def push(name,order) do
    GenServer.cast __MODULE__, {:push,name,order}
  end

  def update(name,action) do
    GenServer.cast __MODULE__, {:update,name,action}
  end

  def handle_call(:status, _from, myqueue) do
    {:reply, myqueue, myqueue}
  end

  def handle_cast({:push,name,order}, myqueue) do
    {:noreply, Dict.put(myqueue,name,order)}
  end

  def handle_cast({:update,name,action},myqueue) do
    #set stats as true (paid or done?)
    cond do
      action == :orderdone ->
        new_myqueue = Dict.update(myqueue, name , action, fn value -> Map.put(value,:orderdone,true) end)
        checkisdone(new_myqueue,name)
        {:noreply, new_myqueue}
      action == :paid ->
        new_myqueue = Dict.update(myqueue, name , action, fn value -> Map.put(value,:paid,true) end)
        checkisdone(new_myqueue,name)
        {:noreply, new_myqueue}
      true ->
        #no match action do noting
        {:noreply, myqueue}
    end
  end

  def myid(name) do
    :global.whereis_name(name)
  end

  def checkisdone(queue,name) do
      order = Dict.get(queue, name)
      if order.paid == true && order.orderdone == true do
        send myid(name), {:coffee_ready, name}
      end
  end

end
