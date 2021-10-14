defmodule RpgSimulation.Combat do
  @moduledoc """
  Combat between two characters.
  """
  alias RpgSimulation.Character

  def simulate_round(%Character{} = char1, %Character{} = char2) do
    char1 = apply_attack(char2, char1)
    char2 = apply_attack(char1, char2)
    case check_game_over(char1, char2) do
      :draw ->
        IO.puts("The combat ended in a draw")
        %Character{}
      :char1 ->
        IO.puts("#{char1.name} has won the combat!")
        char1
      :char2 ->
        IO.puts("#{char2.name} has won the combat!")
        char2
      :no_winner ->
        simulate_round(char1, char2)
    end
  end

  defp apply_attack(%Character{} = attacker, %Character{} = defender) do
    case calc_attack_type(attacker) do
      :attack ->
        damage = attacker.attack |> add_variance() |> calc_attack(defender.defense)
        IO.puts("#{attacker.name} punches #{defender.name} for #{damage} damage!")
        Map.put(defender, :hit_points, defender.hit_points - damage)
      :fireball ->
        damage = attacker.magic_power |> add_variance() |> calc_attack(defender.defense)
        IO.puts("#{attacker.name} fireballs #{defender.name} for #{damage} damage!")
        Map.put(defender, :hit_points, defender.hit_points - damage)
    end
  end

  defp calc_attack(damage, defense) do
    (damage - defense)
  end

  defp calc_attack_type(%Character{} = char) do
    n_pool = char.attack + char.magic_power
    roll = :rand.uniform(trunc(n_pool))
    if roll < char.attack do
      :attack
    else
      :fireball
    end
  end

  defp add_variance(value) do
    :rand.uniform(3) - 2 + value
  end

  defp check_game_over(%Character{} = char1, %Character{} = char2) do
    cond do
      char1.hit_points <= 0 && char2.hit_points <= 0 ->
        :draw
      char1.hit_points <= 0 ->
        :char2
      char2.hit_points <= 0 ->
        :char1
      true ->
        :no_winner
    end
  end
end
