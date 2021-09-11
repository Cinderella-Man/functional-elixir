defmodule MyAppWeb.UserControllerV6 do
  use MyAppWeb, :controller

  def store(conn, %{"name" => name}) do
    line = MyApp.UserServiceV6.store(name)
    render(conn, "store.html", line: line)
  end
end



