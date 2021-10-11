defmodule FunEx.V10.StorageService do
  require Logger

  @logger Application.get_env(:fun_ex, :logger, Logger)

  def fetch_holidays() do
    @logger.info("Fetching bank holidays")

    {:ok, json} = File.read("bank_holidays.json")
    Jason.decode(json)
  end
end
