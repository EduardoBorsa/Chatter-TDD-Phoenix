defmodule Chatter.Chat do
  alias Chatter.{Chat, Repo}
  alias Chat.Room

  def all_rooms do
    Room |> Repo.all()
  end

  def find_room(id) do
    Room
    |> Repo.get!(id)
  end

  def new_chat_room() do
    %Room{}
    |> Chat.Room.changeset(%{})
  end

  def create_chat_room(params) do
    %Room{}
    |> Room.changeset(params)
    |> Repo.insert()
  end
end
