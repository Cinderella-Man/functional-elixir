defmodule FunEx.V13.TimeOffService do
  require Logger

  alias FunEx.V12.StorageService

  @storage_service Application.get_env(:fun_ex, :storage_service, StorageService)
  @logger Application.get_env(:fun_ex, :logger, Logger)

  def next_holiday(date, territory) do
    fn -> Date.from_iso8601(date) end
    |> x_fold(
      fn _date ->
        @storage_service.fetch_holidays()
        |> x_apply(&find_next_date(&1, date, territory))
      end,
      &{:error, &1}
    )
    |> x_fold(& &1, fn error ->
      Logger.error("Time Off service error occurred: #{inspect(error)}")
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

  def x_apply({:ok, data}, function) do
    {:ok, function.(data)}
  end

  def x_apply({:error, error}, _function), do: {:error, error}

  def x_fold(acc, success_fn, error_fn) do
    fn ->
      case acc.() do
        {:ok, data} -> success_fn.(data)
        {:error, error} -> error_fn.(error)
      end
    end
  end
end
