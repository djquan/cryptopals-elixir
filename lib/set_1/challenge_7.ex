defmodule SetOne.ChallengeSeven do
  @doc """
  Decrypts a ciphertext encrypted with aes_128_ecb with a given cipher
  http://cryptopals.com/sets/1/challenges/7
  """
  @spec decrypt_aes_128_ecb(binary, binary) :: binary
  def decrypt_aes_128_ecb(ciphertext, cipher) when is_binary(ciphertext) do
    ciphertext
    |> :binary.bin_to_list()
    |> Stream.chunk_every(16)
    |> Enum.map(&decrypt_aes_128_ecb(&1, cipher))
    |> Enum.join()
    |> String.replace(~r/\x00|\x04/, "")
  end

  @spec decrypt_aes_128_ecb([byte], binary) :: binary
  def decrypt_aes_128_ecb(ciphertext, cipher) when is_list(ciphertext) do
    :crypto.crypto_one_time(:aes_128_cbc, cipher, :binary.copy(<<0>>, 16), ciphertext, false)
  end
end
