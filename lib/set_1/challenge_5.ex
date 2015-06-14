defmodule SetOne.ChallengeFive do
  use Bitwise

  @doc """
  Will encrypt a string(plaintext) with a cipher through repeating XOR
  http://cryptopals.com/sets/1/challenges/5/
  """
  def repeating_xor_encrypt(plaintext, cipher) do
    cipher
    |> String.duplicate(String.length(plaintext))
    |> :binary.bin_to_list
    |> Helpers.my_xor(:binary.bin_to_list(plaintext))
    |> Base.encode16
  end
end
