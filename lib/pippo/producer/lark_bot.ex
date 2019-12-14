defmodule Pippo.Producer.LarkBot do
  import Pippo.Producer
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, :the_state_doesnt_matter, name: __MODULE__)
  end

  def init(_opts) do
    {:producer, {:queue.new(), 0}, dispatcher: GenStage.BroadcastDispatcher}
  end

  def add_task({_source, event}) do
    GenStage.cast(__MODULE__, {:add, event})
  end

  def handle_cast({:add, event}, {queue, pending_demand}) do
    dispatch_events(:queue.in(Pippo.Utils.LarkBot.Processor.deal(event), queue), pending_demand)
  end

  def handle_demand(incoming_demand, {queue, pending_demand}) do
    dispatch_events(queue, incoming_demand + pending_demand)
  end
end
