
Crops = ["Soybeans", "Sunflower seeds", "Cotton seeds"]
I_land_use = 1:3
J_land_use = 1:2 # set of constraints

Resource_Max = [1600, 5000] # [amount of land, amount of water]

Liters_oil_per_Ha = [2600 * 0.178 1400 * 0.216 900 * 0.433] # Litres per hectar for 
# [soybeans, sunflower seeds, cotton seeds]
Litres_water_per_Ha = [5 4.2 1]

Resource_use = [1 1 1; Litres_water_per_Ha]




I_fuel_mixtures = 1:3
J_fuel_mixtures = 1:3

Max_amount_vegetable_oil = 685_655 # Found by running the part of the program that
# optimizes the amount of vegetable oil produced.

Max_amount_petrodisel = 150_000

Profit_b5 = 1.43 * 0.8 - 1 * 0.95 - 0.05 * 0.2 / 0.9 * 1.5 # sale after tax -
Profit_b30 = 1.29 * 0.95 - 1 * 0.7 - 0.3 * 0.2 / 0.9 * 1.5 # - petrodisel cost -
Profit_b100 = 1.16 * 1 - 0.2 / 0.9 * 1.5 # - methanol cost per litre

Profit_fuel_mixtures = [Profit_b5 Profit_b30 Profit_b100]

Petro_disel_used = [0.95 0.7 0]
Veg_oil_used = [0.05 0.3 1] ./ 0.9

Min_fuel_produced = 280_000

