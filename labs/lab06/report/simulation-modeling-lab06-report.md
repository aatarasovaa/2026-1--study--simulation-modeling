# Отчёт по лабораторной работе 06
Тарасова Алина Андреевна

-   [<span class="toc-section-number">1</span> Цель
    работы](#цель-работы)
-   [<span class="toc-section-number">2</span> Задание](#задание)
-   [<span class="toc-section-number">3</span> Теоретическое
    введение](#теоретическое-введение)
-   [<span class="toc-section-number">4</span> Выполнение лабораторной
    работы](#выполнение-лабораторной-работы)
-   [<span class="toc-section-number">5</span> Выводы](#выводы)
-   [Список литературы](#список-литературы)

# Цель работы

Реализовать эпидемиологическую модель SIR
(Susceptible–Infectious–Recovered) с использованием сетей Петри,
выполнить детерминированное и стохастическое моделирование, исследовать
влияние параметров на динамику эпидемии.

# Задание

Создать рабочий каталог и установить необходимые пакеты.

Выполнить предложенный код модели SIR.

Преобразовать код в литературный стиль (Literate Programming).

Сгенерировать из литературного кода: чистый код, Jupyter Notebook и
документацию в формате Quarto.

Выполнить код из Jupyter Notebook.

Интегрировать документацию Quarto в отчёт.

Добавить в литературный код вычисления для нового набора параметров.

Повторить генерацию всех артефактов с новыми параметрами и выполнить их.

Интегрировать новую документацию Quarto в отчёт.

# Теоретическое введение

Модель SIR описывает распространение эпидемии в популяции. Люди делятся
на три группы: восприимчивые к болезни (S), инфицированные (I) и
выздоровевшие с иммунитетом (R). Переходы между состояниями задаются
двумя процессами: заражение (S + I → I + I) с коэффициентом β и
выздоровление (I → R) с коэффициентом γ. Для моделирования используются
сети Петри — математический аппарат для описания дискретных
распределённых систем. В работе применяются два подхода:
детерминированный (решение системы обыкновенных дифференциальных
уравнений на основе закона действующих масс) и стохастический (прямой
алгоритм Гиллеспи, учитывающий случайные флуктуации). Начальные условия:
990 восприимчивых, 10 заражённых, 0 выздоровевших. Исследуется влияние
коэффициента заражения β на пик эпидемии и конечное число переболевших.

# Выполнение лабораторной работы

### 1. Создание нового релиза

Создаем новый релиз v.6.0.0 и обновляем информацию по релизу v.4.0.0

<img src="image/1.png" style="width:70.0%" />

### 2. Настройка окружения Julia

Запускаем Julia и установку пакетов

<img src="image/2.png" style="width:70.0%" />

<img src="image/3.png" style="width:70.0%" />

### 3. Запуск скриптов и тема работы

Устанавливаем необходимые пакеты для первого скрипта

<img src="image/4.png" style="width:70.0%" />

<img src="image/5.png" style="width:70.0%" />

<img src="image/6.png" style="width:70.0%" />

Запуск первого скрипта scripts/sirpetri_run.jl

<img src="image/8.png" style="width:70.0%" />

<img src="image/8_1.png" style="width:70.0%" />

<img src="image/8_2.png" style="width:70.0%" />

<img src="plots/sir_stoch_dynamics.png" style="width:70.0%" />

<img src="plots/sir_det_dynamics.png" style="width:70.0%" />

<img src="image/9.png" style="width:70.0%" />

Создание, запуск следующего скрипта scripts/sirpetri_scan_parameters.jl
и создание его производных форматов

<img src="image/10.png" style="width:70.0%" />

<img src="image/12.png" style="width:70.0%" />

<img src="image/11.png" style="width:70.0%" />

Далее снова перехожу в директорию проекта и создаю и запускаю следующий
скрипт scripts/sirpetri_animate.jl

<img src="image/13.png" style="width:70.0%" />

<img src="image/14.png" style="width:70.0%" />

<img src="image/15.png" style="width:70.0%" />

Далее снова перехожу в директорию проекта и создаю и запускаю следующий
скрипт scripts/sirpetri_report.jl

<img src="image/16.png" style="width:70.0%" />

<img src="image/comparison.png" style="width:70.0%" />

<img src="image/sensitivity.png" style="width:70.0%" />

<img src="image/18.png" style="width:70.0%" />

Устанавливаем необходимые пакеты для производных форматов

<img src="image/15.png" style="width:70.0%" />

Создаем производные форматы от скриптов

<img src="image/16_1.png" style="width:70.0%" />

<img src="image/17_1.png" style="width:70.0%" />

<img src="image/18_1.png" style="width:70.0%" />

<img src="image/18_2.png" style="width:70.0%" />

<img src="image/18_3.png" style="width:70.0%" />

В каталоге отчёта в файл \_quarto.yml включаем поддержку кода julia

<img src="image/21.png" style="width:70.0%" />

В файле отчёта подключаем файл описания программ

<img src="image/20.png" style="width:70.0%" />

``` {julia}
module SIRPetri
using AlgebraicPetri
using Catlab.CategoricalAlgebra
using Catlab.Graphics
using OrdinaryDiffEq
using Plots
using DataFrames
using Random
export build_sir_network, simulate_deterministic, simulate_stochastic
export plot_sir, to_graphviz_sir
"""
build_sir_network(β=0.3, γ=0.1)
Создаёт размеченную сеть Петри для модели SIR.
Возвращает (net::LabelledPetriNet, u0::Vector{Float64}, states::Vector{Symbol})
"""
function build_sir_network(β = 0.3, γ = 0.1)
states = [:S, :I, :R]
```

Создаём сеть Петри, описывая переходы напрямую Переход infection: S + I
→ I + I Переход recovery: I → R

``` {julia}
net = LabelledPetriNet(
states,
:infection => ([:S, :I] => [:I, :I]),
:recovery => ([:I] => [:R]),
)
```

Начальная маркировка: S=990, I=10, R=0

``` {julia}
u0 = [990.0, 10.0, 0.0]
return net, u0, states
end
"""
sir_ode(net, rates)
Возвращает функцию правой части ОДУ для сети Петри.
Используется для детерминированной симуляции.
"""
function sir_ode(net, rates = [0.3, 0.1])
function f!(du, u, p, t)
S, I, R = u
β, γ = rates
```

Пропускные способности (закон действующих масс)

``` {julia}
infection_rate = β * S * I
recovery_rate = γ * I
```

Изменения

``` {julia}
du[1] = -infection_rate # dS/dt
du[2] = infection_rate - recovery_rate # dI/dt
du[3] = recovery_rate # dR/dt
end
return f!
end
"""
simulate_deterministic(net, u0, tspan; saveat=0.1, rates=[0.3,0.1])
Выполняет детерминированную ODE-симуляцию.
Возвращает DataFrame с колонками time, S, I, R.
"""
function simulate_deterministic(net, u0, tspan; saveat = 0.1, rates = [0.3, 0.1])
f = sir_ode(net, rates)
prob = ODEProblem(f, u0, tspan)
sol = solve(prob, Tsit5(), saveat = saveat)
df = DataFrame(time = sol.t)
df.S = sol[1, :]
df.I = sol[2, :]
df.R = sol[3, :]
return df
end
"""
simulate_stochastic(net, u0, tspan; rates=[0.3,0.1], rng=Random.GLOBAL_RNG)
Стохастическая симуляция (алгоритм Гиллеспи) прямым методом.
Возвращает DataFrame.
"""
function simulate_stochastic(net, u0, tspan; rates = [0.3, 0.1], rng = Random.GLOBAL_RNG)
u = copy(u0)
t = 0.0
times = [t]
states = [copy(u)]
β, γ = rates
while t < tspan[2]
S, I, R = u
a_inf = β * S * I
a_rec = γ * I
a0 = a_inf + a_rec
if a0 == 0
break
end
dt = -log(rand(rng)) / a0
r = rand(rng) * a0
if r < a_inf
```

Заражение

``` {julia}
u[1] -= 1
u[2] += 1
else
```

Выздоровление

``` {julia}
u[2] -= 1
u[3] += 1
end
t += dt
if t <= tspan[2]
push!(times, t)
push!(states, copy(u))
end
end
df = DataFrame(time = times)
df.S = [s[1] for s in states]
df.I = [s[2] for s in states]
df.R = [s[3] for s in states]
return df
end
"""
plot_sir(df)
Строит график динамики S, I, R из DataFrame.
"""
function plot_sir(df)
p = plot(
df.time,
[df.S, df.I, df.R],
label = ["S (Susceptible)" "I (Infected)" "R (Recovered)"],
xlabel = "Time",
ylabel = "Population",
linewidth = 2,
)
return p
end
"""
to_graphviz_sir(net)
Визуализация сети Петри с помощью Graphviz.
"""
function to_graphviz_sir(net)
return to_graphviz(net, prog = "dot")
end
end # module
```

``` {julia}
using DrWatson
@quickactivate "project"
include(srcdir("SIRPetri.jl"))
using .SIRPetri
using DataFrames, CSV, Plots
```

Диапазон β

``` {julia}
β_range = 0.1:0.05:0.8
γ_fixed = 0.1
tmax = 100.0
results = []
for β in β_range
net, u0, _ = build_sir_network(β, γ_fixed)
df = simulate_deterministic(net, u0, (0.0, tmax), saveat = 0.5, rates = [β, γ_fixed])
peak_I = maximum(df.I)
final_R = df.R[end]
push!(results, (β = β, peak_I = peak_I, final_R = final_R))
end
df_scan = DataFrame(results)
CSV.write(datadir("sir_scan.csv"), df_scan)
```

График

``` {julia}
p = plot(
df_scan.β,
[df_scan.peak_I df_scan.final_R],
label = ["Peak I" "Final R"],
marker = :circle,
xlabel = "β (infection rate)",
ylabel = "Population",
)
savefig(plotsdir("sir_scan.png"))
println("Сканирование β завершено. Результат в data/sir_scan.csv")
```

``` {julia}
using DrWatson
@quickactivate "project"
using DataFrames, CSV, Plots
df_det = CSV.read(datadir("sir_det.csv"), DataFrame)
df_stoch = CSV.read(datadir("sir_stoch.csv"), DataFrame)
df_scan = CSV.read(datadir("sir_scan.csv"), DataFrame)
```

Сравнение детерминированной и стохастической динамики

``` {julia}
p1 = plot(
df_det.time,
[df_det.I df_stoch.I[1:length(df_det.time)]],
label = ["Deterministic I" "Stochastic I"],
xlabel = "Time",
ylabel = "Infected",
title = "Comparison",
)
savefig(plotsdir("comparison.png"))
```

Зависимость пика I от β

``` {julia}
p2 = plot(
df_scan.β,
df_scan.peak_I,
marker = :circle,
xlabel = "β",
ylabel = "Peak I",
title = "Sensitivity",
)
savefig(plotsdir("sensitivity.png"))
println("Отчётные графики сохранены в plots/")
```

``` {julia}
using DrWatson
@quickactivate "project"
using Random
include(srcdir("SIRPetri.jl"))
using .SIRPetri
using DataFrames, CSV, Plots
```

Параметры

``` {julia}
β = 0.3
γ = 0.1
tmax = 100.0
```

Создаём сеть

``` {julia}
net, u0, states = build_sir_network(β, γ)
```

Детерминированная симуляция

``` {julia}
df_det = simulate_deterministic(net, u0, (0.0, tmax), saveat = 0.5, rates = [β, γ])
CSV.write(datadir("sir_det.csv"), df_det)
```

Стохастическая симуляция

``` {julia}
Random.seed!(123)
df_stoch = simulate_stochastic(net, u0, (0.0, tmax), rates = [β, γ])
CSV.write(datadir("sir_stoch.csv"), df_stoch)
```

Графики

``` {julia}
p_det = plot_sir(df_det)
savefig(plotsdir("sir_det_dynamics.png"))
p_stoch = plot_sir(df_stoch)
savefig(plotsdir("sir_stoch_dynamics.png"))
println("Базовый прогон завершён. Результаты в data/ и plots/")
```

``` {julia}
using DrWatson
@quickactivate "project"
include(srcdir("SIRPetri.jl"))
using .SIRPetri
using DataFrames, CSV, Plots
```

Диапазон β

``` {julia}
β_range = 0.1:0.05:0.8
γ_fixed = 0.1
tmax = 100.0
results = []
for β in β_range
net, u0, _ = build_sir_network(β, γ_fixed)
df = simulate_deterministic(net, u0, (0.0, tmax), saveat = 0.5, rates = [β, γ_fixed])
peak_I = maximum(df.I)
final_R = df.R[end]
push!(results, (β = β, peak_I = peak_I, final_R = final_R))
end
df_scan = DataFrame(results)
CSV.write(datadir("sir_scan.csv"), df_scan)
```

График

``` {julia}
p = plot(
df_scan.β,
[df_scan.peak_I df_scan.final_R],
label = ["Peak I" "Final R"],
marker = :circle,
xlabel = "β (infection rate)",
ylabel = "Population",
)
savefig(plotsdir("sir_scan.png"))
println("Сканирование β завершено. Результат в data/sir_scan.csv")
```

# Выводы

Детерминированная симуляция даёт гладкую, усреднённую динамику эпидемии
с классическим пиком заболеваемости.

Стохастическая симуляция (алгоритм Гиллеспи) вносит случайные
флуктуации; при большой популяции её результаты близки к
детерминированным, но при малых числах различия существенны.

Сканирование параметра β показывает пороговое поведение: при малых β
эпидемии практически нет, с ростом β пик инфицированных и конечное число
выздоровевших резко возрастают, достигая насыщения.

Анимация динамики наглядно демонстрирует прохождение волны инфекции.

Модель SIR на сетях Петри успешно реализована, позволяет исследовать как
среднюю динамику, так и случайные отклонения, а также оценивать
чувствительность к параметрам.

# Список литературы

Имитационное моделирование. Практикум
https://esystem.rudn.ru/pluginfile.php/3094278/modeling-lab.pdf
