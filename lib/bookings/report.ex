defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def call(from_date, to_date) do
    report = create(from_date, to_date)

    File.write("report.csv", report)

    {:ok, "Report generated successfully"}
  end

  defp create(from_date, to_date) do
    BookingAgent.get_all()
    |> Map.values()
    |> Enum.map(&booking_string(&1, from_date, to_date))
  end

  defp booking_string(
         %Booking{
           id_usuario: user_id,
           cidade_origem: from_city,
           cidade_destino: to_city,
           data_completa: date
         },
         from_date,
         to_date
       ) do
    line = "#{user_id},#{from_city},#{to_city},#{date}\n"

    NaiveDateTime.compare(date, parse_date(from_date))
    |> handle_compare(date, to_date, line)
  end

  defp handle_compare(:lt, _date, _to_date, _line), do: ""
  defp handle_compare(:eq, _date, _to_date, line), do: line

  defp handle_compare(:gt, date, to_date, line) do
    case NaiveDateTime.compare(date, parse_date(to_date)) do
      :eq -> line
      :lt -> line
      _ -> ""
    end
  end

  defp parse_date(date), do: NaiveDateTime.from_iso8601!("#{date} 00:00:00")
end
