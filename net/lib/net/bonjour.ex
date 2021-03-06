# see https://github.com/nerves-project/nerves_init_gadget/blob/master/lib/nerves_init_gadget/network_manager.ex
defmodule Net.Bonjour do
  use GenServer

  require Logger

  @interface Application.get_env(:firmware, :interface) |> Atom.to_string()
  @domain Application.get_env(:net, :bonjour)

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init(_opts) do
    # Register for updates from system registry
    SystemRegistry.register()
    init_mdns(@domain)

    {:ok, %{ip: nil}}
  end

  def handle_info({:system_registry, :global, registry}, state) do
    new_ip = get_in(registry, [:state, :network_interface, @interface, :ipv4_address])
    handle_ip_update(state, new_ip)
  end

  defp handle_ip_update(%{ip: old_ip} = state, new_ip) when old_ip == new_ip do
    # No change
    # Logger.debug("IP address: no change")
    {:noreply, state}
  end

  defp handle_ip_update(state, new_ip) do
    Logger.info("IP address for #{@interface} changed to #{new_ip}")
    update_mdns(new_ip, @domain)
    {:noreply, %{state | ip: new_ip}}
  end

  defp init_mdns(nil), do: :ok

  defp init_mdns(mdns_domain) do
    Mdns.Server.add_service(%Mdns.Server.Service{
      domain: mdns_domain,
      data: :ip,
      ttl: 120,
      type: :a
    })
  end

  defp update_mdns(_ip, nil), do: :ok

  defp update_mdns(ip, _mdns_domain) do
    ip_tuple = to_ip_tuple(ip)
    Mdns.Server.stop()

    # Give the interface time to settle to fix an issue where mDNS's multicast
    # membership is not registered. This occurs on wireless interfaces and
    # needs to be revisited.
    :timer.sleep(100)

    Mdns.Server.start(interface: ip_tuple)
    Mdns.Server.set_ip(ip_tuple)
  end

  defp to_ip_tuple(str) do
    str
    |> String.split(".")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

end
