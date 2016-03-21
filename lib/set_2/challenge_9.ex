defmodule SetTwo.ChallengeNine do
  @doc """
  Pads a block with a supplied length with <<4>>
  http://cryptopals.com/sets/2/challenges/9/
  """
  @spec pad(binary, pos_integer) :: binary
  def pad(block, pad_length), do: String.ljust(block, pad_length, 4)
end
