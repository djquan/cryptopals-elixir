defmodule SetOne.ChallengeSix do
  use Bitwise

  @doc """
  Attempts to guess the keysize by calculating the hamming distance of blocks and picking the three smallest
  http://cryptopals.com/sets/1/challenges/6/
  """
  def guess_keysizes(ciphertext) do
    (2..40)
    |> Stream.map(&({&1, calculate_block_distance(&1, ciphertext)}))
    |> Enum.sort_by(fn ({_, distance}) -> distance end)
    |> Enum.take(3)
  end

  @doc """
  Calculates the normalized averages of the hamming distances
  http://cryptopals.com/sets/1/challenges/6/
  """
  def calculate_block_distance(block_size, ciphertext) do
    blocks = ciphertext
    |> :binary.bin_to_list
    |> Enum.chunk(block_size)

    blocks
    |> Enum.zip(tl(blocks))
    |> Enum.map(&(hamming(&1)))
    |> Enum.sum
    |> :erlang./(length(blocks) * block_size)
  end

  @doc """
  Calcualtes the Hamming Distance of two strings
  http://cryptopals.com/sets/1/challenges/6/

  ### Examples
    iex> SetOne.ChallengeSix.hamming("abc", "abc")
    0

    iex> SetOne.ChallengeSix.hamming("0", "1")
    1
  """
  def hamming(first, second) when is_binary(first) and is_binary(second) do
    a = String.to_char_list(first)
    b = String.to_char_list(second)

    hamming(a, b)
  end

  def hamming(a, b) do
    Enum.zip(a,b)
    |> Enum.map(fn({x,y}) -> x ^^^ y end)
    |> Enum.reduce(0, fn(x, acc) -> acc + count_bits(x) end)
  end

  defp hamming({a, b}), do: hamming(a,b)
  defp hamming(_), do: 0

  @doc """
  Counts the number of bits in a given base 10 integer

  ### Examples
    iex> SetOne.ChallengeSix.count_bits(0)
    0

    iex> SetOne.ChallengeSix.count_bits(42) ## 00101010
    3
  """
  def count_bits(bitstring) do
    bits = for <<s::1 <- <<bitstring>> >>, do: s
    Enum.sum bits
  end
end
