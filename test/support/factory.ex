defmodule Chatter.Factory do
  use ExMachina.Ecto, repo: Chatter.Repo

  def chat_room_factory() do
    %Chatter.Chat.Room{
      name: ExMachina.sequence(:name, &"chat room #{&1}")
    }
  end
end
