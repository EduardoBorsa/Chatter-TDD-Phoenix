defmodule ChatterWeb.Features.UserVisitsHomepageTest do
  use ChatterWeb.FeatureCase, async: true

  test "user can visit homepage", %{session: session} do
    session
    |> visit("/")
    |> assert_has(Query.css(".title", text: "Welcome to Chatter!"))
  end

  test "user visits rooms page to see a list of rooms", %{session: session} do
    room = insert(:chat_room)

    session
    |> visit(Routes.chat_room_path(@endpoint, :index))
    |> assert_has(Query.css(".room", text: room.name))
  end
end
