defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case
  import Flightex.Factory

  alias Flightex.Bookings.Report

  describe "call/2" do
    setup do
      Flightex.start_agents()

      {:ok, user_id} = Flightex.create_user(build(:user))
      Flightex.create_booking(user_id, build(:booking, user_id: user_id, date: "2020-02-11"))
      Flightex.create_booking(user_id, build(:booking, user_id: user_id, date: "2020-02-12"))
      Flightex.create_booking(user_id, build(:booking, user_id: user_id, date: "2020-02-13"))
      Flightex.create_booking(user_id, build(:booking, user_id: user_id, date: "2020-02-14"))

      {:ok, user_id: user_id}
    end

    test "should return all the bookings", %{user_id: user_id} do
      Report.call("2020-02-10", "2020-02-15")

      response =
        File.stream!("report.csv")
        |> Enum.sort_by(&String.slice(&1, -11..-9), :asc)

      expected_response = [
        "#{user_id},Random city,Other Random city,2020-02-11 00:00:00\n",
        "#{user_id},Random city,Other Random city,2020-02-12 00:00:00\n",
        "#{user_id},Random city,Other Random city,2020-02-13 00:00:00\n",
        "#{user_id},Random city,Other Random city,2020-02-14 00:00:00\n"
      ]

      assert response == expected_response
    end

    test "should return the bookings between 2020-02-12 and 2020-02-13", %{user_id: user_id} do
      Report.call("2020-02-12", "2020-02-13")

      response =
        File.stream!("report.csv")
        |> Enum.sort_by(&String.slice(&1, -11..-9), :asc)

      expected_response = [
        "#{user_id},Random city,Other Random city,2020-02-12 00:00:00\n",
        "#{user_id},Random city,Other Random city,2020-02-13 00:00:00\n"
      ]

      assert response == expected_response
    end
  end
end
