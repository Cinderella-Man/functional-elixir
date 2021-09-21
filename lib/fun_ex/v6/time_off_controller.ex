defmodule FunEx.V6.TimeOffController do
  # use FunEx, :controller

  def next_holiday(conn, %{"date" => date}) do
    result = FunEx.V6.TimeOffService.next_holiday(date)
    # render(conn, "temp.html", result: result)
  end
end
