defmodule Ztm.Relation do
  defstruct [:line, :destination, :time]
end

defmodule Ztm.Relations do
  alias Ztm.Client
  alias Ztm.Relation

  def print_stops_now(stops \\ Ztm.stops) do
    stops_now(stops)
    |> Enum.map(fn(%{stop_name: stop_name, relations: relations}) ->
      IO.puts "\n #{stop_name}:"
      relations
      |> Enum.map(fn(relation) -> IO.puts "\t#{relation.time |> String.pad_trailing(9)} | #{relation.line |> String.pad_trailing(3)} =>  #{relation.destination}" end)
    end)
  end

  def stops_now(stops \\ Ztm.stops) do
    stops
    |> Enum.map(fn({name, id}) -> stop_now(name, id) end)
  end

  def stop_now(name) do
    stop_now(name |> String.downcase, Map.get(Ztm.stops, name |> String.to_atom))
  end

  defp stop_now(name, id) do
    %{
      :stop_name => name,
      :relations => Client.get(id) |> response_to_relation
    }
  end

  defp response_to_relation({:ok, %HTTPoison.Response{body: body, headers: _h, status_code: _s}}) do
    body
    |> Enum.map(fn(relation) -> [line,destination,time] = relation; %Relation{line: line, destination: destination, time: time} end)
  end

end
