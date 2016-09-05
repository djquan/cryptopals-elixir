defmodule Helpers do
  use Bitwise

  @doc """
  Function that takes two lists of bytes of equal size
  Returns a list of the bitwise XOR of the two arguments

  ### Examples
    iex> Helpers.my_xor([1], [1])
    [0]

    iex> Helpers.my_xor([0], [1])
    [1]
  """
  @spec my_xor([byte], [byte]) :: [byte]
  def my_xor(a, b) when is_list(a) do
    Enum.zip(a, b)
    |> Enum.map(fn({x,y}) -> x ^^^ y end)
  end

  @doc """
  Function that takes a single char and a given ciphertext as a list of bytes

  Returns the ciphertext XORed against a list of the given char

  ### Examples
    iex> Helpers.my_xor(<<0>>, [0, 0])
    [0, 0]

    iex> Helpers.my_xor(<<0>>, [1, 1])
    [1, 1]
  """
  @spec my_xor(binary, [byte]) :: [byte]
  def my_xor(char, ciphertext) when is_binary(char) do
    :binary.copy(char, length(ciphertext))
    |> :binary.bin_to_list
    |> my_xor(ciphertext)
  end

  @doc """
  Function that calculates a score that a given plaintext is in English.
  Iterates through the plaintext and adds up the result of where the character lies on the frequency map

  ### Examples

    iex> Helpers.score("Dogs are better than cats") > Helpers.score("alfmlk20")
    true

  """
  @spec score(binary) :: integer
  def score(plaintext) do
    plaintext
    |> :binary.bin_to_list
    |> Enum.reduce(fn(x, score) -> score + Map.get(frequency_map, String.upcase(<<x>>), 0) end)
  end

  @doc """
  Counts the number of bits in a given base 10 integer

  ### Examples
    iex> Helpers.count_bits(0)
    0

    iex> Helpers.count_bits(42) ## 00101010
    3
  """
  @spec count_bits(integer) :: integer
  def count_bits(bitstring) do
    bits = for <<bit::1 <- <<bitstring>> >>, do: bit
    Enum.sum bits
  end

  @doc """
  A parallel map
  Taken from Dave Thomas' Programming Elixir
  """
  def pmap(collection, fun) do
    me = self
    collection
    |> Enum.map(fn (elem) ->
      spawn_link fn -> (send me, { self, fun.(elem) }) end
    end)
    |> Enum.map(fn (pid) ->
      receive do { ^pid, result } -> result end
    end)
  end

  def transpose([[]|_]), do: []

  @doc """
  Transposes a list of lists

  ### Examples
    iex> Helpers.transpose([[1,2,3], [4,5,6]])
    [[1,4],[2,5],[3,6]]
  """
  @spec transpose([[any]]) :: [[any]]
  def transpose(lists) do
   [Enum.map(lists, &hd/1) | transpose(Enum.map(lists, &tl/1))]
  end

  defp frequency_map do
    # Taken from http://www.math.cornell.edu/~mec/2003-2004/cryptography/subs/frequencies.html
    # Added spaces with a weighted value
    %{
      "E" => 21912,
      "T" => 16587,
      "A" => 14810,
      "O" => 14003,
      "I" => 13318,
      "N" => 12666,
      "S" => 11450,
      "R" => 10977,
      "H" => 10795,
      "D" => 7874,
      "L" => 7253,
      "U" => 5246,
      "C" => 4943,
      "M" => 4761,
      "F" => 4200,
      "Y" => 3853,
      "W" => 3819,
      "G" => 3693,
      "P" => 3316,
      "B" => 2715,
      "V" => 2019,
      "K" => 1257,
      "X" => 315,
      "Q" => 205,
      "J" => 188,
      "Z" => 128,
      " " => 16000
    }
  end
end
