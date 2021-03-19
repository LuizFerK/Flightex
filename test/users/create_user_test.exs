defmodule Flightex.Users.CreateUserTest do
  use ExUnit.Case

  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateUser

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when all params are valid, saves the user" do
      params = %{
        name: "John Doe",
        email: "johndoe@example.com",
        cpf: "12345678900"
      }

      assert {:ok, _user_id} = CreateUser.call(params)
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "John Doe",
        email: "johndoe@example.com",
        cpf: 0
      }

      response = CreateUser.call(params)

      expected_reponse = {:error, "Invalid parameters"}

      assert response == expected_reponse
    end
  end
end
