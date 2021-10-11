defmodule FunEx.Behaviours do
  defmodule LoggerBehaviour do
    @type message :: binary

    @callback info(message) :: :ok
  end

  defmodule FileBehaviour do
    @type file_path :: binary
    @type data :: binary

    @callback read(file_path) :: {:ok, data}
  end

  defmodule StorageServiceBehaviour do
    @type data :: binary

    @callback fetch_holidays() :: {:ok, data}
  end
end
