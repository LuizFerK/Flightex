defmodule Flightex.Users.AgentTest do
  use ExUnit.Case
  import Flightex.Factory

  alias Flightex.Users.Agent, as: UserAgent

  describe "save/1" do
    test "should save the user" do
      user = build(:user)

      UserAgent.start_link(%{})

      assert {:ok, _user_id} = UserAgent.save(user)
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      id = "195b67f9-772c-4ef0-9191-3d2d91bd2ce9"

      {:ok, id: id}
    end

    test "when the user is found, returns an user", %{id: id} do
      user = build(:user, id: id)

      UserAgent.save(user)

      assert UserAgent.get(id) == {:ok, user}
    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("non_existent_id")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
