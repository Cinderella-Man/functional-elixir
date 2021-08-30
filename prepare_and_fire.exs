defmodule X do
  def store_data(name) do
    d = DateTime.utc_now()
    date = "#{d.year}-#{d.month}-#{d.day}"

    line = name
      |> String.split(" ")
      |> Kernel.++([date])
      |> Enum.join(",")
      |> Kernel.<>("\n")
    
    File.write!("temp.txt", line, [:append])
  end
end