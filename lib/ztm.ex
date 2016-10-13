defmodule Ztm do

  def main(_args) do
    Ztm.Supervisor.start_link
    IO.gets ""
  end

  def url do
    Application.get_env(:ztm, :url) || System.get_env(:ztm_url)
  end
  def stops do
    %{:tetmajera => "2040", :warnenska => "2269", :budapesztanska_bus => "1376", :budapesztanska_tram => "2264", :piecewska => "1372", :piekarnicza => "2273"}
  end

end
