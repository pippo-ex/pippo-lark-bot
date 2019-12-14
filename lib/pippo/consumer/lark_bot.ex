defmodule Pippo.Consumer.LarkBot do
  import Pippo.Consumer
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, :the_state_doesnt_matter, name: __MODULE__)
  end

  def init(state) do
    {:consumer, state, subscribe_to: get_subscriptions()}
  end

  def handle_events(events, _from, state) do
    for event <- events do
      IO.inspect event
    end

    {:noreply, [], state}
  end
end
