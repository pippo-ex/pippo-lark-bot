defmodule Pippo.WebHook.LarkBot do
  import Plug.Conn

  def call(conn) do
    body = conn |> fetch_body
    case body |> Poison.decode! do
      %{"type" => "url_verification", "challenge" => challenge} ->
        send_resp(conn, 200, Poison.encode!(%{"challenge" => challenge}))
      %{"type" => "event_callback", "event" => event} ->
        Pippo.Producer.LarkBot.add_task({:web_hook, event})
        send_resp(conn, 200, "ok")
      _ ->
        IO.puts("unknown callback: #{body}")
        send_resp(conn, 404, "oops")
    end
  end

  defp fetch_body(conn, recv \\ "") do
    case read_body(conn) do
      {:ok, body, _} -> recv <> body
      {:more, body, conn} -> fetch_body(conn, recv <> body)
    end
  end
end
