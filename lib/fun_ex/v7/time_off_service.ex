defmodule FunEx.V7.TimeOffService do
  alias FunEx.V7.StorageService

  @storage_service Application.get_env(:fun_ex, :storage_service, StorageService)

  def next_holiday(date_string, territory) do
    {:ok, date} = Date.from_iso8601(date_string)
    {:ok, data} = @storage_service.fetch_holidays()

    find_next_date(data, date, territory)
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
