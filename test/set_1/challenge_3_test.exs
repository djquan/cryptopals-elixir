defmodule SetOne.ChallengeThreeTest do
  use ExUnit.Case, async: true
  import SetOne.ChallengeThree

  test "can decrypt a single byte XOR message" do
    input           = "1B37373331363F78151B7F2B783431333D78397828372D363C78373E783A393B3736"
    expected_result = "Cooking MC's like a pound of bacon"
    {_, result}     = my_decoder(input)

    assert expected_result == result
  end
end
