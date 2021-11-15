defmodule FunEx.V12.TimeOffService do
  require Logger

  alias FunEx.V12.StorageService

  @storage_service Application.get_env(:fun_ex, :storage_service, StorageService)
  @logger Application.get_env(:fun_ex, :logger, Logger)

  def next_holiday(date, territory) do
    {:ok, _date} = Date.from_iso8601(date)

    fn -> @storage_service.fetch_holidays() end
    |> x_apply(&find_next_date(&1, date, territory))
    |> x_fold(& &1, fn error ->
      @logger.error("Time Off service error occurred: #{inspect(error)}")
      false
    end)
  end

  def find_next_date(data, date, territory) do
    bank_holidays =
      data
      |> Map.get(territory, %{})
      |> Map.get("events", [])

    bank_holidays
    |> Enum.find(&(&1["date"] >= date))
  end

  def x_apply(acc, function) do
    fn ->
      case acc.() do
        {:ok, data} -> {:ok, function.(data)}
        {:error, error} -> {:error, error}
      end
    end
  end

  def x_fold(acc, success_fn, error_fn) do
    fn ->
      case acc.() do
        {:ok, data} -> success_fn.(data)
        {:error, error} -> error_fn.(error)
      end
    end
  end
end
