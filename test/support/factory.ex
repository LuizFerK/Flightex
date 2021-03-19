defmodule Flightex.Factory do
  use ExMachina
  alias Flightex.Bookings.Booking
  alias Flightex.Users.User

  def user_factory do
    %User{
      id: "195b67f9-772c-4ef0-9191-3d2d91bd2ce9",
      name: "John Doe",
      email: "johndoe@example.com",
      cpf: "12345678900"
    }
  end

  def booking_factory do
    %Booking{
      id: "aaf91fff-a3fc-4a8e-a63e-3e5e9e2a26d0",
      date: "2020-02-03",
      from_city: "Random city",
      to_city: "Other Random city",
      user_id: "195b67f9-772c-4ef0-9191-3d2d91bd2ce9"
    }
  end
end
