defmodule RpgSimulation.CharacterGen do
  alias RpgSimulation.Character

  def gen_character(name, hp \\ 50, stat_pool \\ 25) do
    atk = scaled_stat_allocation(stat_pool, stat_pool)
    mp = scaled_stat_allocation(stat_pool, stat_pool - atk)

    %Character{
      name: name,
      max_hit_points: hp,
      hit_points: hp,
      attack: atk,
      magic_power: mp,
      defense: stat_pool - atk - mp
    }
  end

  defp scaled_stat_allocation(stat_pool, remaining_stat_pool) do
    rolled_stat = :rand.uniform(trunc(stat_pool * 0.4)) + (stat_pool * 0.2)
    min(rolled_stat, remaining_stat_pool)
  end
end

