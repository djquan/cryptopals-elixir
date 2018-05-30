defmodule SetOne.ChallengeSevenTest do
  use ExUnit.Case, async: true
  import SetOne.ChallengeSeven
  doctest SetOne.ChallengeSeven

  test "decrypts ciphertext encrypted with AES 128 ECB" do
    expected_result = "I'm back and I'm ringin' the bell"
    result = decrypt_aes_128_ecb(ciphertext(), "YELLOW SUBMARINE")

    assert String.starts_with?(result, expected_result)
  end

  defp ciphertext do
    File.read!("test/set_1/c7_ciphertext.txt")
    |> String.replace("\n", "")
    |> Base.decode64!()
  end
end
