defmodule FunEx.V9.TimeOffService do
  require Logger

  alias FunEx.V9.StorageService

  @storage_service Application.get_env(:fun_ex, :storage_service, StorageService)
  @logger Application.get_env(:fun_ex, :logger, Logger)

  def next_holiday(date_string, territory) do
    {:ok, date} = Date.from_iso8601(date_string)

    @storage_service.fetch_holidays()
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

  def chain({:ok, data}, function), do: function.(data)
  def chain({:error, error}, _function), do: {:error, error}

  def fapply({:ok, data}, function) do
    {:ok, function.(data)}
  end

  def fapply({:error, error}, _function), do: {:error, error}

  def map({:ok, data}, iteration_fn) do
    {:ok, Enum.map(data, iteration_fn)}
  end

  def map({:error, error}, _iteration_fn), do: {:error, error}

  def fold({:ok, data}, success_fn, _error_fn), do: success_fn.(data)
  def fold({:error, error}, _success_fn, error_fn), do: error_fn.(error)
end
