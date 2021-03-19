defmodule Flightex.Bookings.GetBookingTest do
  use ExUnit.Case
  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.GetBooking
  alias Flightex.Users.Agent, as: UserAgent

  describe "call/2" do
    setup do
      Flightex.start_agents()

      {:ok, user_id} = UserAgent.save(build(:user))

      {:ok, booking_id} = BookingAgent.save(build(:booking, user_id: user_id))

      {:ok, booking_id: booking_id}
    end

    test "should return the booking", %{booking_id: booking_id} do
      response = GetBooking.call(booking_id)

      expected_response =
        {:ok,
         %Flightex.Bookings.Booking{
           date: "2020-02-03",
           from_city: "Random city",
           id: "aaf91fff-a3fc-4a8e-a63e-3e5e9e2a26d0",
           to_city: "Other Random city",
           user_id: "195b67f9-772c-4ef0-9191-3d2d91bd2ce9"
         }}

      assert response == expected_response
    end

    test "should return an error if the given booking_id is invalid" do
      response = GetBooking.call("invalid_booking_id")

      expected_response = {:error, "Flight Booking not found"}

      assert response == expected_response
    end
  end
end
