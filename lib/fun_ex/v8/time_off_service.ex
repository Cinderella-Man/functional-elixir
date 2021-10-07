defmodule FunEx.V8.TimeOffService do
  require Logger

  alias FunEx.V8.StorageService

  @storage_service Application.get_env(:fun_ex, :storage_service, StorageService)
  @logger Application.get_env(:fun_ex, :logger, Logger)

  def next_holiday(date_string, territory) do
    case Date.from_iso8601(date_string) do
      {:ok, date} ->
        case @storage_service.fetch_holidays() do
          {:ok, data} ->
               find_next_date(data, date, territory)
          _ ->
            Logger.error("Unable to read bank holidays file")
        end

      _ ->
        Logger.warn("Invalid date passed")
    end
  end

  def find_next_date(data, date, territory) do
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
