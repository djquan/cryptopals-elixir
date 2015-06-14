defmodule SetOne.ChallengeTwoTest do
  use ExUnit.Case, async: true
  import SetOne.ChallengeTwo
  doctest SetOne.ChallengeTwo

  @doc"""
  See   
  http://cryptopals.com/sets/1/challenges/2/
  """
  test "can XOR two equal length buffers" do
    input_one       = "1C0111001F010100061A024B53535009181C"
    input_two       = "686974207468652062756C6C277320657965"
    expected_result = "746865206B696420646F6E277420706C6179"

    assert expected_result == my_hex_xor(input_one, input_two)
  end
end
