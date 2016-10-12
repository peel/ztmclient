defmodule ZtmTest do
  use ExUnit.Case
  import Mock

  doctest Ztm

  setup do
    Application.put_env(:ztm, :url, "http://example.com")
  end

  test "application should start" do
    {result, _} = Ztm.start(:normal, [])
    assert result == :ok
  end

  test "url is configurable" do
    assert Ztm.url == "http://example.com"
  end

  test "grabbing data from ztm" do
    data = %{stop_name: "tetmajera", destination: "Chełm Witosa", line: "11", time: "za 2 min"}
    response = {:ok, %HTTPoison.Response{body: [[data.line,data.destination,data.time]], headers: "loremipsum", status_code: 200}}
    with_mock Ztm.Client, [get: fn(_id) -> response end] do
      result = Ztm.Relations.stop_now(data.stop_name)
      assert result == %{relations: [%Ztm.Relation{line: data.line, destination: data.destination, time: data.time}], stop_name: data.stop_name}
    end
  end
end
