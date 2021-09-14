defmodule FunEx.V6.UserService do
  require Logger

  def allowed?(email, read_fn \\ &File.read/1) do
    read_fn.("list.json")
    |> chain(&check_email(&1, email))
    |> fold(& &1, fn error ->
      Logger.error("User service error occurred")
      IO.inspect(error)
      false
    end)
  end

  def check_email(json, email) do
    Jason.decode(json)
    |> map(&Map.get(&1, "email", ""))
    |> map(&String.downcase/1)
    |> fapply(&Enum.any?(&1, fn e -> e == email end))
  end

  def map({:ok, data}, iteration_fn) do
    {:ok, Enum.map(data, iteration_fn)}
  end

  def map({:error, error}, _iteration_fn), do: {:error, error}

  def fapply({:ok, data}, function) do
    {:ok, function.(data)}
  end

  def fapply({:error, error}, _function), do: {:error, error}

  def chain({:ok, data}, function), do: function.(data)
  def chain({:error, error}, _function), do: {:error, error}

  def fold({:ok, data}, success_fn, _error_fn), do: success_fn.(data)
  def fold({:error, error}, _success_fn, error_fn), do: error_fn.(error)
end
