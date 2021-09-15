defmodule FunEx.V4.UserService do
  def allowed?(email, read_fn \\ &File.read/1) do
    {:ok, json} = read_fn.("list.json")
    {:ok, data} = Jason.decode(json)
    check_email(data, email)
  end

  def check_email(data, email) do
    data
    |> Enum.map(&Map.get(&1, "email", ""))
    |> Enum.map(&String.downcase/1)
    |> Enum.any?(&(&1 == email))
  end
end
