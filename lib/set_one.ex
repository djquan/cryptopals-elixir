defmodule SetOne do
  use Bitwise;

  @doc """
  Method to convert hex to base64.
  See http://cryptopals.com/sets/1/challenges/1/
  """
  def hex_to_base64(input) do
    String.upcase(input)
    |> Base.decode16!
    |> Base.encode64
  end

  @doc """
  XORs two hex inputs.
  Decodes the inputs, calls my_xor on the binary, and reincodes them.
  See http://cryptopals.com/sets/1/challenges/2/
  """
  def my_hex_xor(a, b) do
    first  = decode_16_to_list(a)
    second = decode_16_to_list(b)
    my_xor(first, second) |> Base.encode16
  end

  @doc """
  Decodes a given ciphertext that was encrypted with a single byte.
  Iterates over every possible single byte cipher and tries XORing them.
  Calculates a score based on letter frequency and returns a tuple with the highest score/plaintext
  See http://cryptopals.com/sets/1/challenges/3/
  """
  def my_decoder(ciphertext) do
    ciphertext_list = decode_16_to_list(ciphertext)
    
    0..255 |> Enum.reduce({0, ""}, fn(x, acc) ->
      possible_plaintext = convert(<<x>>, ciphertext_list, String.length(ciphertext))
      score = score(possible_plaintext)
      if score > elem(acc, 0), do: acc = {score, possible_plaintext}
      acc
    end)
  end

  @doc """
  Iterates over an Enum of ciphertexts searching for the highest scoring plaintext.
  Uses a parallel version of map for efficiency.
  See http://cryptopals.com/sets/1/challenges/4/
  """
  def find_code(ciphertexts) do
    ciphertexts
    |> Helpers.pmap(fn(x) -> my_decoder(String.upcase(x)) end)
    |> Enum.max_by(fn({score, _word}) -> score end)
  end

  @doc """
  Will encrypt a string(plaintext) with a cipher through repeating XOR
  http://cryptopals.com/sets/1/challenges/5/
  """
  def repeating_xor_encrypt(plaintext, cipher) do
    cipher
    |> String.duplicate(String.length(plaintext))
    |> :binary.bin_to_list
    |> my_xor(:binary.bin_to_list(plaintext))
    |> Base.encode16
  end

  @doc """
  Calcualtes the Hamming Distance of two strings
  http://cryptopals.com/sets/1/challenges/6/
  """
  def hamming(first, second) do
    a = String.to_char_list(first)
    b = String.to_char_list(second)

    Enum.zip(a,b)
    |> Enum.map(fn({x,y}) -> x ^^^ y end)
    |> Enum.reduce(0, fn(x, acc) -> acc + count_bits(x) end)
  end

  defp count_bits(bitstring) do
    bits = for <<s::1 <- <<bitstring>> >>, do: s
    Enum.sum bits
  end

  defp my_xor(a, b) do
    Enum.zip(a, b)
    |> Enum.map(fn({x,y}) -> x ^^^ y end)
    |> to_string
  end

  defp convert(char, ciphertext, ciphertext_length) do
    String.duplicate(char, ciphertext_length)
    |> :binary.bin_to_list
    |> my_xor(ciphertext)
  end

  defp score(plaintext) do
    plaintext
    |> :binary.bin_to_list
    |> Enum.reduce(fn(x, score) -> score + Map.get(Helpers.frequency_map, String.upcase(<<x>>), 0) end)
  end

  defp decode_16_to_list(x), do: Base.decode16!(x) |> :binary.bin_to_list
end
