# Домашнее задание к занятию "7.6. Написание собственных провайдеров для Terraform." 

## Задача 1. 

1. Найдите, где перечислены все доступные `resource` и `data_source`, приложите ссылку на эти строки в коде на 
гитхабе.   
  
Все доступные `resource` и `data_source` перечислены в [terraform-provider-aws/internal/provider/provider.go](https://github.com/hashicorp/terraform-provider-aws/blob/main/internal/provider/provider.go#L420-L2047)

2. Для создания очереди сообщений SQS используется ресурс `aws_sqs_queue` у которого есть параметр `name`.  
    * С каким другим параметром конфликтует `name`? Приложите строчку кода, в которой это указано.  
[ConflictsWith: []string{"name_prefix"}](https://github.com/hashicorp/terraform-provider-aws/blob/b4b8683111c3fbb82eaa88893e0a25e8aa675430/internal/service/sqs/queue.go#L87)
    * Какая максимальная длина имени?   
Максимальная длинна `name` = 80 символов.
    * Какому регулярному выражению должно подчиняться имя?   
Если это очередь fifo, то `re = regexp.MustCompile('^[a-zA-Z0-9_-]{1,75}\.fifo$')`, если любая другая то `re = regexp.MustCompile('^[a-zA-Z0-9_-]{1,80}$')`, информация [тут](https://github.com/hashicorp/terraform-provider-aws/blob/b4b8683111c3fbb82eaa88893e0a25e8aa675430/internal/service/sqs/queue.go#L424-L428)
    
