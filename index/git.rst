获取源码
================

分支访问
~~~~~~~~~~~~~~~~

本项目有两个分支， ``master`` 分支存放ReST文件源代码， ``gh-pages`` 分支存放编译后的页面。你可以clone项目之后，切换分支直接查看页面。

.. code-block:: bash

    git clone https://github.com/ale10bb/blog.git
    git checkout gh-pages

源码编译
~~~~~~~~~~~~~~~~

你也可以自行安装 `requirements <https://github.com/ale10bb/blog/raw/master/requirements.txt>`_ 后编译。注意本项目包含 ``index`` 和 ``checklist`` 两个子站，分别有不同的 ``conf.py`` 。应当保证编译之后的 ``checklist`` 子站位于 ``index`` 子站的 ``checklist`` 文件夹下。

如果你看不懂上面这段话，也不知道如何修改 ``conf.py`` ，请保证编译时的目录结构为：

.. code-block:: 

    │ make.bat
    │
    └─blog
        │  .gitignore
        │  LICENSE
        │  README.md
        │  requirements.txt
        │
        ├─checklist
        │  │  conf.py
        │  │  *.rst
        │  │
        │  └─media
        │      └─*
        │
        ├─index
        │  │  conf.py
        │  │  *.rst
        │  │
        │  └─media
        │      └─*
        │
        └─_static

编译后会在 ``make.bat`` 同层目录中生成 ``index`` 和 ``checklist`` 两个临时目录，编译结果存放在 ``html`` 目录中。

.. code-block:: 

    │ make.bat
    │
    ├─index
    │  └─doctrees
    │      *.doctree
    │
    ├─checklist
    │  └─doctrees
    │      *.doctree
    │
    html
    │  │  .buildinfo
    │  │  .nojekyll
    │  │  *.html
    │  │  objects.inv
    │  │
    │  ├─checklist
    │  │  │  .buildinfo
    │  │  │  .nojekyll
    │  │  │  *.html
    │  │  │
    │  │  ├─_images
    │  │  │  *
    │  │  │
    │  │  └─_static
    │  │     *
    │  │
    │  ├─_images
    │  │    *
    │  │
    │  └─_static
    │      *
    │
    └─blog
        │  .gitignore
        │  LICENSE
        │  README.md
        │  requirements.txt
        │
        ├─checklist
        │  │  conf.py
        │  │  *.rst
        │  │
        │  └─media
        │      └─*
        │
        ├─index
        │  │  conf.py
        │  │  *.rst
        │  │
        │  └─media
        │      └─*
        │
        └─_static

Makefile
----------------

在 ``make.bat`` 中加入以下内容，之后：

- 执行 ``make`` 可以编译站点。
- 执行 ``make clean`` 可以删除临时目录和结果目录。

.. code-block:: bat

    @ECHO OFF

    pushd %~dp0

    if "%1" == "" goto make
    if "%1" == "clean" goto clean

    :clean
    rmdir /S/Q index
    rmdir /S/Q checklist
    rmdir /S/Q html
    goto end

    :make
    sphinx-build -M html blog/index index 
    sphinx-build -M html blog/checklist checklist 
    Robocopy.exe index\html html /MOVE /e
    Robocopy.exe checklist\html html\checklist /MOVE /e

    :end
    popd
