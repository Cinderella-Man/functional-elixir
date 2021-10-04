defmodule FunEx do
  defmacro __using__(_opts) do
    quote location: :keep do
      def render(_conn, "index.json", data) do
        data
      end
    end
  end
end
