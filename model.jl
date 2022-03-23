
function build_land_use_model(data_file::String)
    include(data_file)
    m = Model()
    @variable(m, x[I] >= 0) # amount of land used for each crop.
    @constraint(m, Resource_Max, Resource_use * x .<= Resource_Max)
    @objective(m, Max, Liters_oil_per_Ha * x)
    return m, x
end