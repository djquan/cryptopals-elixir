defmodule SetOne.ChallengeSixTest do
  use ExUnit.Case, async: true
  import SetOne.ChallengeSix
  doctest SetOne.ChallengeSix

  test "find the key of a ciphertext encrypted with repeating XOR" do
    assert 'Terminator X: Bring the noise' == hd(find_key_repeating_xor(ciphertext))
  end

  test "can guess the keysizes on a given string " do
    result = guess_keysizes(ciphertext)
    assert 29 == elem(hd(result), 0)
  end

  test "can calculate the hamming distance" do
    assert hamming("this is a test", "wokka wokka!!!") == 37
  end

  defp ciphertext do
    File.read!("test/set_1/c6_ciphertext.txt")
    |> String.replace("\n", "")
    |> Base.decode64!
  end
end
