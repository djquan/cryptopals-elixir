defmodule SetTwo.ChallengeEleven do
  import SetTwo.ChallengeTen

  @doc """
  Pads a plaintext with a random amount of bytes before and after
  Encrypts a given plaintext with aes_128_ecb OR aes_128_cbc
  Uses a random cipher
  http://cryptopals.com/sets/2/challenges/11
  """
  @spec encryption_oracle(binary) :: {<<_::24>>, binary}
  def encryption_oracle(plaintext) do
    plaintext
    |> pad_random
    |> encrypt_random_ecb_cbc
  end

  @spec encrypt_random_ecb_cbc(binary) :: {<<_::24>>, binary}
  def encrypt_random_ecb_cbc(plaintext) do
    cipher = generate_random_aes_key()
    if (:rand.uniform(2) == 1) do
      {"ecb", encrypt_aes_128_ecb(plaintext, cipher) }
    else
      {"cbc", encrypt_aes_128_cbc(plaintext, cipher, generate_random_aes_key())}
    end
  end

  @doc """
  Determines if a given ciphertext is encrypted with ecb or cbc.
  Leverages Challenge Eight to do so.
  http://cryptopals.com/sets/2/challenges/11
  """
  @spec discover_type(binary) :: <<_::24>>
  def discover_type(ciphertext) do
    if SetOne.ChallengeEight.encrypted_aes_ecb?(ciphertext), do: "ecb", else: "cbc"
  end

  @doc """
  Under the hood, have the function append 5-10 bytes (count chosen randomly) before the plaintext and 5-10 bytes after the plaintext.

  ### Examples
  iex> Regex.match?(~r/.{5,10}plaintext.{5,10}/s, SetTwo.ChallengeEleven.pad_random("plaintext"))
  true
  """
  @spec pad_random(binary) :: binary
  def pad_random(plaintext) do
    generate_random_bytes(:rand.uniform(6) + 4)
    <> plaintext
    <> generate_random_bytes(:rand.uniform(6) + 4)
  end

  @doc """
  Generates a random AES key
  """
  @spec generate_random_aes_key() :: binary
  def generate_random_aes_key, do: generate_random_bytes(16)

  defp generate_random_bytes(num) do
    Stream.repeatedly(fn -> :rand.uniform(255) end)
    |> Enum.take(num)
    |> :binary.list_to_bin
  end
end
