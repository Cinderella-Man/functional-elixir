defmodule FunEx.V6.TimeOffGenServer do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(_args), do: {:ok, nil}

  def handle_call({:next_holiday, date}, _from, state) do
    result = FunEx.V6.TimeOffService.next_holiday(date)
    {:reply, result, state}
  end
end
