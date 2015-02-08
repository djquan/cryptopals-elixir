defmodule SetOne do
  use Bitwise;

  def hex_to_base64(input) do
    String.upcase(input) |> 
      Base.decode16! |>
      Base.encode64
  end

  def my_hex_xor(a, b) do
    my_xor(Base.decode16!(a), Base.decode16!(b)) |>
      to_string |>
      Base.encode16
  end

  def my_xor(a,b) do
    for x <- b, do: x
  end

  # <<r::8, g::8, b::8 <- pixels >>, do: {r, g, b}

end
