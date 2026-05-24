# Changelog

Все значимые изменения в этом проекте будут документироваться в этом файле.

Формат основан на [Keep a Changelog](https://keepachangelog.com/ru/1.0.0/),
и этот проект придерживается [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [8.0.0] - 2026-05-24

### Добавлено
- Базовая дискретно-событийная SIR модель (`src/sir_model.jl`)
- Скрипт запуска базовой модели (`scripts/sir_des.jl`)

### Дополнительные задания (п. 8.5)
- Анализ чувствительности к параметрам (`scripts/task_8_5_1.jl`)
- Детерминированная длительность болезни (`scripts/task_8_5_2.jl`)
- Оценка производительности с @benchmark (`scripts/task_8_5_3.jl`)
- Сохранение результатов в CSV (`scripts/task_8_5_4.jl`)
- Демографические события (смерть + рождение) (`scripts/task_8_5_5.jl`)
- Вакцинация (`scripts/task_8_5_6.jl`)
- Модель SEIR (`scripts/task_8_5_7.jl`)

### Изменено
- Исправлена ошибка вложенных @async @resumable для демографической модели
- Добавлена функция seir_run для SEIR модели

### Визуализация
- Графики сохраняются в `plots/`:
  - `sir_des.png` - базовая SIR модель
  - `sensitivity_γ=0.25.png` - анализ чувствительности
  - `comparison_stoch_det.png` - сравнение стох/дет версий
  - `performance.png` - производительность
  - `sir_demography.png` - модель с демографией
  - `vaccination_efficiency.png` - эффективность вакцинации
  - `SIR_vs_SEIR_I.png` - сравнение SIR vs SEIR

### Документация
- Отчёт в формате Quarto (`report.qmd`)
- Презентация в формате Quarto (`presentation.qmd`)

### Зависимости
- ResumableFunctions.jl
- ConcurrentSim.jl
- Distributions.jl
- DataFrames.jl
- StatsPlots.jl
- BenchmarkTools.jl
- CSV.jl
