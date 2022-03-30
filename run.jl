using JuMP
using MathOptInterface
using Gurobi
using Plots

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

taxes = [0.2, 0.05, 0]

m_profit, b = build_profit_model("data.jl", objective_value(m_veg_oil), taxes)
print(m_profit)

set_optimizer(m_profit, Gurobi.Optimizer)
optimize!(m_profit)

println("Amount of profit: ", objective_value(m_profit))
println("Fuel of each mixture [b5, b30, b100]: ", value.(b.data))

function get_mix_distribution(taxes)
    m_profit, b = build_profit_model("data.jl", objective_value(m_veg_oil), taxes)
    set_optimizer(m_profit, Gurobi.Optimizer)
    optimize!(m_profit)

    return objective_value(m_profit)
end

t_range = 0:0.01:0.2

profit_list = zeros(length(t_range), 3)

profit_list[:, 1] = get_mix_distribution.([[t, 0.05, 0] for t in t_range])
profit_list[:, 2] = get_mix_distribution.([[0.2, t, 0] for t in t_range])
profit_list[:, 3] = get_mix_distribution.([[0.2, 0.05, t] for t in t_range])

plt = plot(t_range .* 100, profit_list, 
    label=["B5 tax" "B30 tax" "B100 tax"], 
    dpi=300,
    xlabel="Taxes %",
    ylabel="Profit €")
savefig(plt, "profit-tax-all-else-equal.png")

