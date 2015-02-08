defmodule SetOne do
  def hex_to_base64(input) do
    String.upcase(input) |> 
      Base.decode16! |>
      Base.encode64
  end
end
