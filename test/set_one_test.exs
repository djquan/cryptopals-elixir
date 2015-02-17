defmodule SetOneTest do
  use ExUnit.Case, async: true

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
    expected = "Cooking MC's like a pound of bacon"
    {_, actual} = SetOne.my_decoder(input)
    assert expected == actual
  end

  test "can find one single byte XOR message in many" do
    expected = "Now that the party is jumping\n"
    {_, actual} = File.read!("lib/ciphertexts.txt")
              |> String.split
              |> SetOne.find_code
    assert expected == actual
  end

  test "repeating key xor" do
    input = "Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal"
    expected = "0B3637272A2B2E63622C2E69692A23693A2A3C6324202D623D63343C2A26226324272765272A282B2F20430A652E2C652A3124333A653E2B2027630C692B20283165286326302E27282F"
    assert expected == SetOne.repeating_xor_encrypt(input, "ICE")
  end
end
