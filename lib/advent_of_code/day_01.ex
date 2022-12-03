defmodule AdventOfCode.Day01 do
  defp calories_per_elf(input) do
    input
    |> String.split("\n\n", trim: true)
    # Gives back an array of arrays with string
    |> Enum.map(&(&1 |> String.split("\n", trim: true)))
    # Gives us back a split array of strings
    |> Enum.map(fn arr -> Enum.map(arr, fn el -> String.to_integer(el) end) end)
  end

  defp total_calories_per_elf(cal_per_elf), do: cal_per_elf |> Enum.map(&Enum.sum/1)

  @spec part1(String.t()) :: any
  def part1(input) do
    input
    |> calories_per_elf()
    |> total_calories_per_elf()
    |> Enum.max()
  end

  def part2(input) do
    input
    |> calories_per_elf()
    |> total_calories_per_elf()
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end
end
