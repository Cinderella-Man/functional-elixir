defmodule FunEx.V8.TimeOffGenServer do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_args), do: {:ok, nil}

  def handle_call({:next_holiday, date, territory}, _from, state) do
    result = FunEx.V8.TimeOffService.next_holiday(date, territory)
    {:reply, result, state}
  end
end
