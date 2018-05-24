defmodule SetTwo.ChallengeTwelveTest do
  use ExUnit.Case, async: true
  import SetTwo.ChallengeTwelve
  doctest SetTwo.ChallengeTwelve

  test "cracks the code" do
    assert crack_code() == "Rollin' in my 5.0\nWith my rag-top down so my hair can blow\nThe girlies on standby waving just to say hi\nDid you stop? No, I just drove by\n"
  end
end
