defmodule SetOne.ChallengeFourTest do
  use ExUnit.Case, async: true
  import SetOne.ChallengeFour

  test "can find one single byte XOR message in many" do
    expected_result = "Now that the party is jumping\n"

    {_, _, result} =
      File.read!("test/set_1/c4_ciphertexts.txt")
      |> String.split()
      |> find_code

    assert expected_result == result
  end
end
