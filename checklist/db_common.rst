通用数据库
=====================================

.. toctree::
   :maxdepth: 1

   mysql
   oracle
   mssql
   pg
   redis
   db2

免费工具们
------------

- `DBeaver Community <https://dbeaver.io/download?start&os=win&arch=x86_64>`_：基于JDBC的客户端，可连接市面上绝大多数关系型数据库

- `MySQL Workbench <https://dev.mysql.com/downloads/workbench/>`_：MySQL官方GUI管理工具

- `Oracle Instant Clients <https://www.oracle.com/database/technologies/instant-client/winx64-64-downloads.html>`_：Oracle客户端工具，包含SQL*Plus

- `SQL Server Management Studio (SSMS) <https://aka.ms/ssmsfullsetup>`_：MSSQL官方GUI管理工具

实验环境搭建
-----------------

.. code-block:: yaml
   :linenos:

   # 如果 Docker Compose 版本太老，需修改yaml的版本
   version: "3.6"
   services:
      mysql8-test:
         image: mysql:8
         container_name: mysql8-test
         ports:
            - 33068:3306
         environment:
            MYSQL_ROOT_PASSWORD: test-PW-123456

      mysql57-test:
         image: mysql:5.7
         container_name: mysql57-test
         ports:
            - 33067:3306
         environment:
            MYSQL_ROOT_PASSWORD: test-PW-123456  

      oracle11-test:
         # 初始化要2-3分钟，请耐心等待
         # 初始化时，为SYS生成随机密码，需通过docker logs查看
         # 实例名xe
         image: datagrip/oracle:11.2.0.2-xe
         container_name: oracle11-test
         ports:
            - 15211:1521
         # 必须要1gb的共享内存才能成功启动
         shm_size: 1gb

      mssql19-test:
         # 容器大概要占用1gb的内存
         image: mcr.microsoft.com/mssql/server:2019-latest
         container_name: mssql19-test
         ports:
            - 14339:1433
         environment:
            ACCEPT_EULA: Y
            SA_PASSWORD: test-PW-123456  
            MSSQL_PID: Express

      redis6-test:
         image: redis:6
         container_name: redis6-test
         ports:
            - 6376:6379

      redis5-test:
         image: redis:5
         container_name: redis5-test
         ports:
            - 6375:6379

      db2_11-test:
         image: ibmcom/db2
         container_name: db2_11-test
         ports:
            - 50000:50000
         environment:
            LICENSE: accept 
            DB2INST1_PASSWORD: test-PW-123456  
            DBNAME: testDB
         privileged: true

      pg-test:
         image: postgres
         container_name: postgres
         ports:
            - 5432:5432
         environment:
            POSTGRES_PASSWORD: test-PW-123456