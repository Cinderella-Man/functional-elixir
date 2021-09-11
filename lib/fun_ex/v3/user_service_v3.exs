defmodule MyApp.UserServiceV3 do
  def store(name, date, write_fn) do
    ymd = "#{date.year}-#{date.month}-#{date.day}"

    line = name
      |> String.split(" ")
      |> Kernel.++([ymd])
      |> Enum.join(",")

    :ok = write_fn.("temp.txt", line <> "\n", [:append])
    line
  end
end