defmodule FunEx.V6.TimeOffService do
  alias FunEx.V6.StorageService

  @storage_service Application.get_env(:fun_ex, :storage_service, StorageService)

  def next_holiday(date, territory) do
    {:ok, _date} = Date.from_iso8601(date)
    {:ok, data} = @storage_service.fetch_holidays()

    bank_holidays =
      data
      |> Map.get(territory, %{})
      |> Map.get("events", [])

    bank_holidays
    |> Enum.find(&(&1["date"] >= date))
  end
end
