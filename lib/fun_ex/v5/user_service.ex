defmodule FunEx.V5.UserService do
  require Logger

  def allowed?(email, read_fn \\ &File.read/1) do
    case read_fn.("list.json") do
      {:ok, json} ->
        check_email(json, email)

      {:error, msg} ->
        Logger.error("User service error occurred: #{msg}")
        false
    end
  end

  def check_email(json, email) do
    case Jason.decode(json) do
      {:ok, data} ->
        data
        |> Enum.map(&Map.get(&1, "email", ""))
        |> Enum.map(&String.downcase/1)
        |> Enum.any?(&(&1 == email))

      {:error, msg} ->
        Logger.error("User service error occurred")
        IO.inspect(msg)
        false
    end
  end
end
