defmodule FunEx.V3.TimeOffGenServer do
  use GenServer

  require Logger

  def start_link(), do: GenServer.start_link(__MODULE__, nil)

  def init(_args), do: {:ok, nil}

  def handle_call({:next_holiday, date, territory}, _from, state) do
    result =
      FunEx.V3.TimeOffService.next_holiday(
        date,
        territory,
        &File.read/1,
        &Logger.info/1
      )

    {:reply, result, state}
  end
end
