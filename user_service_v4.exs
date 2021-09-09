defmodule MyApp.UserServiceV4 do
  def store(name, date \\ DateTime.utc_now(), write_fn \\ &File.write/3) do
    line = prepare_line(name, date)
    :ok = write_fn.("temp.txt", line <> "\n", [:append])
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