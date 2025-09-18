# Домашнее задание к занятию "`Подъем инфраструктуры в облаке`" - `Муравский Артем`


### Инструкция по выполнению домашнего задания

   1. Сделайте `fork` данного репозитория к себе в Github и переименуйте его по названию или номеру занятия, например, https://github.com/имя-вашего-репозитория/git-hw или  https://github.com/имя-вашего-репозитория/7-1-ansible-hw).
   2. Выполните клонирование данного репозитория к себе на ПК с помощью команды `git clone`.
   3. Выполните домашнее задание и заполните у себя локально этот файл README.md:
      - впишите вверху название занятия и вашу фамилию и имя
      - в каждом задании добавьте решение в требуемом виде (текст/код/скриншоты/ссылка)
      - для корректного добавления скриншотов воспользуйтесь [инструкцией "Как вставить скриншот в шаблон с решением](https://github.com/netology-code/sys-pattern-homework/blob/main/screen-instruction.md)
      - при оформлении используйте возможности языка разметки md (коротко об этом можно посмотреть в [инструкции  по MarkDown](https://github.com/netology-code/sys-pattern-homework/blob/main/md-instruction.md))
   4. После завершения работы над домашним заданием сделайте коммит (`git commit -m "comment"`) и отправьте его на Github (`git push origin`);
   5. Для проверки домашнего задания преподавателем в личном кабинете прикрепите и отправьте ссылку на решение в виде md-файла в вашем Github.
   6. Любые вопросы по выполнению заданий спрашивайте в чате учебной группы и/или в разделе “Вопросы по заданию” в личном кабинете.
   
Желаем успехов в выполнении домашнего задания!
   
### Дополнительные материалы, которые могут быть полезны для выполнения задания

1. [Руководство по оформлению Markdown файлов](https://gist.github.com/Jekins/2bf2d0638163f1294637#Code)

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

```test_nginx.yaml
---
- name: test nginx install
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

```test_http.yaml
---
- name: Check HTTP page via jump host
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
![Запуск плейбука test_nginx.yaml](./img/screen3.png)`

![Запуск плейбука test_http.yaml](./img/screen2.png)


### Задание 3

`Приведите ответ в свободной форме........`

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

### Задание 4

`Приведите ответ в свободной форме........`

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
