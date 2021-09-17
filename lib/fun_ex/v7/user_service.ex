defmodule FunEx.V7.UserService do
  require Logger

  def allowed?(email, read_fn \\ &File.read/1) do
    (fn () -> read_fn.("list.json") end)
    |> chain(&Jason.decode/1)
    |> fapply(&check_email(&1, email))
    |> fold(& &1, fn error ->
      Logger.error("User service error occurred")
      IO.inspect(error)
      false
    end)
  end

  def check_email(data, email) do
    data
    |> Enum.map(&Map.get(&1, "email", ""))
    |> Enum.map(&String.downcase/1)
    |> Enum.any?(& &1 == email)
  end

  def chain(acc, function) do
    fn () ->
      case acc.() do
        {:ok, data} -> function.(data)
        {:error, error} -> {:error, error}
      end
    end
  end

  def fapply(acc, function) do
    fn () ->
      case acc.() do
        {:ok, data} -> {:ok, function.(data)}
        {:error, error} -> {:error, error}
      end
    end
  end

  def map(acc, iteration_fn) do
    fn () ->
      case acc.() do
        {:ok, data} -> Enum.map(data, iteration_fn)
        {:error, error} -> {:error, error}
      end
    end
  end

  def fold(acc, success_fn, error_fn) do
    fn () ->
      case acc.() do
        {:ok, data} -> success_fn.(data)
        {:error, error} -> error_fn.(error)
      end
    end
  end
end
