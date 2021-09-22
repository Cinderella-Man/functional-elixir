defmodule FunEx.V7.TimeOffService do
  require Logger

  def next_holiday(date, territory, read_fn \\ &File.read/1) do
    # (fn () -> read_fn.("list.json") end)
    # |> chain(&Jason.decode/1)
    # |> fapply(&check_email(&1, email))
    # |> fold(& &1, fn error ->
    #   Logger.error("User service error occurred")
    #   IO.inspect(error)
    #   false
    # end)
  end

  def find_next_date(bank_holidays, date, territory) do
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

  def fapply(acc, function) do
    fn () ->
      case acc.() do
        {:ok, data} -> {:ok, function.(data)}
        {:error, error} -> {:error, error}
      end
    end
  end

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
