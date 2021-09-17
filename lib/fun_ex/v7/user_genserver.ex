defmodule FunEx.V7.UserGenServer do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(_args), do: {:ok, nil}

  def handle_call({:allowed?, email}, _from, state) do
    result = FunEx.V7.UserService.allowed?(email)
    {:reply, result, state}
  end
end
