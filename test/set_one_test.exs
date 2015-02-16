defmodule SetOneTest do
  use ExUnit.Case

  test "can convert Hex to Base64" do
    expected = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
    actual = SetOne.hex_to_base64("49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d")
    assert expected == actual
  end

  test "can XOR two equal length buffers" do
    a = "1C0111001F010100061A024B53535009181C"
    b = "686974207468652062756C6C277320657965"
    expected = "746865206B696420646F6E277420706C6179"
    assert expected == SetOne.my_hex_xor(a,b)
  end

  test "can decrypt a single byte XOR message" do
    input = "1B37373331363F78151B7F2B783431333D78397828372D363C78373E783A393B3736"
    expected = "who knows"
    assert expected == SetOne.my_decoder(input)
  end
end
