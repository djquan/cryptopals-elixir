defmodule SetOneTest do
  use ExUnit.Case

  test "can convert Hex to Base64" do
    expected = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
    actual = SetOne.hex_to_base64("49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d")
    assert expected == actual
  end

  test "can XOR two equal length buffers" do
    a = "1c0111001f010100061a024b53535009181c" |> String.upcase
    b = "686974207468652062756c6c277320657965" |> String.upcase
    expected = "746865206b696420646f6e277420706c6179" |> String.upcase
    assert expected == SetOne.my_hex_xor(a,b)
  end
end
