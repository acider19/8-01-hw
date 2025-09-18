# Домашнее задание к занятию "`Подъем инфраструктуры в облаке`" - `Муравский Артем`

---

### Задание 1

Повторить демонстрацию лекции(развернуть vpc, 2 веб сервера, бастион сервер)

[Репозиторий](https://github.com/acider19/for-netology-hw-7-03)


---

### Задание 2

С помощью ansible подключиться к web-a и web-b , установить на них nginx.(написать нужный ansible playbook)

Провести тестирование и приложить скриншоты развернутых в облаке ВМ, успешно отработавшего ansible playbook.

1. Составлен playbook для установки nginx на web-a и web-b.

```
---
- name: nginx
  gather_facts: false
  hosts: webservers
  vars:
    ansible_ssh_user: user
  become: yes

  tasks:
  - name: "Install nginx via apt"
    ansible.builtin.apt:
      name: "nginx"
      state: "latest"
      update_cache: true
  - name: "Start a nginx with systemd"
    systemd:
      name: "nginx"
      state: started
  - name: "Enable nginx service"
    systemd:
      name: "nginx.service"
      enabled:
```
![Запуск плейбука nginx.yaml](./img/screen1.png)`


2. Подготовлены playbook'и для проверки работоспособности nginx на web-a и web-b

Проверка установки nginx
```
---
- name: test_nginx.yaml
  gather_facts: false
  hosts: webservers
  vars:
    ansible_ssh_user: user
  become: yes
  tasks:
    - name: Выполнить команду nginx -v
      ansible.builtin.command: nginx -v
      register: nginx_version
      ignore_errors: yes

    - name: Вывести результат
      ansible.builtin.debug:
        msg: "{{ nginx_version.stderr }}"
```

![Запуск плейбука test_nginx.yaml](./img/screen3.png)


Проверка доступности веб-серверов
```
---
- name: test_http.yaml
  hosts: bastion
  vars:
    ansible_ssh_user: user
  gather_facts: false
  tasks:
    - name: Check HTTP page on web-a
      ansible.builtin.uri:
        url: "http://10.0.1.17"
        method: GET
      register: web_a_result
    - name: Print result
      ansible.builtin.debug:
        msg: "HTTP status for web-a {{ web_a_result.status }}"
    - name: Check HTTP page on web-b
      ansible.builtin.uri:
        url: "http://10.0.2.26"
        method: GET
      register: web_b_result
    - name: Print result
      ansible.builtin.debug:
        msg: "HTTP status for web-b {{ web_b_result.status }}"
```
![Запуск плейбука test_http.yaml](./img/screen4.png)

---

3. Скриншот развернутых в Яндекс Облаке виртуальных машин

![Скриншот](./img/screen2.png)

### Задание 3

Выполните действия, приложите скриншот скриптов, скриншот выполненного проекта.

1. Добавить еще одну виртуальную машину.
2. Установить на нее любую базу данных.
3. Выполнить проверку состояния запущенных служб через Ansible.


1. Создана дополнительная виртуальная машина - db.

![Скриншот](./img/screen6.png)

2. Подготовлен playbook для установки базы данных mysql на созданную виртуальную машину и проверки успешности этой установки.

```
---
- name: mysql.yaml
  gather_facts: false
  hosts: db
  vars:
    ansible_ssh_user: user
  become: yes

  tasks:
  - name: Install mysql via apt
    ansible.builtin.apt:
      name: "mysql-server"
      state: "latest"
      update_cache: true
  - name: Выполнить команду mysql --version
    ansible.builtin.command: mysql --version
    register: mysql_version
    ignore_errors: yes

  - name: Вывести результат
    ansible.builtin.debug:
      msg: "{{ mysql_version.stdout }}"
```

![Запуск плейбука mysql.yaml](./img/screen5.png)

3. Создан playbook для проверки состояния сервиса mysql.

```
- name: test_mysql.yaml
  vars:
    ansible_ssh_user: user
  hosts: db
  gather_facts: false
  tasks:
    - name: Check service status
      ansible.builtin.command: systemctl is-active mysql
      register: service_status
      changed_when: false
      ignore_errors: yes

    - name: Show result
      ansible.builtin.debug:
        msg: "Mysql is {{ service_status.stdout }} on {{ inventory_hostname }}"
```

![Запуск плейбука test_mysql.yaml](./img/screen7.png)

---

### Задание 4

Изучите инструкцию yandex для terraform. Добейтесь работы паплайна с безопасной передачей токена от облака в terraform через переменные окружения. Для этого:

1. Настройте профиль для yc tools по инструкции.
2. Удалите из кода строчку "token = var.yandex_cloud_token". Terraform будет считывать значение ENV переменной YC_TOKEN.
3. Выполните команду export YC_TOKEN=$(yc iam create-token) и в том же shell запустите terraform.
4. Для того чтобы вам не нужно было каждый раз выполнять export - добавьте данную команду в самый конец файла ~/.bashrc

1. `Заполните здесь этапы выполнения, если требуется ....`
2. `Заполните здесь этапы выполнения, если требуется ....`
3. `Заполните здесь этапы выполнения, если требуется ....`
4. `Заполните здесь этапы выполнения, если требуется ....`
5. `Заполните здесь этапы выполнения, если требуется ....`
6. 

```
Поле для вставки кода...
....
....
....
....
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота](ссылка на скриншот)`
