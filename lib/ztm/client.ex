defmodule Ztm.Client do
  use HTTPoison.Base

  defp process_url(endpoint) do
    Ztm.url <> endpoint
  end

  defp process_response_body(body) do
    ascii(body)
    |> Floki.find("tr td")
    |> Stream.map(fn(td) -> {"td", [], [val]} = td; Floki.text(val) end)
    |> Enum.chunk(3)
  end 

  defp ascii(str) do
    Codepagex.to_string!(str, :iso_8859_2, Codepagex.use_utf_replacement)
  end

end
