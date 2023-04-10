# Ansible


Web-server ansible_host=172.31.91.26
target2 ansible_host=172.31.94.231
DB ansible_host=172.31.6.214

[webserver]
Web-server
target2

[db]
DB

[dc:children]
webserver
db

#Ping 

ansible -i inventory -m ping '*'

ansible -i inventory -m ping Web-server


---------------------------

#YUM Module

ansible -i inventory -m yum -a "name=httpd state=present" Web-server --become   

ansible -i inventory -m yum -a "name=httpd state=absent" --become webserver 

#Service 

ansible -i inventory  -m service -a "name=httpd state=started enabled=yes" Web-server --become

#copy

ansible -i inventory -m copy -a "src=index.html dest=/var/www/html/index.html" Web-server --become

--------------------------

#playbook


---
- name: Setup Webserver
  hosts: Webserver
  become: yes
  tasks:
    - name: Install Apache httpd
      yum:
        name: httpd
        state: present
    - name: Start httpd
      service:
        name: httpd
        state: started
        enabled: yes
    - name: copy index
      copy:
        src: Index.html
        dest: /var/www/html/index.html

- name: Setup DBserver
  hosts: DB
  become: yes
  tasks:
    - name: Install MySQL
      yum:
        name: mariadb-server
        state: present
    - name: Start and enable DB
      service:
        name: mariadb
        state: started
        enabled: yes



## ansible-playbook -i inventory playbook.yaml --syntax-check 
## ansible-playbook -i inventory playbook.yaml 