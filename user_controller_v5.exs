defmodule MyAppWeb.UserControllerV5 do
  use MyAppWeb, :controller

  def store(conn, %{"name" => name}) do
    line = MyApp.UserServiceV5.store(name)
    render(conn, "store.html", line: line)
  end
end



