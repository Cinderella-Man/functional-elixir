defmodule FunEx.V2.TimeOffGenServer do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(_args), do: {:ok, nil}

  def handle_call({:next_holiday, date, territory}, _from, state) do
    result = FunEx.V2.TimeOffService.next_holiday(date, territory, &File.read/1)
    {:reply, result, state}
  end
end
