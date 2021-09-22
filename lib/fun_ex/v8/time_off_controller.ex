defmodule FunEx.V8.TimeOffController do
  # use FunEx, :controller

  def next_holiday(conn, %{"date" => date, "territory" => territory}) do
    result = FunEx.V8.TimeOffService.next_holiday(date, territory)
    # render(conn, "temp.html", result: result)
  end
end
