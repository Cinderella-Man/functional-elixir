defmodule FunEx.V4.TimeOffService do
  require Logger

  def next_holiday(date, territory, opts \\ []) do
    read_fn = Keyword.get(opts, :read_fn, &File.read/1)
    log_info_fn = Keyword.get(opts, :log_info_fn, &Logger.info/1)

    {:ok, _date} = Date.from_iso8601(date)

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
