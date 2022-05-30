# Домашнее задание к занятию "7.4. Средства командной работы над инфраструктурой."

## Задача 1. Настроить terraform cloud (необязательно, но крайне желательно).

В качестве результата задания приложите снимок экрана с успешным применением конфигурации.

## Ответ:

Из-за блокировок адекватно воспользоваться сервисом не получилось.

## Задача 2. Написать серверный конфиг для атлантиса.

В качестве результата приложите ссылку на файлы `server.yaml` и `atlantis.yaml`.

## Ответ:

Конфигурация для контейнеров Atlantis и Ngrok

```YAML
version: '3.8'

services:
  ngrok:
    image: wernight/ngrok:latest
    ports:
    - 4040:4040
    environment:
      NGROK_PROTOCOL: http
      NGROK_PORT: atlantis:4141
    depends_on:
    - atlantis

  atlantis:
    container_name: atlantis
    image: runatlantis/atlantis:latest
    ports:
      - 4141:4141
    volumes:
      - ~/.ssh:/.ssh:ro
      - ./:/atlantis:ro
    command: 
      - atlantis server \
        --atlantis-url="" \
        --gh-user="$USERNAME" \
        --gh-token="$TOKEN" \
        --gh-webhook-secret="$SECRET" \
        --repo-allowlist="github.com/sad1sm/devops-netology"
```

Это server.yml

```YAML
repos:
- id: github.com/sad1sm/devops-netology

  workflow: devops-netology
  apply_requirements: [approved, mergeable]
  allowed_overrides: [workflow]
  allow_custom_workflows: true

workflows:
  devops-netology:
    plan: 
      steps:
        - init:
            extra_args: ["-lock=false"]
        - plan:
            extra_args: ["-lock=false"]
    apply:
      steps: [apply]
```

Это atlantis.yml

```YAML
version: 3
projects:
- dir: terraform
  workspace: stage
  autoplan:
    when_modified: ["../modules/**/*.tf", "*.tf*"]
- dir: terraform
  workspace: prod
  autoplan:
    when_modified: ["../modules/**/*.tf", "*.tf*"]
```

## Задача 3. Знакомство с каталогом модулей.

В качестве результата задания приложите ссылку на созданный блок конфигураций.

## Ответ:

Модуль есть: https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest, но попробовать сделать что-то к сожалению нельзя из-за блокировок.
