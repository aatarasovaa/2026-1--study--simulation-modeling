# Дискретно-событийное моделирование
Тарасова Алина Андреевна
2026-05-10

# Информация

## Докладчик

-   Тарасова Алина Андреевна
-   студентка
-   Российский университет дружбы народов им. П. Лумумбы
-   <1132236013@rudn.ru>

# Вводная часть

## Актуальность

-   Дискретно-событийное моделирование широко применяется для анализа
    систем массового обслуживания
-   Модели M/M/c и Росса позволяют оценивать производительность и
    надёжность реальных систем
-   Важно уметь реализовывать такие модели программно и интерпретировать
    результаты

## Объект и предмет исследования

-   **Объект:** системы массового обслуживания
-   **Предмет:** дискретно-событийное моделирование моделей M/M/c и
    Росса на языке Julia

## Цели и задачи

-   Освоить метод дискретно-событийного моделирования
-   Реализовать модели M/M/c и Росса на Julia
-   Провести параметрические исследования
-   Построить графики и сравнить с аналитикой

## Материалы и методы

-   Язык программирования Julia
-   Пакеты: `ConcurrentSim`, `ResumableFunctions`, `Distributions`,
    `Plots`, `Literate`, `DrWatson`
-   Quarto для генерации отчётов и презентаций

# Создание презентации

## Процессор `quarto`

-   Quarto: универсальный издательский инструмент
-   Поддержка Julia, Python, R
-   Создание PDF, HTML, DOCX

## Формат `pdf`

-   Использование LaTeX
-   Пакет для презентации: beamer
-   Автоматическая компиляция через `quarto render`

## Код для формата `pdf`

``` yaml
format:
  beamer:
    theme: metropolis
    aspectratio: 169
    slide-level: 2
```

## Формат `html`

-   Используется фреймворк reveal.js
-   Интерактивная презентация
-   Поддержка анимации и переходов

## Код для формата `html`

``` yaml
format:
  revealjs:
    theme: beige
    slide-number: true
```

# Выполнение лабораторной работы

## 1. Создание нового релиза

-   Создан релиз v.7.0.0 для лабораторной работы №7

<img src="image/1.png" id="fig-release" style="width:70.0%" />

## 2. Настройка окружения Julia

-   Запуск Julia и установка пакетов

<img src="image/2.png" id="fig-julia-start" style="width:70.0%" />

<img src="image/3.png" id="fig-packages" style="width:70.0%" />

## 3. Установка пакетов для скриптов

<img src="image/4.png" id="fig-install1" style="width:70.0%" />

<img src="image/5.png" id="fig-install2" style="width:70.0%" />

<img src="image/6.png" id="fig-install3" style="width:70.0%" />

<img src="image/6_1.png" id="fig-install4" style="width:70.0%" />

## 4. Запуск модели M/M/c

-   Запуск скрипта `scripts/mmc_model.jl`

<img src="image/8.png" id="fig-mmc-run" style="width:70.0%" />

-   Создан Jupyter Notebook для модели M/M/c

<img src="image/9.png" id="fig-mmc-notebook" style="width:70.0%" />

## 5. Запуск модели Росса

-   Запуск скрипта `scripts/ross_model.jl`

<img src="image/10.png" id="fig-ross-run" style="width:70.0%" />

-   Создан Jupyter Notebook для модели Росса

<img src="image/11.png" id="fig-ross-notebook" style="width:70.0%" />

## 6. Создание производных форматов

-   Генерация чистого кода, Notebook и Quarto-документов

<img src="image/16_1.png" id="fig-tangle1" style="width:70.0%" />

<img src="image/17_1.png" id="fig-tangle2" style="width:70.0%" />

## 7. Настройка отчёта

-   В `_quarto.yml` добавлена поддержка Julia

<img src="image/21.png" id="fig-quarto-config" style="width:70.0%" />

## 8. Подключение документации

-   В отчёт подключены сгенерированные `.qmd` файлы

<img src="image/20.png" id="fig-include" style="width:70.0%" />

``` julia
```{julia}
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

\`\`\`

# Результаты

## Реализованные модели

-   Реализованы обе модели на Julia с использованием `ConcurrentSim`
-   Код оформлен в литературном стиле
-   Сгенерированы чистые скрипты, Notebook и Quarto-документы

## Параметрические исследования

-   **M/M/c:** исследовано влияние числа каналов на длину очереди и
    время ожидания
-   **Модель Росса:** исследовано влияние числа ремонтников и резервных
    машин на среднее время до падения системы

## Построенные графики

-   Динамика числа заявок в системе
-   Загрузка ремонтника
-   Изменение числа исправных машин во времени

## Итоговый отчёт

-   Отчёт скомпилирован в PDF
-   Все результаты интегрированы в единый документ

# Итоговый слайд

## Основной вывод

-   Дискретно-событийное моделирование — эффективный инструмент анализа
    СМО
-   Библиотека `ConcurrentSim` в Julia позволяет гибко реализовывать
    модели любой сложности
-   Литературное программирование обеспечивает воспроизводимость и
    прозрачность исследований

# Рекомендую

## Принцип 10/20/30

-   10 слайдов
-   20 минут на доклад
-   30 кегль шрифта

## Связь слайдов

-   Один слайд — одна мысль
-   Нельзя ссылаться на объекты с предыдущих слайдов
-   Каждый слайд должен иметь заголовок

## Количество сущностей

-   Человек может одновременно помнить 7 ± 2 элемента
-   На слайде — не более 5 элементов
-   Можно группировать элементы до 5 групп

## Общие рекомендации

-   Слайды дополняют выступление, а не дублируют его
-   Информация изложена кратко и структурированно
-   Слайд не перегружен графикой и текстом
-   Минимум анимации и переходов

## Представление данных

-   Лучше — в виде схемы
-   Менее оптимально — рисунок, график, таблица
-   Текст — только если другие способы не подошли

# Список литературы

-   Имитационное моделирование. Практикум.
    https://esystem.rudn.ru/pluginfile.php/3094278/modeling-lab.pdf
