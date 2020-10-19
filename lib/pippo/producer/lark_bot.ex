defmodule Pippo.Producer.LarkBot do
  import Plug.Conn
  use Pippo.Utils.WebHook
  use Pippo.Producer

  @verification_token Application.get_env(:pippo, :lark_bot)[:verification_token]

  def call(conn) do
    body = conn |> fetch_body
    verification_token = @verification_token
    case body |> Poison.decode! do
      %{"token" => ^verification_token, "type" => "url_verification", "challenge" => challenge} ->
        send_resp(conn, 200, Poison.encode!(%{"challenge" => challenge}))
      %{"token" => ^verification_token, "type" => "event_callback", "event" => event} ->
        broadcast("lark_bot_hook", event)
        send_resp(conn, 200, "ok")
      _ ->
        IO.puts("unknown callback: #{body}")
        send_resp(conn, 404, "oops")
    end
  end
end
