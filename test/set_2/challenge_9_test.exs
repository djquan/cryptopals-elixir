defmodule SetTwo.ChallengeNineTest do
  use ExUnit.Case, async: true
  import SetTwo.ChallengeNine
  doctest SetTwo.ChallengeNine

  test "pads a block to a specific length" do
    assert pad("YELLOW SUBMARINE", 20) == "YELLOW SUBMARINE\x04\x04\x04\x04"
  end
end
