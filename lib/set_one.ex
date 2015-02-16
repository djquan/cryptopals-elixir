defmodule SetOne do
  use Bitwise;

  def hex_to_base64(input) do
    String.upcase(input)
    |> Base.decode16!
    |> Base.encode64
  end

  def my_hex_xor(a, b) do
    first  = decode_16_to_list(a)
    second = decode_16_to_list(b)
    my_xor(first, second) |> Base.encode16
  end

  def my_decoder(ciphertext) do
    ciphertext_list = decode_16_to_list(ciphertext)
    
    0..255 |> Enum.reduce({0, ""}, fn(x, acc) ->
      possible_plaintext = convert(<<x>>, ciphertext_list, String.length(ciphertext))
      score = score(possible_plaintext)
      if score > elem(acc, 0), do: acc = {score, possible_plaintext}
      acc
    end)
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
    |> Enum.reduce(fn(x, score) -> score + Map.get(frequency_map, String.upcase(<<x>>), 0) end)
  end

  defp decode_16_to_list(x), do: Base.decode16!(x) |> :binary.bin_to_list

  defp frequency_map do
    # taken from http://www.math.cornell.edu/~mec/2003-2004/cryptography/subs/frequencies.html
    # added spaces with a weighted value
    %{
      "E" => 21912,
      "T" => 16587,
      "A" => 14810,
      "O" => 14003,
      "I" => 13318,
      "N" => 12666,
      "S" => 11450,
      "R" => 10977,
      "H" => 10795,
      "D" => 7874,
      "L" => 7253,
      "U" => 5246,
      "C" => 4943,
      "M" => 4761,
      "F" => 4200,
      "Y" => 3853,
      "W" => 3819,
      "G" => 3693,
      "P" => 3316,
      "B" => 2715,
      "V" => 2019,
      "K" => 1257,
      "X" => 315,
      "Q" => 205,
      "J" => 188,
      "Z" => 128,
      " " => 16000
    }
  end
end
