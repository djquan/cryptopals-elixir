defmodule SetOne.ChallengeEight do
  @doc """
  Takes a list of ciphertexts and returns the ones that have been encrypted with aes_ecb
  http://cryptopals.com/sets/1/challenges/8
  """
  def find_aes_ecb(ciphertexts) do
    ciphertexts
    |> Enum.filter(&(encrypted_aes_ecb?(&1)))
  end

  @doc """
  Splits a string into a binary list and sees if there are duplicate 16 byte chunks.
  """
  def encrypted_aes_ecb?(ciphertext) do
    binary = ciphertext
             |> :binary.bin_to_list
             |> Enum.chunk(16)

    length(binary) != length(Enum.uniq(binary))
  end
end
