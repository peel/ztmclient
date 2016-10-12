defmodule Ztm.Ticker do
  use GenServer
  alias Ztm.Relations

  def start_link(default \\ []) do
    GenServer.start_link(__MODULE__, %{}, name: default) 
  end

  def init(_state) do
    timer = Process.send_after(self(), :watch, 0)
    {:ok, %{timer: timer}}
  end
  
  def handle_info(:watch, _state) do
    timer = Process.send_after(self(), :watch, 60_000)
    Relations.print_stops_now
    {:noreply, %{timer: timer}}
  end
  
  def handle_info(_, state) do
    {:ok, state}
  end
  
end
