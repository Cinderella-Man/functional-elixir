defmodule MyApp.UserServiceV5 do
  def store(name, date \\ DateTime.utc_now(), write_fn \\ &File.write/3) do
    line = prepare_line(name, date)
    case write_fn.("temp.txt", line <> "\n", [:append]) do
      :ok -> if date.hour > 19 do
               Logger.info("Storing data for #{name} outside of working hours!")
            end
            {:ok, line}
      {:error, msg} -> Logger.error("Error occurred when storing data: #{msg}")
                       {:error, :failed_to_store}
    end
  end

  def prepare_line(name, date) do
    ymd = "#{date.year}-#{date.month}-#{date.day}"

    name
      |> String.split(" ")
      |> Kernel.++([ymd])
      |> Enum.join(",")
  end
end