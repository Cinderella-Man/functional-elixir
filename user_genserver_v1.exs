defmodule MyApp.UserGenServerV1 do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(_args), do: {:ok, nil}

  def handle_call({:store, name}, _from, state) do
    d = DateTime.utc_now()
    ymd = "#{d.year}-#{d.month}-#{d.day}"

    name
      |> String.split(" ")
      |> Kernel.++([ymd])
      |> Enum.join(",")

    {:reply, line, state}
  end
end