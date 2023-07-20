# Домашнее задание к занятию «Компоненты Kubernetes»

### Цель задания

Рассчитать требования к кластеру под проект

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания:

- [Considerations for large clusters](https://kubernetes.io/docs/setup/best-practices/cluster-large/),
- [Architecting Kubernetes clusters — choosing a worker node size](https://learnk8s.io/kubernetes-node-size).

------

### Задание. Необходимо определить требуемые ресурсы
Известно, что проекту нужны база данных, система кеширования, а само приложение состоит из бекенда и фронтенда. Опишите, какие ресурсы нужны, если известно:

1. Необходимо упаковать приложение в чарт для деплоя в разные окружения. 
2. База данных должна быть отказоустойчивой. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии. 
3. Кеш должен быть отказоустойчивый. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии. 
4. Фронтенд обрабатывает внешние запросы быстро, отдавая статику. Потребляет не более 50 МБ ОЗУ на каждый экземпляр, 0.2 ядра. 5 копий. 
5. Бекенд потребляет 600 МБ ОЗУ и по 1 ядру на копию. 10 копий.

----

### Ответ.
Упакуем приложение в Helm чарт. Чарт будет состоять из:  
```
Chart.yam         # Фаил с информацией о чарте.  
values.yaml       # Фаил со стандартными параметрами для чарта.  
templates/        # Папка с шаблонам.  
README.md         # Краткое описание чарта и его параметров.  
```

Рассчитаем количество ресурсов исходя из потребления RAM и ядер CPU для каждого компонента приложения умноженного на количество реплик:  

БД:  
* RAM: `4GB * 3 = 12GB`
* CPU: `1 ядро * 3 = 3 ядра`  

Кэш: 
* RAM: `4GB * 3 = 12GB`
* CPU: `1 ядро * 3 = 3 ядра`  

Фронтенд: 
* RAM: `50MB * 5 = 250MB` 
* CPU: `0.2 ядра * 5 = 1 ядро`  

Бекенд: 
* RAM: `600MB * 10 = 6GB` 
* CPU: `1 ядро * 10 = 10 ядер`

Итого: `RAM 30.25GB; CPU 17 ядер`

Также важно учитывать следующие факторы при выборе размера и количества нод для кластера:

* Размер ноды должен быть достаточным для всех компонентов приложения с запасом ресурсов.
* Количество узлов должно обеспечивать отказоустойчивость и равномерную нагрузку в кластере.

Я в данном случае выберу ноды среднего размера, по 4 ядра CPU и 8 GB RAM. Получится 4 ноды необходимо минимально, но так как нам нужно обеспечить отказоустойчивость и балансировку, оптимальным будет `кластер из 5 нод по 4 ядра CPU и 8 GB RAM`.

---

### Правила приёма работы

1. Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Сначала сделайте расчёт всех необходимых ресурсов.
3. Затем прикиньте количество рабочих нод, которые справятся с такой нагрузкой.
4. Добавьте к полученным цифрам запас, который учитывает выход из строя как минимум одной ноды. 
5. Добавьте служебные ресурсы к нодам. Помните, что для разных типов нод требовния к ресурсам разные. 
6. В результате должно быть указано количество нод и их параметры.
