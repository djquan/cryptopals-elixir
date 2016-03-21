defmodule SetOne.ChallengeOne do
  use Bitwise

  @doc """
  Method to convert hex to base64.
  http://cryptopals.com/sets/1/challenges/1/
  """
  @spec hex_to_base64(String.t) :: binary
  def hex_to_base64(input) do
    String.upcase(input)
    |> Base.decode16!
    |> Base.encode64
  end
end
