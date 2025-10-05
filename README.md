# Домашнее задание к занятию "Система мониторинга Zabbix" - Муравский Артем

---

### Задание 1

Установите Zabbix Server с веб-интерфейсом.

Процесс выполнения

1. Выполняя ДЗ, сверяйтесь с процессом отражённым в записи лекции.
2. Установите PostgreSQL. Для установки достаточна та версия, что есть в системном репозитороии Debian 11.
3. Пользуясь конфигуратором команд с официального сайта, составьте набор команд для установки последней версии Zabbix с поддержкой PostgreSQL и Apache.
4. Выполните все необходимые команды для установки Zabbix Server и Zabbix Web Server.

Требования к результатам

1. Прикрепите в файл README.md скриншот авторизации в админке.
2. Приложите в файл README.md текст использованных команд в GitHub.
 
---

```bash
# Установка сервера PostgreSQL
apt update
apt install postgresql

# Установка репозитория Zabbix
wget https://repo.zabbix.com/zabbix/7.2/release/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.2+ubuntu24.04_all.deb
dpkg -i zabbix-release_latest_7.2+ubuntu24.04_all.deb
apt update

# Установка Zabbix сервера, веб-интерфейса и агента
apt install zabbix-server-pgsql zabbix-frontend-php php8.3-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-agent

# Создание базы данных
# Установка и запуск сервера базы данных.
sudo -u postgres createuser --pwprompt zabbix
sudo -u postgres createdb -O zabbix zabbix
# Импорт начальных схемы и базы данных на хост Zabbix сервера.
zcat /usr/share/zabbix/sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix

# Настройка базы данных для Zabbix сервера
# Установка пароля для базы данных /etc/zabbix/zabbix_server.conf
DBPassword=password

# Запуск процессов Zabbix сервера и агента
# Запуск процессов Zabbix сервера и агента, и настройка их запуска при загрузке ОС
systemctl restart zabbix-server zabbix-agent apache2
systemctl enable zabbix-server zabbix-agent apache2
```

![админка zabbix](/img/screen1.png)


---

### Задание 2

Установите Zabbix Agent на два хоста.

Процесс выполнения

1. Выполняя ДЗ, сверяйтесь с процессом отражённым в записи лекции.
2. Установите Zabbix Agent на 2 вирт.машины, одной из них может быть ваш Zabbix Server.
3. Добавьте Zabbix Server в список разрешенных серверов ваших Zabbix Agentов.
4. Добавьте Zabbix Agentов в раздел Configuration > Hosts вашего Zabbix Servera.
5. Проверьте, что в разделе Latest Data начали появляться данные с добавленных агентов.

Требования к результатам

1. Приложите в файл README.md скриншот раздела Configuration > Hosts, где видно, что агенты подключены к серверу
2. Приложите в файл README.md скриншот лога zabbix agent, где видно, что он работает с сервером
3. Приложите в файл README.md скриншот раздела Monitoring > Latest data для обоих хостов, где видны поступающие от агентов данные.
4. Приложите в файл README.md текст использованных команд в GitHub

--

Первый агент установлен на первую виртуальную машину одновременно с Zabbix-сервером

```bash
# Установка репозитория Zabbix
wget https://repo.zabbix.com/zabbix/7.2/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.2+debian11_all.deb
dpkg -i zabbix-release_latest_7.2+debian11_all.deb
apt update

# Установка Zabbix агента
apt install zabbix-agent

# Запуск процесса Zabbix агента
# Запуск процесса Zabbix агента и настройка его запуска при загрузке ОС
systemctl restart zabbix-agent
systemctl enable zabbix-agent
```

![Configuration > Hosts](/img/screen2.png)

![zabbix agent logs](/img/screen4.png)

![latest data](/img/screen3.png)
