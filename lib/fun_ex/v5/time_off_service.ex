defmodule FunEx.V5.TimeOffService do
  require Logger

  def next_holiday(date, read_fn \\ &File.read/1) do
    with {:ok, date} <- Date.from_iso8601(date),
         {:ok, json} <- read_fn.("bank_holidays.json"),
         {:ok, data} <- Jason.decode(json) do
      bank_holidays = data
        |> Map.get("england-and-wales", %{})
        |> Map.get("events", [])

      find_next_date(bank_holidays, date)
    else
      {:error, msg} ->
        Logger.error("Unable to find next date: #{msg}")
        false
    end
  end

  def find_next_date(bank_holidays, date) do
    bank_holidays
    |> Enum.find(fn(bank_holiday) ->
      {:ok, bank_holiday_date} = bank_holiday
        |> Map.get("date", "1970-01-01")
        |> Date.from_iso8601()

      Timex.diff(bank_holiday_date, date) >= 0
    end)
  end
end
