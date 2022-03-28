using JuMP
using MathOptInterface
using Gurobi

include("model.jl")

# Exercise 1 has two sub problemes: Calculate the maximum amout of vegetable 
# oil we can produce (this has no cost but will place an upper bound on what
# we can produce) where the variables are the number of hectars that are
# used for each crop.
# Part 2 of exercise 1: Given these constraints on the amount of vegetable 
# oil and regular oil we can produce, how much of these (in liters) do we 
# produce to maximize profits.

m_veg_oil, x = build_land_use_model("data.jl")
print(m_veg_oil)

set_optimizer(m_veg_oil, Gurobi.Optimizer)
optimize!(m_veg_oil)

println("Amount of oil: ", objective_value(m_veg_oil))
println("Land for [soy, sunflower, cotton]: ", value.(x.data))

m_profit, b = build_profit_model("data.jl", objective_value(m_veg_oil))
print(m_profit)

set_optimizer(m_profit, Gurobi.Optimizer)
optimize!(m_profit)

println("Amount of profit: ", objective_value(m_profit))
println("Fuel of each mixture [b5, b30, b100]: ", value.(b.data))


