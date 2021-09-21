defmodule FunEx.V2.TimeOffController do
  # use FunEx, :controller

  def next_holiday(conn, %{"date" => date}) do
    result = FunEx.V2.TimeOffService.next_holiday(date, &File.read/1)
    # render(conn, "temp.html", result: result)
  end
end
