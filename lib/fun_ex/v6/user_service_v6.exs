defmodule MyApp.UserServiceV6 do
  def store(name, date \\ DateTime.utc_now(), write_fn \\ &File.write/3) do
    line = prepare_line(name, date)
    write_fn.("temp.txt", line <> "\n", [:append])
    |> maybe_log(date.hour, name, line)
    end
  end

  def maybe_log(:ok, hour, name, line) when hour > 19 do
    Logger.info("Storing data for #{name} outside of working hours!")
    {:ok, line}
  end

  def maybe_log(:ok, _hour, name, line), do: {:ok, line}

  def maybe_log({:error, msg}, _hour, _name, _line) do
    Logger.info("Error occurred when storing data: #{msg}")
    {:error, :failed_to_store}
  end  

  def prepare_line(name, date) do
    ymd = "#{date.year}-#{date.month}-#{date.day}"

    name
      |> String.split(" ")
      |> Kernel.++([ymd])
      |> Enum.join(",")
  end
end