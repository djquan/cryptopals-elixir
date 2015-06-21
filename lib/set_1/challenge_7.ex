defmodule SetOne.ChallengeSeven do
  def decrypt_aes_128_ecb(ciphertext, cipher) when is_binary(ciphertext) do
    ciphertext
    |> :binary.bin_to_list
    |> Enum.chunk(16)
    |> Enum.map(&(decrypt_aes_128_ecb(&1, cipher)))
    |> Enum.join("")
  end

  def decrypt_aes_128_ecb(ciphertext, cipher) when is_list(ciphertext) do
    :crypto.block_decrypt(:aes_cbc128, cipher, String.duplicate(<<0>>, 16), ciphertext)
  end
end
