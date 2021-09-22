defmodule FunEx.V4.TimeOffService do
  def next_holiday(date_string, territory, read_fn \\ &File.read/1) do
    {:ok, date} = Date.from_iso8601(date_string)
    {:ok, json} = read_fn.("bank_holidays.json")
    {:ok, data} = Jason.decode(json)

    find_next_date(data, date, territory)
  end

  def find_next_date(data, date, territory) do
    bank_holidays = data
      |> Map.get(territory, %{})
      |> Map.get("events", [])

    bank_holidays
    |> Enum.find(fn(bank_holiday) ->
      {:ok, bank_holiday_date} = bank_holiday
        |> Map.get("date", "1970-01-01")
        |> Date.from_iso8601()

      Timex.diff(bank_holiday_date, date) >= 0
    end)
  end
end
