defmodule FunEx.V9.TimeOffService do
  require Logger

  def next_holiday(date_string, territory, read_fn \\ &File.read/1) do
    (fn () -> read_fn.("bank_holidays.json") end)
    |> chain(&Jason.decode/1)
    |> fold(fn (data) ->
      Date.from_iso8601(date_string)
        |> fapply(&find_next_date(data, &1, territory))
    end, &{:error, &1})
    |> fold(& &1, fn error ->
      Logger.error("Time Off service error occurred: #{inspect(error)}")
      false
    end)
  end

  def find_next_date(data, date, territory) do
    bank_holidays = data
      |> Map.get(territory, %{})
      |> Map.get("events", [])

    bank_holidays
    |> Enum.find(fn(bank_holiday) ->
      {:ok, bank_holiday_date} = bank_holiday
        |> Map.get("date", "1970-01-01")
        |> Date.from_iso8601()

      Timex.diff(bank_holiday_date, date) >= 0
    end)
  end

  def chain(acc, function) do
    fn () ->
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
    fn () ->
      case acc.() do
        {:ok, data} -> Enum.map(data, iteration_fn)
        {:error, error} -> {:error, error}
      end
    end
  end

  def fold(acc, success_fn, error_fn) do
    fn () ->
      case acc.() do
        {:ok, data} -> success_fn.(data)
        {:error, error} -> error_fn.(error)
      end
    end
  end
end
