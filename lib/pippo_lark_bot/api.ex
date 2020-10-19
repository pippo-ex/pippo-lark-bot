defmodule PippoLarkBot.Api do
  import PippoLarkBot.Utils

  @api_message_send "https://open.feishu.cn/open-apis/message/v4/send/"
  def send_message(user, msg_type, content, root_id \\ nil) do
    post_api_data(@api_message_send, Map.merge(user, %{
      "root_id" => root_id,
      "msg_type" => msg_type,
      "content" => content,
    }))
  end
end
