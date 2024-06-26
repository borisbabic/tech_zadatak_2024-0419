defmodule Glooko.AccountsTest do
  use Glooko.DataCase

  alias Glooko.Accounts

  describe "users" do
    alias Glooko.Accounts.User

    import Glooko.AccountsFixtures

    @invalid_attrs %{
      date_of_birth: nil,
      email: nil,
      first_name: nil,
      last_name: nil,
      phone_number: nil
    }

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        date_of_birth: ~D[2024-04-18],
        email: "some email",
        first_name: "some first_name",
        last_name: "some last_name",
        phone_number: "some phone_number"
      }

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.date_of_birth == ~D[2024-04-18]
      assert user.email == "some email"
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.phone_number == "some phone_number"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        date_of_birth: ~D[2024-04-19],
        email: "some updated email",
        first_name: "some updated first_name",
        last_name: "some updated last_name",
        phone_number: "some updated phone_number"
      }

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.date_of_birth == ~D[2024-04-19]
      assert user.email == "some updated email"
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.phone_number == "some updated phone_number"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
