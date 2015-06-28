defmodule SetTwo.ChallengeTen do
  import SetOne.ChallengeSeven

  @doc """
  Encrypts a given plaintext with aes_128_ecb
  http://cryptopals.com/sets/2/challenges/10
  """
  def encrypt_aes_128_ecb(plaintext, cipher) when is_binary(plaintext) do
    plaintext
    |> :binary.bin_to_list
    |> Enum.chunk(16, 16, :binary.bin_to_list(:binary.copy(<<0>>, 15)))
    |> Enum.map(&(encrypt_aes_128_ecb(&1, cipher)))
    |> Enum.join("")
  end

  def encrypt_aes_128_ecb(plaintext, cipher) when is_list(plaintext) do
    :crypto.block_encrypt(:aes_cbc128, cipher, :binary.copy(<<0>>, 16), plaintext)
  end

  @doc """
  Decrypts an encrypted (aes 128 cbc) block
  """
  def decrypt_aes_128_cbc(encrypted_block, cipher, previous_encrypted_block) when is_list(encrypted_block) do
    decrypt_aes_128_ecb(encrypted_block, cipher)
    |> :binary.bin_to_list
    |> Helpers.my_xor(:binary.bin_to_list(previous_encrypted_block))
  end

  @doc """
  Decrypts ciphertext encrypted with aes_128_cbc. Takes an initialization vector,
  http://cryptopals.com/sets/2/challenges/10/
  """
  def decrypt_aes_128_cbc(ciphertext, cipher, iv) do
    ciphertext
    |> :binary.bin_to_list
    |> Stream.chunk(16, 16, :binary.bin_to_list(:binary.copy(<<0>>, 15)))
    |> Enum.reduce({"", iv}, fn(encrypted_block, {plaintext, previous_encrypted_block}) ->
      block_plaintext = decrypt_aes_128_cbc(encrypted_block, cipher, previous_encrypted_block)
      {plaintext <> block_plaintext, :binary.list_to_bin(encrypted_block)}
    end)
    |> elem(0)
    |> String.replace(~r/\x00|\x04/, "")
  end
end