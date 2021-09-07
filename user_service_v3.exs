defmodule MyApp.UserServiceV3 do
  def store(name, date) do
    ymd = "#{date.year}-#{date.month}-#{date.day}"

    line = name
      |> String.split(" ")
      |> Kernel.++([ymd])
      |> Enum.join(",")

    File.write!("temp.txt", line <> "\n", [:append])
    line
  end
end