defmodule FunEx.V6.TimeOffService do
  require Logger

  def next_holiday(date_string, territory, opts \\ []) do
    read_fn = Keyword.get(opts, :read_fn, &File.read/1)

    case Date.from_iso8601(date_string) do
      {:ok, date} ->
        case read_fn.("bank_holidays.json") do
          {:ok, json} ->
            case Jason.decode(json) do
              {:ok, data} -> find_next_date(data, date, territory)
              _ -> Logger.error("Unable to decode JSON")
            end

          _ ->
            Logger.error("Unable to read bank holidays file")
        end

      _ ->
        Logger.warn("Invalid date passed")
    end
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
end
