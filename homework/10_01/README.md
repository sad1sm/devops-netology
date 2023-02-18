# Домашнее задание к занятию "10.01. Зачем и что нужно мониторить"

1. Вас пригласили настроить мониторинг на проект. На онбординге вам рассказали, что проект представляет из себя 
платформу для вычислений с выдачей текстовых отчетов, которые сохраняются на диск. Взаимодействие с платформой 
осуществляется по протоколу http. Также вам отметили, что вычисления загружают ЦПУ. Какой минимальный набор метрик вы
выведите в мониторинг и почему?

---

* Загрузка по ЦПУ - так как можно на будущее поймать момент, погда система перестанет справляться с задачей и можно будет подумать или на счет увеличения параметра или можно будет попробовать разработчиков провести оптимизацию.

* Дисковое пространство - текстовые отчеты сохраняются на диск, значит всегда есть шанс что место закончится.

* Состояние и скорость диска - если диск начнет медленно работать и появится деградация - можно потерять все данные или увеличится время работы сервиса.

* ОЗУ - Наверняка генерация текста занимает какое-то место в памяти, можно предотвратить OOM (Out Of Memory) в будущем.

* Мониторинг WEB-сервера - у WEB-сервера тоже есть настройки и параметры, которые могут повлиять на доступность сервиса через http.

* Сеть - задержки, потери, недоступность будет критической для сервиса, нужно за этим следить.

---

2. Менеджер продукта посмотрев на ваши метрики сказал, что ему непонятно что такое RAM/inodes/CPUla. Также он сказал, 
что хочет понимать, насколько мы выполняем свои обязанности перед клиентами и какое качество обслуживания. Что вы 
можете ему предложить?

---
* Я могу ему предложить учить матчасть.
* Я могу предложить ему почитать вместе со мной ТЗ и объяснить по моим метрикам что и где, соответственно мы поймем что по качеству обслуживания. Изменять свои метрики под понимание менеджера нет никакого смысла, ему с этим не работать.
---

3. Вашей DevOps команде в этом году не выделили финансирование на построение системы сбора логов. Разработчики в свою 
очередь хотят видеть все ошибки, которые выдают их приложения. Какое решение вы можете предпринять в этой ситуации, 
чтобы разработчики получали ошибки приложения?

---
* Непонятна постановка задачи. На что конкретно нет средств, на VM или на ПО.
Если на ПО, то есть множество бесплатных вариантов. Graylog, Sentry к примеру.
Если на ресурсы, то если нет никакой общей системы мне предложить нечего, пусть рисуют себе парсинг-скрипты или что-то вроде того с отправкой ошибок на почту.

---

4. Вы, как опытный SRE, сделали мониторинг, куда вывели отображения выполнения SLA=99% по http кодам ответов. 
Вычисляете этот параметр по следующей формуле: summ_2xx_requests/summ_all_requests. Данный параметр не поднимается выше 
70%, но при этом в вашей системе нет кодов ответа 5xx и 4xx. Где у вас ошибка?

---
* Не учтены запросы 3xx. 

---