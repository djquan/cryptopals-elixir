defmodule SetOne.ChallengeFive do
  use Bitwise

  @doc """
  Will encrypt a string(plaintext) with a cipher through repeating XOR
  http://cryptopals.com/sets/1/challenges/5/
  """
  @spec repeating_xor_encrypt(binary, binary) :: binary
  def repeating_xor_encrypt(plaintext, cipher) do
    cipher
    |> :binary.copy(byte_size(plaintext))
    |> :binary.bin_to_list
    |> Helpers.my_xor(:binary.bin_to_list(plaintext))
    |> :binary.list_to_bin
    |> Base.encode16
  end
end
