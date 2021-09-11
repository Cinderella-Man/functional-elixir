defmodule MyAppWeb.UserControllerV2 do
  use MyAppWeb, :controller

  def store(conn, %{"name" => name}) do
    date = DateTime.utc_now()
    line = MyApp.UserServiceV2.store(name, date)
    render(conn, "store.html", line: line)
  end
end



