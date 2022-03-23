
Crops = ["Soybeans", "Sunflower seeds", "Cotton seeds"]
I_land_use = 1:3
J_land_use = 1:2 # set of constraints

Resource_Max = [1600, 5000] # [amount of land, amount of water]

Liters_oil_per_Ha = [2600 * 0.178 1400 * 0.216 900 * 0.433] # Litres per hectar for 
# [soybeans, sunflower seeds, cotton seeds]
Litres_water_per_Ha = [5 4.2 1]

Resource_use = [1 1 1; Litres_water_per_Ha]
