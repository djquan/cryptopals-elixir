defmodule SetOne.ChallengeFour do
  use Bitwise
  alias SetOne.ChallengeThree, as: ChallengeThree

  @doc """
  Iterates over an Enum of ciphertexts searching for the highest scoring plaintext.
  Uses a parallel version of map for efficiency.
  http://cryptopals.com/sets/1/challenges/4/
  """
  def find_code(ciphertexts) do
    ciphertexts
    |> Helpers.pmap(fn(x) -> ChallengeThree.my_decoder(String.upcase(x)) end)
    |> Enum.max_by(fn({score, _word}) -> score end)
  end
end
