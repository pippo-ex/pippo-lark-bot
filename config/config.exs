use Mix.Config

config :pippo, server_port: 4000

config :pippo, web_hooks: [
  {Pippo.WebHook.LarkBot, "/lark_bot", []},
]

config :pippo, producers: [
  {Pippo.Producer.LarkBot, []}
]

config :pippo, consumers: [
  {Pippo.Consumer.ConsoleInspector, []},
  {Pippo.Consumer.LarkBot, []},
]

config :pippo, flow: [
  {Pippo.WebHook.LarkBot, Pippo.Consumer.ConsoleInspector},
]
