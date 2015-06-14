defmodule SetOne.ChallengeSix do
  use Bitwise

  @doc """
  Calcualtes the Hamming Distance of two strings
  http://cryptopals.com/sets/1/challenges/6/

  ### Examples
    iex> SetOne.ChallengeSix.hamming("abc", "abc")
    0

    iex> SetOne.ChallengeSix.hamming("0", "1")
    1
  """
  def hamming(first, second) do
    a = String.to_char_list(first)
    b = String.to_char_list(second)

    Enum.zip(a,b)
    |> Enum.map(fn({x,y}) -> x ^^^ y end)
    |> Enum.reduce(0, fn(x, acc) -> acc + Helpers.count_bits(x) end)
  end
end
