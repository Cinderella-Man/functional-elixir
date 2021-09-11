defmodule MyAppWeb.UserControllerV1 do
  use MyAppWeb, :controller

  def allowed?(conn, %{"email" => email_address}) do
    {:ok, data} = File.read("list.txt")

    line = data
      |> String.split("\n", trim: true)
      |> Enum.map(&(String.split(&1, ",")))
      |> Enum.find(fn([_, _, email] -> email == email_address) 
      |> Enum.join(",")

    render(conn, "temp.html", line: line)
  end
end



