defmodule Flightex.Bookings.CreateBooking do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.Booking
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  def call(user_id, params) do
    user_id
    |> UserAgent.get()
    |> handle_verification(params)
  end

  defp handle_verification({:error, _reason} = error, _params), do: error

  defp handle_verification({:ok, %User{id: id}}, %{
         date: date,
         from_city: from_city,
         to_city: to_city
       }) do
    {:ok, booking} =
      Booking.build(
        NaiveDateTime.from_iso8601!("#{date} 00:00:00"),
        from_city,
        to_city,
        id
      )

    BookingAgent.save(booking)

    {:ok, booking.id}
  end
end
