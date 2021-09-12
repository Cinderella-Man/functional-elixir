# Functional Elixir

The source code used to explain functional programming concepts in Elixir inside [Functional Elixir](https://www.youtube.com/c/kamilskowron).

### How to use

The video goes through iterations of code starting with version `V1` in the `FunEx.V1` namespace going up to `V4` in the `FunEx.V4` namespace.

Example of calling `V1`:

```
$ iex -S mix
...
iex(1)> FunEx.V1.UserController.allowed?(nil, %{"email" => "test@example.com"})
true
iex(2)> FunEx.V1.UserController.allowed?(nil, %{"email" => "missing@example.com"})
false
iex(3)> {:ok, pid} = FunEx.V1.UserGenServer.start_link(nil)
{:ok, #PID<0.193.0>}
iex(4)> GenServer.call(pid, {:allowed?, "test@example.com"})
true
iex(5)> GenServer.call(pid, {:allowed?, "missing@example.com"})
false
```
