defmodule FunEx.V2.TimeOffService do
  def next_holiday(date, read_fn) do
    {:ok, date} = Date.from_iso8601(date)
    {:ok, json} = read_fn.("bank_holidays.json")
    {:ok, data} = Jason.decode(json)

    bank_holidays = data
      |> Map.get("england-and-wales", %{})
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
