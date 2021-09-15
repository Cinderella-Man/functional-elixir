defmodule FunEx.V5.UserService do
  require Logger

  def allowed?(email, read_fn \\ &File.read/1) do
    with {:ok, json} <- read_fn.("list.json"),
         {:ok, data} <- Jason.decode(json)
    do
      check_email(data, email)
    else
      {:error, msg} ->
        Logger.error("User service error occurred: #{msg}")
        false
    end
  end

  def check_email(data, email) do
    data
    |> Enum.map(&Map.get(&1, "email", ""))
    |> Enum.map(&String.downcase/1)
    |> Enum.any?(&(&1 == email))
  end
end
