defmodule SetTwo.ChallengeNine do
  @doc """
  Pads a block with a supplied length with <<4>>
  http://cryptopals.com/sets/2/challenges/9/

  ### Examples
    iex> SetTwo.ChallengeNine.pad("hello", 6)
    "hello\x04"
  """
  @spec pad(binary, pos_integer) :: binary
  def pad(block, pad_length), do: String.pad_trailing(block, pad_length, <<4>>)
end
