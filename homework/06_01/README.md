1.  
- Подходит документо-ориентированная база данных.  
- Не очень понятно, что будет храниться конкретно. Я бы выбрал графовую или реляционную базу данных.  
- Думаю иерархическая база данных, так как этот тип баз данных имеет древовидную структуру.  
- Key-Value база данных, поддерживает TTL, будет хранить id и ключ авторизации.  
- Тут нужна реляционная база данных что бы сохранять отношения между объектами.  
2.   
- CAP - AP  
PACELC - PA/EL  
- CAP - AP  
PACELC - PA/EC  
- CAP - CP  
PACELC - PC/EL  
3.   
- В одной системе могут сочитаться отдельные принципы BASE и ACID, но не в полном объеме, так как ACID направлен на надежность системы, а BASE ориентируется на доступность.  
4.  
- Речь идет про Redis.  
Из минусов:   
Размер базы данных ограничен ОЗУ.  
Большая вероятность потери данных, так как они хранятся в ОЗУ.  
Не гарантирует доставку сообщений клиентам.  
Нет сегментации на пользователей и группы.  

