Docker部署
================

本项目提供了Docker部署方式，你可以通过以下方式获取本项目的容器：

- via `Docker-Compose <https://gitee.com/ale10bb/blog/raw/master/docker/docker-compose.yml>`_

.. code-block:: yaml
   :linenos:

   # 如果 Docker Compose 版本太老，需降低yaml的版本
   version: "3.6"
   services:
      blog:
         image: registry.cn-shanghai.aliyuncs.com/ale10bb/blog
         container_name: blog
         ports:
            # 可任意修改映射端口
            - 16680:80

- via Docker-cli

.. code-block:: bash

   docker run -d --name blog -p 16680:80 registry.cn-shanghai.aliyuncs.com/ale10bb/blog

常用命令
~~~~~~~~~~~~~~~~

.. code-block:: bash

   # 创建
   docker-compose up -d
   # docker-compose -f /path/to/docker-compose.yml up -d

   # 销毁
   docker-compose down

   # 运行
   docker-compose start

   # 停止
   docker-compose stop

   # 更新
   docker-compose pull && docker-compose up -d

   # 删除旧版
   docker image prune -f

构建信息
~~~~~~~~~~~~~~~~

Dockerfile
----------------

.. code-block:: docker

   FROM nginx:stable
   ADD ./docker/nginx.conf /etc/nginx/nginx.conf
   # COPY 挖矿木马&病毒 /guess/where/they/are
   ADD ./html /var/www/html

nginx.conf
----------------

.. code-block:: nginx
   :linenos:

   user  nginx;
   worker_processes  1;

   error_log   off;
   pid        /var/run/nginx.pid;

   events {
      worker_connections  1024;
   }

   http {
      include        /etc/nginx/mime.types;
      default_type   text/html;
      charset        utf-8;
      sendfile       on;

      log_format  main  '$remote_addr $remote_user [$time_local] ($status) $host: '
                        '"$request" "$http_user_agent" "$http_referer"';
      access_log  /var/log/nginx/access.log  main;

      server {
         listen 80 default_server;
         server_name _;
         root /var/www/html;

         error_page 404 /404.html;
         error_page 400 403 500 502 503 504 /error.html;
      }
   }