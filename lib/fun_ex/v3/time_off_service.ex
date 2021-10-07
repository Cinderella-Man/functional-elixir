defmodule FunEx.V3.TimeOffService do
  require Logger

  def next_holiday(date_string, territory, read_fn, log_info_fn) do
    {:ok, date} = Date.from_iso8601(date_string)

    log_info_fn.("Fetching bank holidays")

    {:ok, json} = read_fn.("bank_holidays.json")
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
