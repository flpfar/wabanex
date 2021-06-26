defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid returns a valid changeset" do
      params = %{name: "Felipe", email: "felipe@mail.com", password: "123123"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
        valid?: true,
        changes: %{name: "Felipe", email: "felipe@mail.com", password: "123123"},
        errors: []
      } = response
    end

    test "when there are invalid params, returns an invalid changeset" do
      params = %{name: "F", email: "felipe@mail.com"}

      response = User.changeset(params)

      expected_response = %{password: ["can't be blank"], name: ["should be at least 2 character(s)"]}

      assert errors_on(response) == expected_response
    end
  end
end
