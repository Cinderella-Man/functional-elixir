defmodule MyAppWeb.UserControllerV3 do
  use MyAppWeb, :controller

  def store(conn, %{"name" => name}) do
    date = DateTime.utc_now()
    write_fn = &File.write!/3
    line = MyApp.UserServiceV3.store(name, date, write_fn)
    render(conn, "store.html", line: line)
  end
end



