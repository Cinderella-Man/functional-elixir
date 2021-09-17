defmodule FunEx.V6.UserService do
  require Logger

  def allowed?(email, read_fn \\ &File.read/1) do
    task(fn () -> read_fn.("list.json") end)
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

  def task(function) do
    fn () ->
      function.()
    end
  end

  def chain(acc, function) do
    fn () ->
      case acc.() do
        {:ok, data} -> function.(data)
        {:error, error} -> {:error, error}
      end
    end
  end

  # def chain({:ok, data}, function), do: function.(data)
  # def chain({:error, error}, _function), do: {:error, error}

  def fapply(acc, function) do
    fn () ->
      case acc.() do
        {:ok, data} -> {:ok, function.(data)}
        {:error, error} -> {:error, error}
      end
    end
  end

  # def fapply({:ok, data}, function) do
  #   {:ok, function.(data)}
  # end
  # def fapply({:error, error}, _function), do: {:error, error}

  def map(acc, iteration_fn) do
    fn () ->
      case acc.() do
        {:ok, data} -> Enum.map(data, iteration_fn)
        {:error, error} -> {:error, error}
      end
    end
  end

  # def map({:ok, data}, iteration_fn) do
  #   {:ok, Enum.map(data, iteration_fn)}
  # end
  # def map({:error, error}, _iteration_fn), do: {:error, error}

  def fold(acc, success_fn, error_fn) do
    fn () ->
      case acc.() do
        {:ok, data} -> success_fn.(data)
        {:error, error} -> error_fn.(error)
      end
    end
  end

  # def fold({:ok, data}, success_fn, _error_fn), do: success_fn.(data)
  # def fold({:error, error}, _success_fn, error_fn), do: error_fn.(error)
end
