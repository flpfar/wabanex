defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.{User, Users}

  describe "users queries" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{email: "felipe@mail.com", name: "Felipe", password: "123123"}

      {:ok, %User{id: user_id}} = Users.Create.call(params)

      query = """
        {
          user(id: "#{user_id}"){
            name
            email
          }
        }
      """

      expected_response = %{
        "data" => %{
          "user" => %{
            "email" => "felipe@mail.com",
            "name" => "Felipe"
          }
        }
      }

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert expected_response == response
    end
  end

  describe "users mutations" do
    test "when all params are valid, returns the user", %{conn: conn} do
      params = %{email: "felipe@mail.com", name: "Felipe", password: "123123"}

      {:ok, %User{id: user_id}} = Users.Create.call(params)

      mutation = """
        mutation {
          user(input:{name: "Joao", email: "joao@mail.com.br", password: "123123"}){
            id
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{"data" => %{
        "user" => %{
          "email" => "joao@mail.com.br",
          "name" => "Joao",
          "id" => _id
        }
      }} = response
    end
  end
end
