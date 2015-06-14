defmodule SetOne.ChallengeThree do
  use Bitwise

  @doc """
  Decodes a given ciphertext that was encrypted with a single byte.
  Iterates over every possible single byte cipher and tries XORing them.
  Calculates a score based on letter frequency and returns a tuple with the highest score/plaintext
  http://cryptopals.com/sets/1/challenges/3/
  """
  def my_decoder(ciphertext) do
    ciphertext_list = Base.decode16!(ciphertext) |> :binary.bin_to_list
    ciphertext_length = String.length(ciphertext)

    0..255 |> Enum.reduce({0, ""}, fn(x, acc) ->
      plaintext = Helpers.convert(<<x>>, ciphertext_list)
      score = Helpers.score(plaintext)
      if score > elem(acc, 0), do: acc = {score, plaintext}

      acc
    end)
  end
end
