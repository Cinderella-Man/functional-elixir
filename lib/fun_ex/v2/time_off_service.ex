defmodule FunEx.V2.TimeOffService do
  require Logger

  def next_holiday(date_string, territory) do
    {:ok, date} = Date.from_iso8601(date_string)

    Logger.info("Fetching bank holidays")

    {:ok, json} = File.read("bank_holidays.json")
    {:ok, data} = Jason.decode(json)

    bank_holidays =
      data
      |> Map.get(territory, %{})
      |> Map.get("events", [])

    bank_holidays
    |> Enum.find(fn bank_holiday ->
      {:ok, bank_holiday_date} =
        bank_holiday
        |> Map.get("date", "2020-01-01")
        |> Date.from_iso8601()

      Timex.diff(bank_holiday_date, date) >= 0
    end)
  end
end
