defmodule FunEx.V1.UserGenServer do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(_args), do: {:ok, nil}

  def handle_call({:allowed?, email}, _from, state) do
    {:ok, json} = File.read("list.json")
    {:ok, data} = Jason.decode(json)

    result = data
      |> Enum.map(&(Map.get(&1, "email")))
      |> Enum.map(&(String.downcase/1))
      |> Enum.any?(&(&1 == email))

    {:reply, result, state}
  end
end