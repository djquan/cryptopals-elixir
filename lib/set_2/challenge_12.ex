defmodule SetTwo.ChallengeTwelve do
  import SetTwo.ChallengeTen
  @key SetTwo.ChallengeEleven.generate_random_aes_key

  def crack_code do
    plaintext = ""
    ciphertext = encryption_oracle_2("")
    if SetOne.ChallengeEight.encrypted_aes_ecb?(ciphertext) do
      raise ArgumentError, message: "Not ECB encrypted"
    end

    block_size = determine_block_size(ciphertext)
    input_block = :binary.copy("A", block_size - 1)

    brute_force_decrypt(block_size, "")
  end

  def brute_force_decrypt(block_size, known) when byte_size(known) == block_size, do: ""

  def brute_force_decrypt(block_size, known) do
    input_block = :binary.copy("A", block_size - 1 - byte_size(known))
    sample = Kernel.binary_part(encryption_oracle_2(input_block), 0, block_size)
    table = (0..255)
    |> Enum.reduce(%{}, fn(x, acc) ->
        block = Kernel.binary_part(encryption_oracle_2(input_block <> known <> <<x>>), 0, block_size)
      Map.put(acc, block, <<x>>)
    end)

    result = Map.get(table, sample) || ""
    result <> brute_force_decrypt(block_size, known <> result)
  end

  @doc """
  Determines the block size of a given ciphertext encrypted with ECB
  Brute forces it.

  ### Examples
  iex> ciphertext = SetTwo.ChallengeTwelve.encryption_oracle_2("")
  iex> SetTwo.ChallengeTwelve.determine_block_size(ciphertext)
  16
  """
  def determine_block_size(ciphertext) do
    (1..100)
    |> Stream.filter(fn(x) ->
      String.ends_with?(encryption_oracle_2(:binary.copy("A", x)), ciphertext)
    end)
    |> Enum.take(1)
    |> hd
  end

  def num_blocks(ciphertext, block_size) do
    ciphertext
    |> :binary.bin_to_list
    |> Enum.chunk(block_size)
    |> length
  end

  def encryption_oracle_2(plaintext) do
    plaintext
    |> pad_secret
    |> encrypt_aes_128_ecb(@key)
  end

  defp pad_secret(plaintext), do: plaintext <> secret

  defp secret do
    "Um9sbGluJyBpbiBteSA1LjAKV2l0aCBteSByYWctdG9wIGRvd24gc28gbXkgaGFpciBjYW4gYmxvdwpUaGUgZ2lybGllcyBvbiBzdGFuZGJ5IHdhdmluZyBqdXN0IHRvIHNheSBoaQpEaWQgeW91IHN0b3A/IE5vLCBJIGp1c3QgZHJvdmUgYnkK"
    |> Base.decode64!
  end
end
