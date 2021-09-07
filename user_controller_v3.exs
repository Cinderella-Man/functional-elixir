defmodule MyAppWeb.UserControllerV3 do
  use MyAppWeb, :controller

  def store(conn, %{"name" => name}) do
    date = DateTime.utc_now()
    line = MyApp.UserServiceV3.store(name, date)
    render(conn, "store.html", line: line)
  end
end



