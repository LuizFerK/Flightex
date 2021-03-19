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
         data_completa: data_completa,
         cidade_origem: cidade_origem,
         cidade_destino: cidade_destino
       }) do
    {:ok, booking} =
      Booking.build(
        NaiveDateTime.from_iso8601!("#{data_completa} 00:00:00"),
        cidade_origem,
        cidade_destino,
        id
      )

    BookingAgent.save(booking)

    {:ok, booking.id}
  end
end
