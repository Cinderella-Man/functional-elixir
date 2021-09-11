defmodule MyApp.UserGenServerV3 do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(_args), do: {:ok, nil}

  def handle_call({:store, name}, _from, state) do
    date = DateTime.utc_now()
    write_fn = &File.write/3
    line = MyApp.UserServiceV3.store(name, date, write_fn)
    {:reply, line, state}
  end
end