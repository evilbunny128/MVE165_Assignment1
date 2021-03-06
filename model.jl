
function build_land_use_model(data_file::String, water=Litres_water_per_Ha)
    Resource_use = [1 1 1; water]


    include(data_file)
    m = Model()
    @variable(m, x[I_land_use] >= 0) # amount of land used for each crop.
    @constraint(m, Resource_constraint[j in J_land_use], 
        sum(Resource_use[j,i] * x[i] for i in I_land_use) <= Resource_Max[j])
    @objective(m, Max, sum(Liters_oil_per_Ha[i] * x[i] for i in I_land_use))
    return m, x, Resource_constraint
end

function build_profit_model(data_file::String, Max_amount_vegetable_oil, taxes)
    include(data_file)
    
    taxes = 1 .- taxes

    Profit_b5 = 1.43 * taxes[1] - 1 * 0.95 - 0.05 * 0.2 / 0.9 * 1.5 # sale after tax -
    Profit_b30 = 1.29 * taxes[2] - 1 * 0.7 - 0.3 * 0.2 / 0.9 * 1.5 # - petrodisel cost -
    Profit_b100 = 1.16 * taxes[3] - 0.2 / 0.9 * 1.5 # - methanol cost per litre
    
    Profit_fuel_mixtures = [Profit_b5 Profit_b30 Profit_b100]

    m = Model()
    @variable(m, b[I_fuel_mixtures] >= 0) # Amount produced of each kind of fuel.
    @constraint(m, MinProduced, sum(b) >= Min_fuel_produced)
    @constraint(m, MaxPetrodisel, 
        sum(Petro_disel_used[i] * b[i] for i in I_fuel_mixtures) <= 
            Max_amount_petrodisel)
    @constraint(m, MaxVegOil, 
        sum(Veg_oil_used[i] * b[i] for i in I_fuel_mixtures) <= 
            Max_amount_vegetable_oil)
    @objective(m, Max, 
        sum(Profit_fuel_mixtures[i] * b[i] for i in I_fuel_mixtures))
    return m, b, MinProduced, MaxPetrodisel, MaxVegOil
end
