defmodule MyApp.UserServiceV2 do
  def store(name, date) do
    ymd = "#{date.year}-#{date.month}-#{date.day}"

    name
      |> String.split(" ")
      |> Kernel.++([ymd])
      |> Enum.join(",")
  end
end