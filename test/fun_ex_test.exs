defmodule FunExTest do
  use ExUnit.Case
  doctest FunEx

  test "greets the world" do
    assert FunEx.hello() == :world
  end
end
