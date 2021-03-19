defmodule Flightex.Bookings.Booking do
  @keys [:id, :date, :from_city, :to_city, :user_id]
  @enforce_keys @keys

  defstruct @keys

  def build(date, from_city, to_city, user_id) do
    {:ok,
     %__MODULE__{
       id: UUID.uuid4(),
       date: date,
       from_city: from_city,
       to_city: to_city,
       user_id: user_id
     }}
  end
end
