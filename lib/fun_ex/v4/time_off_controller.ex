defmodule FunEx.V4.TimeOffController do
  # use FunEx, :controller

  def next_holiday(conn, %{"date" => date}) do
    result = FunEx.V4.TimeOffService.next_holiday(date)
    # render(conn, "temp.html", result: result)
  end
end
