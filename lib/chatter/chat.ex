defmodule Chatter.Chat do
  import Ecto.Query
  alias Chatter.{Chat, Repo}
  alias Chat.Room

  def all_rooms do
    Room |> Repo.all()
  end

  def find_room(id) do
    Room
    |> Repo.get!(id)
  end

  def find_room_by_name(name) do
    Chat.Room
    |> Repo.get_by!(name: name)
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

  def new_message(room, params) do
    room
    |> Ecto.build_assoc(:messages)
    |> Chat.Room.Message.changeset(params)
    |> Repo.insert()
  end

  def room_messages(room) do
    Chat.Room.Message
    |> where([m], m.chat_room_id == ^room.id)
    |> Repo.all()
  end
end
