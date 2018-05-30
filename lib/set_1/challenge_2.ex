defmodule SetOne.ChallengeTwo do
  use Bitwise

  @doc """
  XORs two hex inputs of equal length.
  Decodes the inputs, calls my_xor on the binary, and reincodes them.
  http://cryptopals.com/sets/1/challenges/2

  ### Examples
    iex> SetOne.ChallengeTwo.my_hex_xor("1A", "1B")
    "01"

    iex> SetOne.ChallengeTwo.my_hex_xor("1A", "1A")
    "00"
  """
  @spec my_hex_xor(binary, binary) :: binary
  def my_hex_xor(a, b) do
    first = Base.decode16!(a) |> :binary.bin_to_list()
    second = Base.decode16!(b) |> :binary.bin_to_list()

    Helpers.my_xor(first, second)
    |> :binary.list_to_bin()
    |> Base.encode16()
  end
end
