# devops-netology
Благодаря .gitignore в папке terraform будут проигнорированы следующие файлы и папки:
Любые скрытые локальные директории с поддиректориями .terraform/
Файлы с любым именем *.tfstate, *.tfstate.*
Все лог файлы с именем crash.log
Все файлы содержащие чувствительные переменные и данные (пароли, приватные ключи и т.п.) *.tfvars
Все перезаписывающие конфигурацию файлы, так как используются в основном для локальных изменений override.tf override.tf.json *_override.tf *_override.tf.json
Все конфигурационные файлы коммандной строки .terraformrc terraform.rc
