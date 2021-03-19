defmodule Flightex.Bookings.AgentTest do
  use ExUnit.Case
  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent

  describe "save/1" do
    test "should save the booking" do
      booking = build(:booking)

      BookingAgent.start_link(%{})

      assert {:ok, _booking_id} = BookingAgent.save(booking)
    end
  end

  describe "get/1" do
    setup do
      BookingAgent.start_link(%{})

      id = "195b67f9-772c-4ef0-9191-3d2d91bd2ce9"

      {:ok, id: id}
    end

    test "when the booking is found, returns an booking", %{id: id} do
      booking = build(:booking, id: id)

      BookingAgent.save(booking)

      assert BookingAgent.get(id) == {:ok, booking}
    end

    test "when the booking is not found, returns an error" do
      response = BookingAgent.get("non_existent_id")

      expected_response = {:error, "Flight Booking not found"}

      assert response == expected_response
    end

    test "should return all the bookings", %{id: id} do
      build(:booking, id: id)
      |> BookingAgent.save()

      build(:booking, id: id <> "test")
      |> BookingAgent.save()

      expected_response = %{
        "195b67f9-772c-4ef0-9191-3d2d91bd2ce9" => %Flightex.Bookings.Booking{
          date: "2020-02-03",
          from_city: "Random city",
          id: "195b67f9-772c-4ef0-9191-3d2d91bd2ce9",
          to_city: "Other Random city",
          user_id: "195b67f9-772c-4ef0-9191-3d2d91bd2ce9"
        },
        "195b67f9-772c-4ef0-9191-3d2d91bd2ce9test" => %Flightex.Bookings.Booking{
          date: "2020-02-03",
          from_city: "Random city",
          id: "195b67f9-772c-4ef0-9191-3d2d91bd2ce9test",
          to_city: "Other Random city",
          user_id: "195b67f9-772c-4ef0-9191-3d2d91bd2ce9"
        }
      }

      assert BookingAgent.get_all() == expected_response
    end
  end
end
