using JuMP
using MathOptInterface
using Gurobi

include("model.jl")

# Exercise 1 has two sub problemes: Calculate the maximum amout of vegetable oil
# we can produce (this has no cost but will place an upper bound on what we can 
# produce) where the variables are the number of hectars that are
# used for each crop.
# Part 2 of exercise 1: Given these constraints on the amount of vegetable oil and
# regular oil we can produce, how much of these (in liters) do we produce to maximize
# profits.

m, x = build_land_use_model("data.jl")
print(m)

set_optimizer(m, Gurobi.Optimizer)
optimize!(m)

println("Amount of oil: ", objective_value(m))
println("Land for [soy, sunflower, cotton]: ", value.(x.data))
