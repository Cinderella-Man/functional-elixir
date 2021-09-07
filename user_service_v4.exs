defmodule MyApp.UserServiceV4 do
  def store(name) do
    date = DateTime.utc_now()
    line = prepare_line(name, date)
    File.write!("temp.txt", line <> "\n", [:append])
    line
  end

  def prepare_line(name, date) do
    ymd = "#{date.year}-#{date.month}-#{date.day}"

    name
      |> String.split(" ")
      |> Kernel.++([ymd])
      |> Enum.join(",")
  end
end