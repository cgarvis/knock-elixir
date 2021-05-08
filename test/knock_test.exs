defmodule KnockTest do
  use ExUnit.Case
  doctest Knock

  defmodule TestClient do
    use Knock, otp_app: :knock
  end

  describe "using a module to create a client" do
    test "it can have configuration set along with the defaults" do
      knock = TestClient.client(api_key: "sk_test_12345")

      assert knock.api_key == "sk_test_12345"
      assert knock.adapter == Tesla.Adapter.Hackney
      assert knock.json_client == Jason
      assert knock.host == "https://api.knock.app"
    end

    test "it will default to reading the api key from env vars" do
      System.put_env("KNOCK_API_KEY", "sk_test_12345")

      knock = TestClient.client()

      assert knock.api_key == "sk_test_12345"
    end
  end
end
