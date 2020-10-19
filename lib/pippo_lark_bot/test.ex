defmodule PippoLarkBot.Test do
  use Pippo.Consumer
  use Pippo.Producer

  def deal(data) do
    IO.inspect(data)
    broadcast("lark_bot", %{
      "user" => %{
        "chat_id" => data["open_chat_id"]
      },
      "msg_type" => "text",
      "content" => %{
        "text" => "0"
      },
      "root_id" => data["open_message_id"]
    })
  end
end
