defmodule Heating.Control do
  use GenServer

  require Logger

  @name __MODULE__

  def start_control do
    GenServer.start_link(__MODULE__, %{:timer => nil, :temperature => nil}, name: @name)
  end

  def init(state) do
    timer = Process.send_after(self(), :work, 0)
    {:ok, %{state | :timer => timer}}
  end

  def set_temperature(temperature) do
    GenServer.cast(@name, {:temperature, temperature})
  end

  def handle_cast({:temperature, temperature}, state) do
    Logger.debug("Cancelling timer: " <> inspect state)

    Process.cancel_timer(state.timer)

    Logger.debug("Setting temperature: " <> inspect temperature)
    timer = Process.send_after(self(), :work, 0)

    {:noreply, %{state | :timer => timer, :temperature => temperature}}
  end

  def handle_info(:work, state) do
    # Do the work you desire here
    Logger.debug("Sending signal: " <> inspect state)

    # Start the timer again
    timer = Process.send_after(self(), :work, 10 * 1000)

    {:noreply, %{state | :timer => timer}}
  end

end
