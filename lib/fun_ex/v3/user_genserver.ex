defmodule FunEx.V3.UserGenServer do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(_args), do: {:ok, nil}

  def handle_call({:allowed?, email}, _from, state) do
    result = FunEx.V3.UserService.allowed?(email, &File.read/1)
    {:reply, result, state}
  end
end