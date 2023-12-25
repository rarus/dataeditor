[![GitHub License](https://img.shields.io/github/license/rarus/dataeditor)](https://github.com/rarus/dataeditor/tree/main?tab=CC-BY-SA-4.0-1-ov-file#CC-BY-SA-4.0-1-ov-file)
[![Download Badge](https://img.shields.io/badge/download-DataEditor.epf-blue)](https://github.com/rarus/dataeditor/releases/latest/download/DataEditor.epf)
[![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/rarus/dataeditor/total)](https://github.com/rarus/dataeditor/releases)
[![GitHub watchers](https://img.shields.io/github/watchers/rarus/dataeditor)](https://github.com/rarus/dataeditor)


# Редактор данных (проект "Инструменты 1С-Рарус")

Инструмент предназначен для просмотра и редактирования данных в базе 1С:Предприятие, минуя интерфейс самой конфигурации.

Будет полезен для анализа и изменения реквизитов, не вынесенных на форму.

Может принести пользу как администраторам, эксплуатирующим информационные базы, так и разработчикам конфигураций для анализа поведения программы.

Инструмент разработан компанией [1C-Рарус](https://rarus.ru/) в рамках проекта "Инструменты 1С-Рарус".

Актуальная версия инструмента доступна в разделе [Релизы](https://github.com/rarus/dataeditor/releases/latest).


## Ключевые функциональные возможности

- Просмотр и изменение данных в базе (справочники, документы, регистры... всё, что хранится в базе данных)

<details>
<summary markdown="span">См. пример...</summary>

![](/docs/images/1.gif)

</details>

- Работа с реквизитами и табличными частями (даже с теми, которые разработчик не вынес на форму)

<details>
<summary markdown="span">См. пример...</summary>

![](/docs/images/2.1.gif)

![](/docs/images/2.2.gif)

</details>

- Работа с движениями регистров (подчиненные регистры открываются из документа-регистратора)

<details>
<summary markdown="span">См. пример...</summary>

![](/docs/images/3.gif)

</details>

- Просмотр и редактирование данных в реквизитах и константах с типом "Хранилище значения" (список поддерживаемых типов ограничен, функционал развивается)

<details>
<summary markdown="span">См. пример...</summary>

![](/docs/images/4.gif)

</details>

- Управление регистрацией объекта на всех возможных узлах всех доступных планов обмена

<details>
<summary markdown="span">См. пример...</summary>

![](/docs/images/5.gif)

</details>

- Генератор текста запроса для 1С, XML для консоли запросов (см. справку к обработке "Консоль запросов"), MS SQL и PostgreSQL

<details>
<summary markdown="span">См. пример...</summary>

![](/docs/images/6.gif)

</details>

- Окно выполнения произвольного кода (разработка функционала еще ведется)

<details>
<summary markdown="span">См. пример...</summary>

![](/docs/images/7.gif)

</details>

- Обработка может быть открыта как непосредственно, так и подключена через стандартный механизм доп. отчетов и обработок


## Системные требования

Предполагается работа на всех видах клиента 1С:Предприятие и любых операционных системах.

Для разработки и тестирования использовались:
- Платформа 1С:Предприятие: 8.3.22.2239
- 1C:Enterprise Development Tools: 2023.1.2


## Лицензия

Эта программа и сопроводительные материалы предоставляются в соответствии с условиями лицензии Attribution-ShareAlike 4.0 International (CC BY-SA 4.0). Текст лицензии доступен по ссылке: https://creativecommons.org/licenses/by-sa/4.0/legalcode


## Участие в проекте

[Читай правила участия](CONTRIBUTING.md)
