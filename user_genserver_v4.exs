defmodule MyApp.UserGenServerV4 do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(_args), do: {:ok, nil}

  def handle_call({:store, name}, _from, state) do
    line = MyApp.UserServiceV4.store(name)
    {:reply, line, state}
  end
end