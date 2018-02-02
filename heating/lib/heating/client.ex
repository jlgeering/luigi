defmodule Heating.Client do

  require Logger

  def turn_on() do
    Logger.debug("turning on")
    HTTPoison.get!("http://10.10.10.10/coucou")
  end

end
