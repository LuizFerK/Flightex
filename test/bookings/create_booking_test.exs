defmodule Flightex.Bookings.CreateBookingTest do
  use ExUnit.Case
  import Flightex.Factory

  alias Flightex.Bookings.CreateBooking
  alias Flightex.Users.Agent, as: UserAgent

  describe "call/2" do
    setup do
      Flightex.start_agents()

      {:ok, user_id} = UserAgent.save(build(:user))

      {:ok, user_id: user_id}
    end

    test "when all params are valid, saves the booking", %{user_id: user_id} do
      params = %{
        date: "2020-02-02",
        from_city: "Random city",
        to_city: "Other Random city"
      }

      assert {:ok, _booking_id} = CreateBooking.call(user_id, params)
    end
  end
end
