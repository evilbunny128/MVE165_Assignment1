
function build_land_use_model(data_file::String)
    include(data_file)
    m = Model()
    @variable(m, x[I_land_use] >= 0) # amount of land used for each crop.
    @constraint(m, Resource_constraint[j in J_land_use], sum(Resource_use[j,i] * x[i] for i in I_land_use) <= Resource_Max[j])
    @objective(m, Max, sum(Liters_oil_per_Ha[i] * x[i] for i in I_land_use))
    return m, x, Resource_constraint
end