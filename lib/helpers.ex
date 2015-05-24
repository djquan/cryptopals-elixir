defmodule Helpers do
  # taken from Programming Elixir by Dave Thomas
  def pmap(collection, fun) do
    me = self
    collection
    |> Enum.map(fn (elem) ->
      spawn_link fn -> (send me, { self, fun.(elem) }) end
    end)
    |> Enum.map(fn (pid) ->
      receive do { ^pid, result } -> result end
    end)
  end

  # taken from http://www.math.cornell.edu/~mec/2003-2004/cryptography/subs/frequencies.html
  # added spaces with a weighted value
  def frequency_map do
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
