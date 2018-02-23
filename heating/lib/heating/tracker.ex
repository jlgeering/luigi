defmodule Heating.Tracker do
  use GenServer

  require Logger

  @name __MODULE__
  @interval 1 * 60 # 1 minute

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{:timer => nil, :temperature => nil}, name: @name)
  end

  def init(state) do
    timer = Process.send_after(self(), :work, 0)
    {:ok, %{state | :timer => timer}}
  end

  def handle_info(:work, state) do
    # Restart the timer first to avoid drift
    timer = Process.send_after(self(), :work, @interval * 1000)

    Logger.debug("Fetching temperature: " <> inspect state)
    temperature = fetch_temperature()

    if temperature != nil do
      data = %Temperature{}
      data = %{ data | fields: %{ data.fields | value: temperature }}
      Heating.Connection.write(data)
    end

    {:noreply, %{state | :timer => timer, :temperature => temperature}}
  end

  defp fetch_temperature() do
    response = temperature_url()
      |> HTTPoison.get([], [timeout: 5000])
      |> handle_json

    case response do
      {:ok, body} ->
        body.temperature
      {:error, _} ->
        nil
    end
  end

  defp temperature_url() do
    "http://192.168.0.52/temperature"
  end

  defp handle_json({:ok, %{status_code: 200, body: body}}) do
    Logger.debug("Got response from pipiriukas: " <> inspect body)
    {:ok, Poison.Parser.parse!(body, keys: :atoms!)}
  end

  defp handle_json({_, response}) do
    Logger.error("Could not fetch temperature" <> inspect response)
    {:error, response}
  end
end
