defmodule SetOne.ChallengeFour do
  use Bitwise
  alias SetOne.ChallengeThree, as: ChallengeThree

  @doc """
  Iterates over an Enum of ciphertexts searching for the highest scoring plaintext.
  Uses a parallel version of map for efficiency.
  http://cryptopals.com/sets/1/challenges/4
  """
  @spec find_code([binary]) :: {integer, integer, binary}
  def find_code(ciphertexts) do
    ciphertexts
    |> Helpers.pmap(fn ciphertext -> ChallengeThree.my_decoder(String.upcase(ciphertext)) end)
    |> Enum.max_by(fn {_, score, _} -> score end)
  end
end
