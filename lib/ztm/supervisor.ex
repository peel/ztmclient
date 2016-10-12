defmodule Ztm.Supervisor do
  use Supervisor

  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = [
      worker(Ztm.Ticker, [])
    ]
    supervise(children, strategy: :one_for_one)
  end
  
end
