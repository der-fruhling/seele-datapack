scoreboard players enable @a give_seele_miaw
execute as @a[scores={give_seele_miaw=1..}] run function seele:trigger/give_seele_miaw
scoreboard players set @a give_seele_miaw 0

scoreboard players enable @a death
execute as @a[scores={death=1..}] run function seele:trigger/death
scoreboard players set @a death 0
