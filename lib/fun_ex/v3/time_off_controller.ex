defmodule FunEx.V3.TimeOffController do
  use FunEx, :controller

  require Logger

  def next_holiday(conn, %{"date" => date, "territory" => territory}) do
    result =
      FunEx.V3.TimeOffService.next_holiday(
        date,
        territory,
        &File.read/1,
        &Logger.info/1
      )

    render(conn, "index.json", result: result)
  end
end
