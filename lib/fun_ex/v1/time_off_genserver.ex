defmodule FunEx.V1.TimeOffGenServer do
  use GenServer

  require Logger

  def start_link(), do: GenServer.start_link(__MODULE__, nil)

  def init(_args), do: {:ok, nil}

  def handle_call({:next_holiday, date, territory}, _from, state) do
    {:ok, _date} = Date.from_iso8601(date)

    Logger.info("Fetching bank holidays")

    {:ok, json} = File.read("bank_holidays.json")
    {:ok, data} = Jason.decode(json)

    bank_holidays =
      data
      |> Map.get(territory, %{})
      |> Map.get("events", [])

    result =
      bank_holidays
      |> Enum.find(&(&1["date"] >= date))

    {:reply, result, state}
  end
end
