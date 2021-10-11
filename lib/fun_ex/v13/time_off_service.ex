defmodule FunEx.V13.TimeOffService do
  require Logger

  alias FunEx.V12.StorageService

  @storage_service Application.get_env(:fun_ex, :storage_service, StorageService)
  @logger Application.get_env(:fun_ex, :logger, Logger)

  def next_holiday(date, territory) do
    fn -> Date.from_iso8601(date) end
    |> fold(
      fn _date ->
        @storage_service.fetch_holidays()
        |> fapply(&find_next_date(&1, date, territory))
      end,
      &{:error, &1}
    )
    |> fold(& &1, fn error ->
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

  def chain(acc, function) do
    fn ->
      case acc.() do
        {:ok, data} -> function.(data)
        {:error, error} -> {:error, error}
      end
    end
  end

  # def fapply(acc, function) do
  #   fn () ->
  #     case acc.() do
  #       {:ok, data} -> {:ok, function.(data)}
  #       {:error, error} -> {:error, error}
  #     end
  #   end
  # end

  def fapply({:ok, data}, function) do
    {:ok, function.(data)}
  end

  def fapply({:error, error}, _function), do: {:error, error}

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
