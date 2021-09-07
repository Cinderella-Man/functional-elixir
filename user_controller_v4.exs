defmodule MyAppWeb.UserControllerV4 do
  use MyAppWeb, :controller

  def store(conn, %{"name" => name}) do
    line = MyApp.UserServiceV4.store(name)
    render(conn, "store.html", line: line)
  end
end



