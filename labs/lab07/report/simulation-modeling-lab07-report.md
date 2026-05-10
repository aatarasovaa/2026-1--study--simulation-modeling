# Отчёт по лабораторной работе 07
Тарасова Алина Андреевна

-   [<span class="toc-section-number">1</span> Цель
    работы](#цель-работы)
-   [<span class="toc-section-number">2</span> Задание](#задание)
-   [<span class="toc-section-number">3</span> Теоретическое
    введение](#теоретическое-введение)
-   [<span class="toc-section-number">4</span> Выполнение лабораторной
    работы](#выполнение-лабораторной-работы)
-   [Список литературы](#список-литературы)

# Цель работы

Целью работы является освоение метода дискретно-событийного
моделирования на примере двух систем массового обслуживания:

Многоканальной СМО M/M/c с пуассоновским входящим потоком и
экспоненциальным временем обслуживания.

Модели Росса — системы с конечным числом машин, резервом и ремонтом
(одно или несколько ремонтных устройств).

В ходе работы необходимо:

реализовать модели на языке Julia с использованием пакетов ConcurrentSim
и ResumableFunctions;

перевести код в литературный стиль;

получить численные характеристики (время ожидания, загрузку, среднее
время до отказа и т.д.);

построить графики динамики числа исправных машин и показателей загрузки;

выполнить параметрические исследования (разное число
каналов/ремонтников, разное число резервных машин);

сравнить результаты моделирования с аналитическими формулами (для
M/M/c).

# Задание

Создать каталог lab07 и инициализировать проект DrWatson.

Установить пакеты: ConcurrentSim, ResumableFunctions, Distributions,
Plots, Literate.

Реализовать модель M/M/c и модель Росса на Julia.

Преобразовать код в литературный стиль.

Сгенерировать чистый код, Jupyter Notebook и Quarto-документацию.

Добавить параметрические расчёты (разное число каналов, ремонтников,
машин).

Построить графики: динамика очереди, число исправных машин, загрузка
ремонтника.

Интегрировать всё в отчёт и скомпилировать в PDF.

# Теоретическое введение

Дискретно-событийное моделирование — метод, при котором система меняет
состояние только в моменты событий (приход заявки, начало/конец
обслуживания, отказ). Время перескакивает от события к событию.

Модель M/M/c — многоканальная СМО с пуассоновским входным потоком,
экспоненциальным обслуживанием и c параллельными каналами. Ключевой
параметр — загрузка ρ = λ/(cμ). Если ρ \< 1, система стационарна.

Модель Росса — система из N работающих машин и S резервных. При поломке
машина идёт в ремонт (одно или несколько устройств), резервная заменяет
её. Если резерва нет — система падает. Требуется оценить среднее время
до падения.

# Выполнение лабораторной работы

### 1. Создание нового релиза

Создаем новый релиз v.7.0.0

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

<img src="image/6_1.png" style="width:70.0%" />

Запуск первого скрипта scripts/mmc_model.jl

<img src="image/8.png" style="width:70.0%" />

<img src="image/9.png" style="width:70.0%" />

Создание, запуск следующего скрипта scripts/ross_model.jl и создание его
производных форматов

<img src="image/10.png" style="width:70.0%" />

<img src="image/11.png" style="width:70.0%" />

Создаем производные форматы от скриптов

<img src="image/16_1.png" style="width:70.0%" />

<img src="image/17_1.png" style="width:70.0%" />

В каталоге отчёта в файл \_quarto.yml включаем поддержку кода julia

<img src="image/21.png" style="width:70.0%" />

В файле отчёта подключаем файл описания программ

<img src="image/20.png" style="width:70.0%" />

``` {julia}
using StableRNGs
using Distributions
using ConcurrentSim
using ResumableFunctions
#set simulation parameters
rng = StableRNG(123)
num_customers = 10 # total number of customers generated
```

set queue parameters

``` {julia}
num_servers = 2 # number of servers
mu = 1.0 / 2 # service rate
lam = 0.9 # arrival rate
arrival_dist = Exponential(1 / lam) # interarrival time distribution
service_dist = Exponential(1 / mu) # service time distribution
```

define customer behavior

``` {julia}
@resumable function customer(
env::Environment,
server::Resource,
id::Integer,
t_a::Float64,
d_s::Distribution,
)
@yield timeout(env, t_a) # customer arrives
println("Customer $id arrived: ", now(env))
@yield request(server) # customer starts service
println("Customer $id entered service: ", now(env))
@yield timeout(env, rand(rng, d_s)) # server is busy
@yield unlock(server) # customer exits service
println("Customer $id exited service: ", now(env))
end
```

setup and run simulation

``` {julia}
function setup_and_run()
sim = Simulation() # initialize simulation environment
server = Resource(sim, num_servers) # initialize servers
arrival_time = 0.0
for i = 1:num_customers # initialize customers
arrival_time += rand(rng, arrival_dist)
@process customer(sim, server, i, arrival_time, service_dist)
end
run(sim) # run simulation
end
setup_and_run()
```

``` {julia}
using ResumableFunctions
using ConcurrentSim
using Distributions
using Random
using StableRNGs
const RUNS = 5
const N = 10
const S = 3
const SEED = 150
const LAMBDA = 100
const MU = 1
const rng = StableRNG(42) # setting a random seed for reproducibility
const F = Exponential(LAMBDA)
const G = Exponential(MU)
@resumable function machine(
env::Environment,
repair_facility::Resource,
spares::Store{Process},
)
while true
try
@yield timeout(env, Inf)
catch
end
@yield timeout(env, rand(rng, F))
get_spare = take!(spares)
@yield get_spare | timeout(env)
if state(get_spare) != ConcurrentSim.idle
@yield interrupt(value(get_spare))
else
throw(StopSimulation("No more spares!"))
end
@yield request(repair_facility)
@yield timeout(env, rand(rng, G))
@yield unlock(repair_facility)
@yield put!(spares, active_process(env))
end
end
@resumable function start_sim(
env::Environment,
repair_facility::Resource,
spares::Store{Process},
)
for i = 1:N
proc = @process machine(env, repair_facility, spares)
@yield interrupt(proc)
end
for i = 1:S
proc = @process machine(env, repair_facility, spares)
@yield put!(spares, proc)
end
end
function sim_repair()
sim = Simulation()
repair_facility = Resource(sim)
spares = Store{Process}(sim)
@process start_sim(sim, repair_facility, spares)
msg = run(sim)
stop_time = now(sim)
println("At time $stop_time: $msg")
stop_time
end
results = Float64[]
for i = 1:RUNS
push!(results, sim_repair())
end
println("Average crash time: ", sum(results)/RUNS)
```

Реализованы обе модели на Julia с использованием ConcurrentSim.

Проведены параметрические исследования:

Для M/M/c: исследовано влияние числа каналов на длину очереди и время
ожидания.

Для модели Росса: исследовано влияние числа ремонтников и резервных
машин на среднее время до падения системы.

Построены графики: динамика числа заявок в системе, загрузка ремонтника,
изменение числа исправных машин.

Код оформлен в литературном стиле, сгенерированы чистые скрипты,
Notebook и Quarto-документы.

Отчёт скомпилирован в PDF.

# Список литературы

Имитационное моделирование. Практикум
https://esystem.rudn.ru/pluginfile.php/3094278/modeling-lab.pdf
