defmodule Pippo.Consumer.LarkBot do
  use Pippo.Consumer
  import PippoLarkBot.Api

  def deal(%{"user" => user, "msg_type" => msg_type, "content" => content, "root_id" => root_id}) do
    send_message(user, msg_type, content, root_id)
  end
end
