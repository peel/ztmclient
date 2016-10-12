defmodule Ztm.Ticker do
  use GenServer
  alias Ztm.Relations

  def start_link(_args \\ []) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state) do
    timer = Process.send_after(self(), :watch, 60_000)
    {:ok, %{timer: timer}}
  end
  
  def handle_info(:watch, state) do
    timer = Process.send_after(self(), :watch, 60_000)
    Relations.print_stops_now
    {:noreply, %{timer: timer}}
  end
  
  def handle_info(_, state) do
    {:ok, state}
  end
  
end
