defmodule FunEx.V10.TimeOffController do
  use FunEx, :controller

  def next_holiday(conn, %{"date" => date, "territory" => territory}) do
    result = FunEx.V10.TimeOffService.next_holiday(date, territory)
    render(conn, "index.json", result: result)
  end
end
