use Mix.Config

config :pippo, server_port: 4000

config :pippo, producers: [
  {Pippo.Producer.LarkBot, %{source: "web_hook", scheme: "/lark"}}
]

config :pippo, consumers: %{
  "lark_bot_hook" => PippoLarkBot.Test,
  "lark_bot" => Pippo.Consumer.LarkBot,
}

config :pippo, lark_bot: [
  verification_token: "YOUR VERIFICATION_TOKEN",
  app_id: "YOUR APP_ID",
  app_secret: "YOUR APP_SECRET"
]
