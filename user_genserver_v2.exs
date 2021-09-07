defmodule MyApp.UserGenServerV2 do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(_args), do: {:ok, nil}

  def handle_call({:store, name}, _from, state) do
    date = DateTime.utc_now()
    line = MyApp.UserServiceV2.store(name, date)
    {:reply, line, state}
  end
end