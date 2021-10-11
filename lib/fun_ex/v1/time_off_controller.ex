defmodule FunEx.V1.TimeOffController do
  use FunEx, :controller

  require Logger

  def next_holiday(conn, %{"date" => date, "territory" => territory}) do
    {:ok, _date} = Date.from_iso8601(date)

    Logger.info("Fetching bank holidays")

    {:ok, json} = File.read("bank_holidays.json")
    {:ok, data} = Jason.decode(json)

    bank_holidays =
      data
      |> Map.get(territory, %{})
      |> Map.get("events", [])

    result =
      bank_holidays
      |> Enum.find(&(&1["date"] >= date))

    render(conn, "index.json", result: result)
  end
end
