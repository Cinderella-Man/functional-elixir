defmodule FunEx.V8.TimeOffService do
  require Logger

  alias FunEx.V8.StorageService

  @storage_service Application.get_env(:fun_ex, :storage_service, StorageService)
  @logger Application.get_env(:fun_ex, :logger, Logger)

  def next_holiday(date, territory) do
    case Date.from_iso8601(date) do
      {:ok, _date} ->
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
    |> Enum.find(&(&1["date"] >= date))
  end
end
