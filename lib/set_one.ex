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
end
