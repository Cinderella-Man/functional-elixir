defmodule FunEx.V7.TimeOffGenServer do
  use GenServer

  def start_link(), do: GenServer.start_link(__MODULE__, nil)

  def init(_args), do: {:ok, nil}

  def handle_call({:next_holiday, date, territory}, _from, state) do
    result = FunEx.V7.TimeOffService.next_holiday(date, territory)
    {:reply, result, state}
  end
end
