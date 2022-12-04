defmodule AdventOfCode.Day02 do
  def shape("A"), do: :rock
  def shape("B"), do: :paper
  def shape("C"), do: :scissors
  def shape("X"), do: :rock
  def shape("Y"), do: :paper
  def shape("Z"), do: :scissors

  # Score for shape
  def shape(:rock), do: 1
  def shape(:paper), do: 2
  def shape(:scissors), do: 3

  # Winning according to rules of rock paper scissors
  defp win(:rock, :paper), do: :lose  
  defp win(:rock, :scissors), do: :win  
  defp win(:rock, :rock), do: :tie  

  defp win(:paper, :rock), do: :win  
  defp win(:paper, :paper), do: :tie  
  defp win(:paper, :scissors), do: :lose  

  defp win(:scissors, :rock), do: :lose  
  defp win(:scissors, :paper), do: :win  
  defp win(:scissors, :scissors), do: :tie 

  # What do we need to win or lose against symbol
  defp reverse_shape(:paper, :win), do: :scissors
  defp reverse_shape(:paper, :tie), do: :paper
  defp reverse_shape(:paper, :lose), do: :rock

  defp reverse_shape(:rock, :win), do: :paper
  defp reverse_shape(:rock, :tie), do: :rock
  defp reverse_shape(:rock, :lose), do: :scissors

  defp reverse_shape(:scissors, :win), do: :rock
  defp reverse_shape(:scissors, :tie), do: :scissors
  defp reverse_shape(:scissors, :lose), do: :paper

  defp win_or_loss("X"), do: :lose
  defp win_or_loss("Y"), do: :tie
  defp win_or_loss("Z"), do: :win

  defp score([first, second]), do: score(first, second)
  defp score(:win, symbol), do: 6 + shape(symbol)
  defp score(:tie, symbol), do: 3 + shape(symbol)
  defp score(:lose, symbol), do: 0 + shape(symbol)

  defp convert_to_score([me, opponent]) do
    score(win(me, opponent), me)
  end

  defp convert_input_to_rounds2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn arr -> arr |> String.split(" ", trim: true) end)
    |> Enum.map(fn arr -> [Enum.at(arr, 0) |> shape(), Enum.at(arr, 1) |> win_or_loss()]  end)
    |> Enum.map(fn arr -> [Enum.at(arr, 1), reverse_shape(Enum.at(arr, 0), Enum.at(arr, 1))] end)
  end

  defp convert_input_to_rounds(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn arr -> arr |> String.split(" ", trim: true) end)
    |> Enum.map(fn arr -> arr |> Enum.map(fn letter -> shape(letter) end) end)
  end

  def part1(input) do
    input
    |> convert_input_to_rounds()
    |> Enum.map(fn round -> round |> convert_to_score end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> convert_input_to_rounds2()
    |> Enum.map(fn round -> score(round) end)
    |> Enum.sum()

  end
end
