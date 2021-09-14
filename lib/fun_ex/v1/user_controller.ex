defmodule FunEx.V1.UserController do
  # use FunEx, :controller

  def allowed?(conn, %{"email" => email}) do
    {:ok, json} = File.read("list.json")
    {:ok, data} = Jason.decode(json)

    result =
      data
      |> Enum.map(&Map.get(&1, "email", ""))
      |> Enum.map(&String.downcase/1)
      |> Enum.any?(&(&1 == email))

    # render(conn, "temp.html", allowed: result)
  end
end
