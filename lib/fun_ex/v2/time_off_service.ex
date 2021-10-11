defmodule FunEx.V2.TimeOffService do
  require Logger

  def next_holiday(date, territory) do
    Logger.info("Fetching bank holidays")

    {:ok, json} = File.read("bank_holidays.json")
    {:ok, data} = Jason.decode(json)

    bank_holidays =
      data
      |> Map.get(territory, %{})
      |> Map.get("events", [])

    bank_holidays
    |> Enum.find(&(&1["date"] >= date))
  end
end
