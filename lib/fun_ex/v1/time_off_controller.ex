defmodule FunEx.V1.TimeOffController do
  # use FunEx, :controller

  def next_holiday(conn, %{"date" => date_string, "territory" => territory}) do
    {:ok, date} = Date.from_iso8601(date_string)
    {:ok, json} = File.read("bank_holidays.json")
    {:ok, data} = Jason.decode(json)

    bank_holidays = data
      |> Map.get(territory, %{})
      |> Map.get("events", [])

    result =
      bank_holidays
      |> Enum.find(fn(bank_holiday) ->
        {:ok, bank_holiday_date} = bank_holiday
          |> Map.get("date", "1970-01-01")
          |> Date.from_iso8601()

        Timex.diff(bank_holiday_date, date) >= 0
      end)

    # render(conn, "temp.html", result: result)
  end
end
