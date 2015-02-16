defmodule SetOne do
  use Bitwise;

  def hex_to_base64(input) do
    String.upcase(input) |>
      Base.decode16! |>
      Base.encode64
  end

  def my_hex_xor(a, b) do
    first  = Base.decode16!(a) |> :binary.bin_to_list
    second = Base.decode16!(b) |> :binary.bin_to_list

    Enum.zip(first, second) |>
      Enum.map(fn({x,y}) -> x ^^^ y end) |>
      to_string |>
      Base.encode16
  end

  def my_decoder(ciphertext) do
    bytes = 0..9 |>
      Enum.map(fn(x) -> to_string(x) end)
    bytes = bytes ++ ["A", "B", "C", "D", "E", "F"]
    high_score = 0
    plaintext = nil
    
    Enum.each(bytes, fn(x) ->
      possible_plaintext = convert(x, ciphertext)
      score = score(possible_plaintext)
      if score > high_score do
        high_score = score
        plaintext = possible_plaintext
      end
    end)

    ciphertext
  end

  defp convert(char, ciphertext) do
    cipher = String.duplicate(char, String.length(ciphertext))
    IO.inspect my_hex_xor(cipher, ciphertext)
  end

  defp score(plaintext) do
    5
  end

  defp frequency_map do
    %{
      "E" => 13, "T" => 12, "A" => 11, "O" => 10,
      "I" => 9, "N" => 8, "S" => 7, "H" => 6, "R" => 5,
      "D" => 4, "L" => 3, "U" => 2
    }
  end
end
