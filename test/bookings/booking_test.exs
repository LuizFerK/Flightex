defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case
  import Flightex.Factory

  alias Flightex.Bookings.Booking

  describe "build/4" do
    test "when all params are valid, returns an booking" do
      {:ok, booking} =
        Booking.build(
          "2020-02-03",
          "Random city",
          "Other Random city",
          "195b67f9-772c-4ef0-9191-3d2d91bd2ce9"
        )

      expected_response = build(:booking, id: booking.id)

      assert booking == expected_response
    end
  end
end
