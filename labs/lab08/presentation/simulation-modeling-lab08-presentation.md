# Моделирование SIR эпидемии
Тарасова Алина Андреевна
2026-05-24

# Информация

## Докладчик

-   Тарасова Алина Андреевна
-   Студентка
-   Российский университет дружбы народов им. П. Лумумбы
-   <1132236013@rudn.ru>

# Вводная часть

## Актуальность

-   Моделирование распространения инфекций критически важно для
    прогнозирования эпидемий
-   Дискретно-событийный подход позволяет учитывать стохастическую
    природу процессов
-   Возможность оценки эффективности мер контроля (вакцинация, карантин)

## Объект и предмет исследования

-   **Объект:** Процесс распространения инфекции в популяции
-   **Предмет:** Дискретно-событийная SIR модель и её расширения

## Цели и задачи

**Цель:** Изучить дискретно-событийный подход к имитационному
моделированию на примере SIR модели.

**Задачи:** - Реализовать стохастическую DES модель на Julia - Провести
анализ чувствительности к параметрам - Сравнить стохастическую и
детерминированную версии - Оценить производительность модели -
Реализовать расширения: демография, вакцинация, SEIR

## Материалы и методы

-   **Язык программирования:** Julia
-   **Библиотеки:** ConcurrentSim, ResumableFunctions, Distributions,
    DataFrames, StatsPlots, BenchmarkTools, CSV
-   **Инструменты:** Quarto для генерации отчётов и презентаций

# Теоретическое введение

## Дискретно-событийное моделирование (DES)

-   Состояние системы изменяется **только в моменты событий**
-   Виртуальное время «перескакивает» от события к событию
-   Высокая эффективность по сравнению с непрерывным моделированием
-   Основные компоненты:
    -   Календарь событий
    -   Процессы (возобновляемые функции)

## SIR модель

Популяция разделена на три группы:

<table>
<thead>
<tr>
<th>Статус</th>
<th>Описание</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>S</strong> (Susceptible)</td>
<td>Восприимчивые к инфекции</td>
</tr>
<tr>
<td><strong>I</strong> (Infected)</td>
<td>Инфицированные, способные заражать</td>
</tr>
<tr>
<td><strong>R</strong> (Recovered)</td>
<td>Выздоровевшие с иммунитетом</td>
</tr>
</tbody>
</table>

## Стохастическая DES реализация

-   Каждый индивид — **агент** с собственным жизненным циклом
-   Время до контакта: `rand(Exponential(1/c))`
-   Время до выздоровления: `rand(Exponential(1/γ))`
-   Заражение: с вероятностью `β` при контакте `S` с `I`

## Расширения модели

<table>
<thead>
<tr>
<th>Расширение</th>
<th>Описание</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>SEIR</strong></td>
<td>Добавление латентного периода (Exposed)</td>
</tr>
<tr>
<td><strong>Демография</strong></td>
<td>Рождаемость (ν) и смертность (μ)</td>
</tr>
<tr>
<td><strong>Вакцинация</strong></td>
<td>Перевод S → R в заданный момент</td>
</tr>
</tbody>
</table>

## Используемые библиотеки Julia

<table>
<thead>
<tr>
<th>Библиотека</th>
<th>Назначение</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>ConcurrentSim</code></td>
<td>Дискретно-событийное ядро</td>
</tr>
<tr>
<td><code>ResumableFunctions</code></td>
<td>Возобновляемые функции</td>
</tr>
<tr>
<td><code>Distributions</code></td>
<td>Генерация случайных величин</td>
</tr>
<tr>
<td><code>DataFrames</code>, <code>CSV</code></td>
<td>Работа с данными</td>
</tr>
<tr>
<td><code>StatsPlots</code></td>
<td>Визуализация</td>
</tr>
<tr>
<td><code>BenchmarkTools</code></td>
<td>Оценка производительности</td>
</tr>
</tbody>
</table>

# Выполнение лабораторной работы

## Настройка окружения

<figure>
<img src="image/2_2.png" alt="Запуск Julia и установка пакетов" />
<figcaption aria-hidden="true">Запуск Julia и установка
пакетов</figcaption>
</figure>

<figure>
<img src="image/3_3.png" alt="Установка пакетов" />
<figcaption aria-hidden="true">Установка пакетов</figcaption>
</figure>

## Запуск базовой модели

<figure>
<img src="image/8.png" alt="Запуск скрипта sir_model.jl" />
<figcaption aria-hidden="true">Запуск скрипта sir_model.jl</figcaption>
</figure>

<figure>
<img src="image/9.png" alt="Jupyter notebook от sir_model.jl" />
<figcaption aria-hidden="true">Jupyter notebook от
sir_model.jl</figcaption>
</figure>

## Запуск скриптов (1-4)

<table>
<thead>
<tr>
<th>Скрипт</th>
<th>Назначение</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>task_8_5_1.jl</code></td>
<td>Анализ чувствительности к параметрам</td>
</tr>
<tr>
<td><code>task_8_5_2.jl</code></td>
<td>Детерминированная длительность болезни</td>
</tr>
<tr>
<td><code>task_8_5_3.jl</code></td>
<td>Оценка производительности</td>
</tr>
<tr>
<td><code>task_8_5_4.jl</code></td>
<td>Сохранение результатов в CSV</td>
</tr>
</tbody>
</table>

## Результаты task_8_5_1.jl

<figure>
<img src="image/10.png" alt="Запуск task_8_5_1.jl" />
<figcaption aria-hidden="true">Запуск task_8_5_1.jl</figcaption>
</figure>

<figure>
<img src="image/11.png" alt="Jupyter notebook" />
<figcaption aria-hidden="true">Jupyter notebook</figcaption>
</figure>

## Результаты task_8_5_2.jl

<figure>
<img src="image/14.png" alt="Запуск task_8_5_2.jl" />
<figcaption aria-hidden="true">Запуск task_8_5_2.jl</figcaption>
</figure>

<figure>
<img src="image/15.png" alt="Jupyter notebook" />
<figcaption aria-hidden="true">Jupyter notebook</figcaption>
</figure>

## Результаты task_8_5_3.jl

<figure>
<img src="image/16.png" alt="Запуск task_8_5_3.jl" />
<figcaption aria-hidden="true">Запуск task_8_5_3.jl</figcaption>
</figure>

<figure>
<img src="image/17.png" alt="Jupyter notebook" />
<figcaption aria-hidden="true">Jupyter notebook</figcaption>
</figure>

## Результаты task_8_5_4.jl

<figure>
<img src="image/18.png" alt="Запуск task_8_5_4.jl" />
<figcaption aria-hidden="true">Запуск task_8_5_4.jl</figcaption>
</figure>

<figure>
<img src="image/19.png" alt="Jupyter notebook" />
<figcaption aria-hidden="true">Jupyter notebook</figcaption>
</figure>

## Запуск скриптов (5-7)

<table>
<thead>
<tr>
<th>Скрипт</th>
<th>Назначение</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>task_8_5_5.jl</code></td>
<td>Демографические события (смерть + рождение)</td>
</tr>
<tr>
<td><code>task_8_5_6.jl</code></td>
<td>Вакцинация</td>
</tr>
<tr>
<td><code>task_8_5_7.jl</code></td>
<td>Модель SEIR</td>
</tr>
</tbody>
</table>

## Результаты task_8_5_5.jl

<figure>
<img src="image/20.png" alt="Запуск task_8_5_5.jl" />
<figcaption aria-hidden="true">Запуск task_8_5_5.jl</figcaption>
</figure>

<figure>
<img src="image/21.png" alt="Jupyter notebook" />
<figcaption aria-hidden="true">Jupyter notebook</figcaption>
</figure>

## Результаты task_8_5_6.jl

<figure>
<img src="image/22.png" alt="Запуск task_8_5_6.jl" />
<figcaption aria-hidden="true">Запуск task_8_5_6.jl</figcaption>
</figure>

<figure>
<img src="image/2.png" alt="График вакцинации" />
<figcaption aria-hidden="true">График вакцинации</figcaption>
</figure>

<figure>
<img src="image/23.png" alt="Jupyter notebook" />
<figcaption aria-hidden="true">Jupyter notebook</figcaption>
</figure>

## Результаты task_8_5_7.jl

<figure>
<img src="image/24.png" alt="Запуск task_8_5_7.jl" />
<figcaption aria-hidden="true">Запуск task_8_5_7.jl</figcaption>
</figure>

<figure>
<img src="image/25.png" alt="Jupyter notebook" />
<figcaption aria-hidden="true">Jupyter notebook</figcaption>
</figure>

## Создание производных форматов

<figure>
<img src="image/26.png" alt="Создание форматов" />
<figcaption aria-hidden="true">Создание форматов</figcaption>
</figure>

<figure>
<img src="image/27.png" alt="Создание форматов" />
<figcaption aria-hidden="true">Создание форматов</figcaption>
</figure>

<figure>
<img src="image/28.png" alt="Создание форматов" />
<figcaption aria-hidden="true">Создание форматов</figcaption>
</figure>

## Создание производных форматов (продолжение)

<figure>
<img src="image/29.png" alt="Создание форматов" />
<figcaption aria-hidden="true">Создание форматов</figcaption>
</figure>

<figure>
<img src="image/30.png" alt="Создание форматов" />
<figcaption aria-hidden="true">Создание форматов</figcaption>
</figure>

<figure>
<img src="image/31.png" alt="Создание форматов" />
<figcaption aria-hidden="true">Создание форматов</figcaption>
</figure>

## Создание производных форматов (окончание)

<figure>
<img src="image/32.png" alt="Создание форматов" />
<figcaption aria-hidden="true">Создание форматов</figcaption>
</figure>

<figure>
<img src="image/33.png" alt="Создание форматов" />
<figcaption aria-hidden="true">Создание форматов</figcaption>
</figure>

<figure>
<img src="image/34.png" alt="Создание форматов" />
<figcaption aria-hidden="true">Создание форматов</figcaption>
</figure>

## Настройка Quarto

<figure>
<img src="image/35.png" alt="Настройка _quarto.yml" />
<figcaption aria-hidden="true">Настройка _quarto.yml</figcaption>
</figure>

<figure>
<img src="image/36.png" alt="Подключение файлов" />
<figcaption aria-hidden="true">Подключение файлов</figcaption>
</figure>

# Результаты

## Анализ чувствительности

<table>
<thead>
<tr>
<th>β</th>
<th>c</th>
<th>γ</th>
<th>Пик I</th>
<th>Время пика</th>
<th>Итоговый R</th>
</tr>
</thead>
<tbody>
<tr>
<td>0.03</td>
<td>5.0</td>
<td>0.20</td>
<td>45</td>
<td>28.5</td>
<td>320</td>
</tr>
<tr>
<td>0.05</td>
<td>10.0</td>
<td>0.25</td>
<td>342</td>
<td>15.2</td>
<td>890</td>
</tr>
<tr>
<td>0.07</td>
<td>15.0</td>
<td>0.30</td>
<td>421</td>
<td>11.8</td>
<td>945</td>
</tr>
</tbody>
</table>

**Вывод:** Увеличение β или c увеличивает пик эпидемии; увеличение γ
снижает пик.

## Сравнение SIR vs SEIR

<table>
<thead>
<tr>
<th>Модель</th>
<th>Пик I</th>
<th>Время пика</th>
</tr>
</thead>
<tbody>
<tr>
<td>SIR</td>
<td>342</td>
<td>15.2</td>
</tr>
<tr>
<td>SEIR</td>
<td>298</td>
<td>19.8</td>
</tr>
</tbody>
</table>

**Вывод:** Латентный период сглаживает пик и сдвигает его во времени.

## Эффективность вакцинации

<table>
<thead>
<tr>
<th>Доля вакцинации (%)</th>
<th>Пик I</th>
<th>Эпидемия</th>
</tr>
</thead>
<tbody>
<tr>
<td>0</td>
<td>342</td>
<td>Да</td>
</tr>
<tr>
<td>20</td>
<td>210</td>
<td>Да</td>
</tr>
<tr>
<td>40</td>
<td>89</td>
<td>Да</td>
</tr>
<tr>
<td>60</td>
<td>12</td>
<td><strong>Нет</strong></td>
</tr>
<tr>
<td>80</td>
<td>0</td>
<td>Нет</td>
</tr>
</tbody>
</table>

**Критическая доля:** 60%

## Оценка производительности

<table>
<thead>
<tr>
<th>N</th>
<th>Время (мс)</th>
<th>Память (МБ)</th>
</tr>
</thead>
<tbody>
<tr>
<td>100</td>
<td>45</td>
<td>2.1</td>
</tr>
<tr>
<td>500</td>
<td>210</td>
<td>8.4</td>
</tr>
<tr>
<td>1000</td>
<td>520</td>
<td>15.2</td>
</tr>
<tr>
<td>5000</td>
<td>3150</td>
<td>68.5</td>
</tr>
</tbody>
</table>

**Вывод:** Линейный рост времени выполнения с размером популяции.

## Итоговые выводы

-   **Изучен** дискретно-событийный подход к имитационному моделированию
-   **Реализована** стохастическая SIR модель на Julia
-   **Проведён** анализ чувствительности модели к параметрам
-   **Выполнено** сравнение стохастической и детерминированной версий
-   **Реализованы** расширения: демография, вакцинация, SEIR

# Заключение

## Итоговый слайд

> **Дискретно-событийный подход позволяет гибко моделировать сложные
> эпидемиологические процессы и исследовать влияние различных факторов
> на динамику распространения инфекции.**

# Список литературы

## Источники

-   Имитационное моделирование. Практикум
-   <https://esystem.rudn.ru/pluginfile.php/3094278/modeling-lab.pdf>

------------------------------------------------------------------------
