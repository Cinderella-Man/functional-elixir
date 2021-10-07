defmodule FunEx.V11.TimeOffService do
  require Logger

  alias FunEx.V11.StorageService

  @storage_service Application.get_env(:fun_ex, :storage_service, StorageService)
  @logger Application.get_env(:fun_ex, :logger, Logger)

  def next_holiday(date_string, territory) do
    with {:ok, date} <- Date.from_iso8601(date_string),
         {:ok, data} <- @storage_service.fetch_holidays() do
      find_next_date(data, date, territory)
    else
      {:error, msg} ->
        @logger.error("Unable to find next date: #{msg}")
        false
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
