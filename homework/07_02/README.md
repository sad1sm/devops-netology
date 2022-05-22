## Задача 1 (вариант с AWS). Регистрация в aws и знакомство с основами.

В виде результата задания приложите вывод команды `aws configure list`.

```
f1tz@notebook:~$ aws configure list
      Name                    Value             Type    Location
      ----                    -----             ----    --------
   profile                <not set>             None    None
access_key     ****************bM54              env    
secret_key     ****************d/Mf              env    
    region                us-east-1      config-file    ~/.aws/config
```

## Задача 2. Создание aws ec2 или yandex_compute_instance через терраформ. 

В качестве результата задания предоставьте:
1. Ответ на вопрос: при помощи какого инструмента (из разобранных на прошлом занятии) можно создать свой образ ami?
1. Ссылку на репозиторий с исходной конфигурацией терраформа.  
 
- Свой образ ami можно создать с помощью aws cli, packer.
- https://github.com/sad1sm/devops-netology/tree/main/terraform
