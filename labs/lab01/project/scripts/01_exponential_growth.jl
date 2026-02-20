# # Экспоненциальный рост
# 
# ## Инициализация проекта
using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots
using DataFrames
using JLD2

# Создаем директории для результатов
script_name = splitext(basename(PROGRAM_FILE))[1]
mkpath(plotsdir(script_name))
mkpath(datadir(script_name))

# ## Определение модели
function exponential_growth!(du, u, p, t)
    α = p
    du[1] = α * u[1]
end

# ## Параметры модели
u0 = [1.0]  # начальная популяция
α = 0.3     # скорость роста
tspan = (0.0, 10.0)  # временной интервал

# ## Решение
prob = ODEProblem(exponential_growth!, u0, tspan, α)
sol = solve(prob, Tsit5(), saveat=0.1)

# ## Визуализация
plt = plot(sol, 
           label="u(t)", 
           xlabel="Время t", 
           ylabel="Популяция u",
           title="Экспоненциальный рост (α = $α)",
           lw=2, 
           legend=:topleft)

# Сохраняем график
savefig(plt, plotsdir(script_name, "exponential_growth_α=$α.png"))
println("График сохранен в: ", plotsdir(script_name, "exponential_growth_α=$α.png"))

# ## Анализ
df = DataFrame(t=sol.t, u=first.(sol.u))
println("Первые 5 строк результатов:")
println(first(df, 5))

doubling_time = log(2) / α
println("\nВремя удвоения: ", round(doubling_time; digits=2))

# ## Сохранение данных
@save datadir(script_name, "results.jld2") df
println("Данные сохранены в: ", datadir(script_name, "results.jld2"))
