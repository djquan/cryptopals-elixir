defmodule SetOne.ChallengeSixTest do
  use ExUnit.Case, async: true
  import SetOne.ChallengeSix
  doctest SetOne.ChallengeSix

  @doc"""
  See   
  http://cryptopals.com/sets/1/challenges/6/
  """
  test "can calculate the hamming distance" do
    assert hamming("this is a test", "wokka wokka!!!") == 37
  end
end
