defmodule FunEx.V7.TimeOffService do
  alias FunEx.V7.StorageService

  @storage_service Application.get_env(:fun_ex, :storage_service, StorageService)

  def next_holiday(date, territory) do
    {:ok, data} = @storage_service.fetch_holidays()

    find_next_date(data, date, territory)
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
