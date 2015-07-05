defmodule SetTwo.ChallengeTwelve do
  import SetTwo.ChallengeTen
  @key SetTwo.ChallengeEleven.generate_random_aes_key

  @doc """
  Cracks and discovers the secret encrypted with encryption_oracle_2
  http://cryptopals.com/sets/2/challenges/12/
  """
  def crack_code do
    ciphertext = encryption_oracle_2("")
    if SetOne.ChallengeEight.encrypted_aes_ecb?(ciphertext) do
      raise ArgumentError, message: "Not ECB encrypted"
    end

    block_size = determine_block_size(ciphertext)

    (1..num_blocks(ciphertext, block_size))
    |> Enum.reduce("", fn(x, acc) ->
      acc <> brute_force_decrypt(x * block_size, acc)
    end)
    |> String.replace(<<0>>, "")
  end

  def brute_force_decrypt(block_size, known) when byte_size(known) == block_size, do: ""

  @doc """
  Brute force decrypts to discover one byte of plaintext.
  input_block is a mixture of A's and what is already known
  The total size of input_block is one short of the byte to be discovered.
  Iterates through possible combinations until it arrives at a ciphertext that matches
  """
  def brute_force_decrypt(block_size, known) do
    input_block = :binary.copy("A", block_size - 1 - byte_size(known))
    sample = Kernel.binary_part(encryption_oracle_2(input_block), 0, block_size)

    result = (0..255)
    |> Stream.filter(fn(x) ->
      sample == Kernel.binary_part(encryption_oracle_2(input_block <> known <> <<x>>), 0, block_size)
    end)
    |> Enum.take(1) |> hd

    <<result>> <> brute_force_decrypt(block_size, known <> <<result>>)
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

  @doc """
  An encryption oracle that takes plaintext, pads it with a secret
  It then encrypts it with a constant, random key.
  """
  def encryption_oracle_2(plaintext) do
    plaintext
    |> pad_secret
    |> encrypt_aes_128_ecb(@key)
  end

  @doc """
  Helper function
  Counts the number of blocks in a ciphertext when given the block size
  """
  def num_blocks(ciphertext, block_size) do
    ciphertext
    |> :binary.bin_to_list
    |> Enum.chunk(block_size)
    |> length
  end

  defp pad_secret(plaintext), do: plaintext <> secret

  defp secret do
    "Um9sbGluJyBpbiBteSA1LjAKV2l0aCBteSByYWctdG9wIGRvd24gc28gbXkgaGFpciBjYW4gYmxvdwpUaGUgZ2lybGllcyBvbiBzdGFuZGJ5IHdhdmluZyBqdXN0IHRvIHNheSBoaQpEaWQgeW91IHN0b3A/IE5vLCBJIGp1c3QgZHJvdmUgYnkK"
    |> Base.decode64!
  end
end
