defmodule Pippo.Utils.LarkBot.Processor do
  def deal(%{"text" => text, "chat_type" => chat_type} = event) do
    parse(:ping, event, 1)
  end

  defp parse(:ping, event, _) do
    {:reply,
      type: "text",
      content: "pong",
      to: gen_receiver(event, :open_id),
      parent: event.parent_id}
  end

  defp parse(_, _, _) do

  end

  defp gen_receiver(%{"open_id" => id}, :open_id), do: {:open_id, id}
  defp gen_receiver(%{"open_chat_id" => id}, :chat_id), do: {:chat_id, id}
end
