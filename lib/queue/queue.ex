defmodule Queue do
  use GenServer

  def start_link(myqueue) do
    GenServer.start_link(__MODULE__, myqueue, name: __MODULE__)
  end

  def status do
    GenServer.call __MODULE__, :status
  end

  def push(name,order) do
    GenServer.cast __MODULE__, {:push,name,order}
  end

  # def pop do
  #   GenServer.call __MODULE__, :pop
  # end
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
        {:noreply, new_myqueue}
      action == :paid ->
        new_myqueue = Dict.update(myqueue, name , action, fn value -> Map.put(value,:paid,true) end)
        {:noreply, new_myqueue}
      true ->
        #no match action do noting
        {:noreply, myqueue}
    end
  end

  # def handle_call(:pop, _from, myqueue) do
  #   if myqueue == [] do
  #     {:reply, myqueue, myqueue}
  #   else
  #     [_item | newqueue] = myqueue
  #     {:reply, newqueue, newqueue}
  #   end
  # end
end
