defmodule MyAppWeb.UserControllerV1 do
  use MyAppWeb, :controller

  def store(conn, %{"name" => name}) do
    d = DateTime.utc_now()
    ymd = "#{d.year}-#{d.month}-#{d.day}"

    line = name
      |> String.split(" ")
      |> Kernel.++([ymd])
      |> Enum.join(",")

    render(conn, "temp.html", line: line)
  end
end



