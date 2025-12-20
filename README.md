# Домашнее задание к занятию "Репликация и масштабирование. Часть 1" - Муравский Артем



---

### Задание 1

На лекции рассматривались режимы репликации master-slave, master-master, опишите их различия.

Ответить в свободной форме.


*В режиме master-slave клиенты могу осуществлять операции записи только на master-сервере, slave-сервер(-ы) получают изменения от master-сервера и обслуживают только запросы на чтение. В режиме master-master все серверы равнозначны и клиенты могут осуществлять все виды операций на любом из них.*


---

### Задание 2

Выполните конфигурацию master-slave репликации, примером можно пользоваться из лекции.

Приложите скриншоты конфигурации, выполнения работы: состояния и режимы работы серверов.

--

Master-сервер: конфигурация

![master config](img/screen4.png)


Master-сервер: вывод команд `SHOW MASTER STATUS\G` и `SELECT * FROM test_table;`

![master](img/screen1.png)

---

Slave-сервер: конфигурация

![slave config](img/screen5.png)


Slave-сервер: вывод команды `SHOW SLAVE STATUS\G`

![slave1](img/screen2.png)


Slave-сервер: продолжение вывода команды `SHOW SLAVE STATUS\G` и вывод `SELECT * FROM test_table;`

![slave2](img/screen3.png)

---

### Задание 3

Выполните конфигурацию master-master репликации. Произведите проверку.

Приложите скриншоты конфигурации, выполнения работы: состояния и режимы работы серверов.

---

Master-1-сервер: конфигурация

![master-1 config](img/screen6png)

Master-1-сервер: вывод команд `SHOW MASTER STATUS\G` и создание в таблице test_db записи "Master-1 Record"

![master-1-1](img/screen8.png)

Master-1-сервер: просмотр таблицы test_db на наличии записи "Master-2 Record"

![master-1-2](img/screen9.png)

---

Master-2-сервер: конфигурация

![master-2 config](img/screen7.png)

Master-2-сервер: вывод команд `SHOW MASTER STATUS\G` и просмотр таблицы test_db на наличии записи "Master-1 Record"

![master-2-1](img/screen10.png)

Master-2-сервер: создание в таблице test_db записи "Master-2 Record"

![master-2-2](img/screen11.png)
