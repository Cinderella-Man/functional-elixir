defmodule FunEx.V3.UserService do
  def allowed?(email, read_fn) do
    {:ok, json} = read_fn.("list.json")
    check_email(json, email)
  end

  def check_email(json, email) do
    {:ok, data} = Jason.decode(json)

    data
    |> Enum.map(&Map.get(&1, "email", ""))
    |> Enum.map(&String.downcase/1)
    |> Enum.any?(&(&1 == email))
  end
end
