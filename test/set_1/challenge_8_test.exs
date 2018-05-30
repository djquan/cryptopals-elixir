defmodule SetOne.ChallengeEightTest do
  use ExUnit.Case, async: true
  import SetOne.ChallengeEight
  doctest SetOne.ChallengeEight

  test "decrypts ciphertext encrypted with AES 128 ECB" do
    expected_result =
      "D880619740A8A19B7840A8A31C810A3D08649AF70DC06F4FD5D2D69C744CD283E2DD052F6B641DBF9D11B0348542BB5708649AF70DC06F4FD5D2D69C744CD2839475C9DFDBC1D46597949D9C7E82BF5A08649AF70DC06F4FD5D2D69C744CD28397A93EAB8D6AECD566489154789A6B0308649AF70DC06F4FD5D2D69C744CD283D403180C98C8F6DB1F2A3F9C4040DEB0AB51B29933F2C123C58386B06FBA186A"

    result =
      find_aes_ecb(ciphertexts())
      |> Enum.map(&Base.encode16(&1))
      |> hd

    assert result == expected_result
  end

  defp ciphertexts do
    File.read!("test/set_1/c8_ciphertexts.txt")
    |> String.upcase()
    |> String.split("\n")
    |> Enum.map(&Base.decode16!(&1))
  end
end
