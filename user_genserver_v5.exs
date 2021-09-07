defmodule MyApp.UserGenServerV5 do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(_args), do: {:ok, nil}

  def handle_call({:store, name}, _from, state) do
    line = MyApp.UserServiceV5.store(name)
    {:reply, line, state}
  end
end