defmodule Flightex.Users.UserTest do
  use ExUnit.Case
  import Flightex.Factory

  alias Flightex.Users.User

  describe "build/3" do
    test "when all params are valid, returns an user" do
      {:ok, user} = User.build("John Doe", "johndoe@example.com", "12345678900")

      expected_response = build(:user, id: user.id)

      assert user == expected_response
    end

    test "when there are invalid params, returns an error" do
      response = User.build("John Doe", "johndoe@example.com", 0)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
