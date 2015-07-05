defmodule SetTwo.ChallengeTwelveTest do
  use ExUnit.Case, async: true
  import SetTwo.ChallengeTwelve
  doctest SetTwo.ChallengeTwelve

  test "cracks the code" do
   IO.inspect crack_code
    # encryption_oracle_2(love_story)
  end

  def love_story do
"""
  I got tired of waiting
  Wondering if you were ever coming around.
  My faith in you was fading
  When I met you on the outskirts of town.
  And I said...

  Romeo, save me, I've been feeling so alone.
  I keep waiting for you but you never come.
  Is this in my head? I don't know what to think.
  He knelt to the ground and pulled out a ring and said...
"""
  end
end
