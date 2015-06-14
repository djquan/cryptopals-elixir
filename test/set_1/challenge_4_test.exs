defmodule SetOne.ChallengeFourTest do
  use ExUnit.Case, async: true
  import SetOne.ChallengeFour

  @doc"""
  See   
  http://cryptopals.com/sets/1/challenges/4/
  """
  test "can find one single byte XOR message in many" do
    expected_result = "Now that the party is jumping\n"
    {_, result}     = File.read!("test/ciphertexts.txt")
                      |> String.split
                      |> find_code

    assert expected_result == result
  end
end
