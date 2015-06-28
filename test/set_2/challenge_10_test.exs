defmodule SetTwo.ChallengeTenTest do
  use ExUnit.Case, async: true
  import SetTwo.ChallengeTen
  doctest SetTwo.ChallengeTen

  test "encrypts in AES ECB" do
    plaintext = "I'm back and I'm ringin' the bell"
    ciphertext = encrypt_aes_128_ecb(plaintext, "YELLOW SUBMARINE")

    assert plaintext == SetOne.ChallengeSeven.decrypt_aes_128_ecb(ciphertext, "YELLOW SUBMARINE")
  end

  test "decrypts the first block correctly" do
    first_block = ciphertext |> :binary.bin_to_list |> Stream.chunk(16) |> Enum.take(1)
    expected_result = "I'm back and I'm"

    assert decrypt_aes_128_cbc(first_block, "YELLOW SUBMARINE", String.duplicate(<<0>>, 16)) == expected_result
  end

  test "decrypts the entire ciphertext correctly" do
    result = decrypt_aes_128_cbc(ciphertext, "YELLOW SUBMARINE", String.duplicate(<<0>>, 16))

    assert String.ends_with?(result, "Play that funky music \n")
  end

  defp ciphertext, do: File.read!("test/set_2/c10_ciphertext.txt") |> String.replace("\n", "") |> Base.decode64!
end
