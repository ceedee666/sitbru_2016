defmodule SitBRU_Demo.SitController do
  use SitBRU_Demo.Web, :controller

  def index(conn, _params) do
    config = Application.get_env( :sitBRU_Demo, HCP_IOT_Services )
    auth  = [basic_auth: {config[:username], config[:password]}]
    response = HTTPoison.get!("https://iotmmsp650074trial.hanatrial.ondemand.com/com.sap.iotservices.mms/v1/api/http/app.svc/NEO_C2RX38OZZV5FRLDH344OTBPP2.T_IOT_B957CB9F60C087A144A5?$format=json", [],  [hackney: auth])
    json = Poison.Parser.parse!(response.body)["d"]["results"]
    data = Enum.map(json, fn(entry) -> %{humidity: entry["C_HUMIDITY"],temperature: entry["C_TEMPERATURE"]} end)
    render conn, "index.html", data: data
  end
end
