defmodule FunEx.V3.TimeOffService do
  require Logger

  def next_holiday(date, territory, read_fn, log_info_fn) do
    log_info_fn.("Fetching bank holidays")

    {:ok, json} = read_fn.("bank_holidays.json")
    {:ok, data} = Jason.decode(json)

    bank_holidays =
      data
      |> Map.get(territory, %{})
      |> Map.get("events", [])

    bank_holidays
    |> Enum.find(&(&1["date"] >= date))
  end
end
