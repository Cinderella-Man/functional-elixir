defmodule FunEx.V7.StorageService do
  require Logger

  @logger Application.get_env(:fun_ex, :logger, Logger)
  @file_module Application.get_env(:fun_ex, :file, File)

  def fetch_holidays() do
    @logger.info("Fetching bank holidays")

    {:ok, json} = @file_module.read("bank_holidays.json")
    Jason.decode(json)
  end
end
