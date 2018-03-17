defmodule Heating.Tracker do
  use GenServer

  require Logger

  @interval 1 * 60 # 1 minute

  def start_link([url, data, field]) do
    GenServer.start_link(__MODULE__, %{:url => url, :data => data,
      :field => field, :timer => nil, :response => nil})
  end

  def init(state) do
    timer = Process.send_after(self(), :work, 0)
    {:ok, %{state | :timer => timer}}
  end

  def handle_info(:work, state) do
    # Restart the timer first to avoid drift
    timer = Process.send_after(self(), :work, @interval * 1000)

    Logger.debug("Fetching data: " <> inspect state)
    response = fetch_data(state.url, state.field)

    if response != nil do
      Logger.debug("Sending to db: " <> inspect response)
      data = %{ state.data | fields: %{ state.data.fields | value: response }}
      Heating.Connection.write(data)
    end

    {:noreply, %{state | :timer => timer, :response => response}}
  end

  defp fetch_data(url, field) do
    response = url
      |> HTTPoison.get([], [timeout: 5000])
      |> handle_json

    case response do
      {:ok, body} ->
        body[field]
      {:error, _} ->
        nil
    end
  end

  defp handle_json({:ok, %{status_code: 200, body: body}}) do
    Logger.debug("Got response from pipiriukas: " <> inspect body)
    {:ok, Poison.Parser.parse!(body, keys: :atoms!)}
  end

  defp handle_json({_, response}) do
    Logger.error("Could not fetch data" <> inspect response)
    {:error, response}
  end
end
