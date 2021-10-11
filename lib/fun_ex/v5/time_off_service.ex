defmodule FunEx.V5.TimeOffService do
  require Logger

  @logger Application.get_env(:fun_ex, :logger, Logger)
  @file_module Application.get_env(:fun_ex, :file, File)

  def next_holiday(date, territory) do
    {:ok, _date} = Date.from_iso8601(date)

    @logger.info("Fetching bank holidays")

    {:ok, json} = @file_module.read("bank_holidays.json")
    {:ok, data} = Jason.decode(json)

    bank_holidays =
      data
      |> Map.get(territory, %{})
      |> Map.get("events", [])

    bank_holidays
    |> Enum.find(&(&1["date"] >= date))
  end
end
