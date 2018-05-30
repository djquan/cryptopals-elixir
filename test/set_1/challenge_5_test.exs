defmodule SetOne.ChallengeFiveTest do
  use ExUnit.Case, async: true
  import SetOne.ChallengeFive

  test "repeating key xor" do
    plaintext = "Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal"

    expected_result =
      "0B3637272A2B2E63622C2E69692A23693A2A3C6324202D623D63343C2A26226324272765272A282B2F20430A652E2C652A3124333A653E2B2027630C692B20283165286326302E27282F"

    assert expected_result == repeating_xor_encrypt(plaintext, "ICE")
  end
end
