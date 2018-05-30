defmodule SetTwo.ChallengeElevenTest do
  use ExUnit.Case, async: true
  import SetTwo.ChallengeEleven
  doctest SetTwo.ChallengeEleven

  setup do
    :rand.seed(:exs1024)
    :ok
  end

  test "generates a random AES key" do
    assert byte_size(generate_random_aes_key()) == 16
  end

  test "encrypts either with cbc or ecb" do
    {encryption_type, _ciphertext} = encrypt_random_ecb_cbc(bad_blood())
    assert Regex.match?(~r/ecb|cbc/, encryption_type)
  end

  test "determines whether a ciphertext was encrypted with cbc or ecb" do
    {encryption_type, ciphertext} = encryption_oracle(bad_blood())
    assert encryption_type == discover_type(ciphertext)
  end

  def bad_blood do
    """
    Cause, baby, now we got bad blood
    You know it used to be mad love
    So take a look what youve done
    Cause, baby, now we got bad blood
    Hey
    Now we got problems
    And I dont think we can solve them
    You made a really deep cut
    And, baby, now we got bad blood
    Hey

    Did you have to do this? I was thinking that you could be trusted
    Did you have to ruin what was shiny? Now its all rusted
    Did you have to hit me, where Im weak? Baby, I couldnt breathe
    And rub it in so deep, salt in the wound like youre laughing right at me

    Oh, its so sad to think about the good times, you and I

    Cause, baby, now we got bad blood
    You know it used to be mad love
    So take a look what youve done
    Cause, baby, now we got bad blood
    Hey
    Now we got problems
    And I dont think we can solve them
    You made a really deep cut
    And, baby, now we got bad blood
    Hey

    Did you think wed be fine? Still got scars on my back from your knife
    So dont think its in the past, these kinda wounds they last and they last.
    Now did you think it all through? All these things will catch up to you
    And time can heal but this wont, so if youre coming my way, just dont

    Oh, its so sad to think about the good times, you and I

    Cause, baby, now we got bad blood
    You know it used to be mad love
    So take a look what youve done
    Cause, baby, now we got bad blood
    Hey
    Now we got problems
    And I dont think we can solve them
    You made a really deep cut
    And, baby, now we got bad blood
    Hey

    Band-aids dont fix bullet holes
    You say sorry just for show
    If you live like that, you live with ghosts (ghosts)
    Band-aids dont fix bullet holes (hey)
    You say sorry just for show (hey)
    If you live like that, you live with ghosts (hey)
    If you love like that blood runs cold

    Cause, baby, now we got bad blood
    You know it used to be mad love (mad love)
    So take a look what youve done
    Cause, baby, now we got bad blood
    Hey
    Now we got problems
    And I dont think we can solve them (think we can solve them)
    You made a really deep cut
    And, baby, now we got bad blood
    Hey

    Cause, baby, now we got bad blood
    You know it used to be mad love
    So take a look what youve done (look what youve done)
    Cause, baby, now we got bad blood
    Hey
    Now we got problems
    And I dont think we can solve them
    You made a really deep cut
    And, baby, now we got bad blood
    Hey
    """
  end
end
