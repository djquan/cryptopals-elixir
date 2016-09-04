defmodule SetOne.ChallengeThree do
  use Bitwise

  @doc """
  Decodes a given ciphertext that was encrypted with a single byte.
  Iterates over every possible single byte cipher and tries XORing them.
  Calculates a score based on letter frequency and returns a tuple with the highest score/plaintext
  http://cryptopals.com/sets/1/challenges/3/

  ### Examples

     iex> SetOne.ChallengeThree.my_decoder("000D040407481F071A040C")|> elem(2)
     "hello world"
  """
  @spec my_decoder(binary) :: binary
  def my_decoder(ciphertext) when is_binary(ciphertext) do
    Base.decode16!(ciphertext)
    |> :binary.bin_to_list
    |> my_decoder
  end

  @spec my_decoder([binary]) :: {integer, integer, binary}
  def my_decoder(ciphertext_list) when is_list(ciphertext_list) do
    0..255 |> Enum.reduce({0, 0, ""}, fn(key, acc={_, old_score, _}) ->
      plaintext = Helpers.my_xor(<<key>>, ciphertext_list) |> :binary.list_to_bin
      new_score = Helpers.score(plaintext)
      if new_score > old_score, do: {key, new_score, plaintext}, else: acc
    end)
  end
end
