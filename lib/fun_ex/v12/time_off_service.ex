defmodule FunEx.V12.TimeOffService do
  require Logger

  alias FunEx.V12.StorageService

  @storage_service Application.get_env(:fun_ex, :storage_service, StorageService)
  @logger Application.get_env(:fun_ex, :logger, Logger)

  def next_holiday(date_string, territory) do
    {:ok, date} = Date.from_iso8601(date_string)

    fn -> @storage_service.fetch_holidays() end
    |> fapply(&find_next_date(&1, date, territory))
    |> fold(& &1, fn error ->
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
    |> Enum.find(fn bank_holiday ->
      {:ok, bank_holiday_date} =
        bank_holiday
        |> Map.get("date", "2020-01-01")
        |> Date.from_iso8601()

      Timex.diff(bank_holiday_date, date) >= 0
    end)
  end

  def chain(acc, function) do
    fn ->
      case acc.() do
        {:ok, data} -> function.(data)
        {:error, error} -> {:error, error}
      end
    end
  end

  def fapply(acc, function) do
    fn ->
      case acc.() do
        {:ok, data} -> {:ok, function.(data)}
        {:error, error} -> {:error, error}
      end
    end
  end

  def map(acc, iteration_fn) do
    fn ->
      case acc.() do
        {:ok, data} -> Enum.map(data, iteration_fn)
        {:error, error} -> {:error, error}
      end
    end
  end

  def fold(acc, success_fn, error_fn) do
    fn ->
      case acc.() do
        {:ok, data} -> success_fn.(data)
        {:error, error} -> error_fn.(error)
      end
    end
  end
end
