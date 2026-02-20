# # Параметрическое исследование
using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots
using DataFrames
using JLD2

script_name = splitext(basename(PROGRAM_FILE))[1]
mkpath(plotsdir(script_name))
mkpath(datadir(script_name))

function exponential_growth!(du, u, p, t)
    α = p
    du[1] = α * u[1]
end

# Исследуем разные значения α
α_values = [0.1, 0.3, 0.5, 0.8, 1.0]
u0 = [1.0]
tspan = (0.0, 10.0)

plt = plot(size=(800, 500))
for α in α_values
    prob = ODEProblem(exponential_growth!, u0, tspan, α)
    sol = solve(prob, Tsit5(), saveat=0.1)
    plot!(plt, sol.t, first.(sol.u), label="α = $α", lw=2)
end

plot!(plt, xlabel="Время t", ylabel="Популяция u",
      title="Сравнение разных значений α", legend=:topleft)

savefig(plt, plotsdir(script_name, "parametric_scan_comparison.png"))
println("График сохранен в: ", plotsdir(script_name, "parametric_scan_comparison.png"))

# График времени удвоения
α_range = 0.1:0.01:1.0
doubling_times = log.(2) ./ α_range

plt2 = plot(α_range, doubling_times, 
            label="Теория: T₂ = ln(2)/α", 
            xlabel="Скорость роста α", 
            ylabel="Время удвоения T₂",
            title="Зависимость времени удвоения от α",
            lw=2)

# Численные результаты
numerical_times = [log(2)/α for α in α_values]
scatter!(plt2, α_values, numerical_times, 
         label="Численные значения", 
         markersize=8, 
         markercolor=:red)

savefig(plt2, plotsdir(script_name, "doubling_time_vs_alpha.png"))

println("\nВсе графики созданы!")
