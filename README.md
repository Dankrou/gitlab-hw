# Домашнее задание к занятию "`GitLab`" - `<Березкин Даниил>`

### Задание 1

`Скриншот с настройками раннера в проекте`

![Активный раннер в проекте](img/zd1.png)`

![Активный раннер в проекте2](img/zd1_2.png)`

---

### Задание 2

`Код из файла gitlab-ci.yml`

```
stages:
  - test
  - build

test:
  stage: test
  image: golang:1.17
  script:
    - go test .

build:
  stage: build
  image: golang:1.17
  script:
    - go build .
```

`Скриншот с успешной собранной сборкой`

![Факт успешной собранной сборки](img/zd2.png)`


---
