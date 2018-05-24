defmodule SetOne.ChallengeOne do
  use Bitwise

  @doc """
  Method to convert hex to base64.
  http://cryptopals.com/sets/1/challenges/1

  ### Examples

    iex> SetOne.ChallengeOne.hex_to_base64("4849")
    "SEk="
  """
  @spec hex_to_base64(binary) :: binary
  def hex_to_base64(input) do
    String.upcase(input)
    |> Base.decode16!()
    |> Base.encode64()
  end
end
