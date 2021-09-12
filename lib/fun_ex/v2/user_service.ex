defmodule FunEx.V2.UserService do
  def allowed?(email, read_fn) do
    {:ok, json} = read_fn.("list.json")
    {:ok, data} = Jason.decode(json)

    result = data
      |> Enum.map(&(Map.get(&1, "email")))
      |> Enum.map(&(String.downcase/1))
      |> Enum.any?(&(&1 == email))
  end
end