defmodule Net.SSDP do

	def discover(:hue_bridges) do
		Nerves.SSDPClient.discover(target: "urn:schemas-upnp-org:device:basic:1", seconds: 5)
		|> Enum.filter(fn {_k, v} ->
			Map.has_key?(v, :"hue-bridgeid") && Map.has_key?(v, :host)
		end)
		|> Enum.map(fn {_k, v} -> Map.get(v, :host) end)
		|> Enum.reject(&is_nil/1)
		|> Enum.uniq()
	end

	def discover(:sonos) do
		{:error, "not implemented yet"}
	end

end
