# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
# import os
# import sys
# sys.path.insert(0, os.path.abspath('.'))


# -- Project information -----------------------------------------------------

project = '学习笔记'
copyright = '2020, 腿哥牛逼'
author = '腿哥牛逼'
html_title = '学习笔记'

# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    'recommonmark',
    'sphinx_markdown_tables',
    'sphinx.ext.githubpages',
    'sphinx_copybutton'
]

# Add any paths that contain templates here, relative to this directory.
templates_path = ['../_templates']

# The language for content autogenerated by Sphinx. Refer to documentation
# for a list of supported languages.
#
# This is also used if you do content translation via gettext catalogs.
# Usually you set "language" from the command line for these cases.
language = 'zh_CN'

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = []


# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = 'sphinx_material'

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['../_static']

html_copy_source = False
html_show_sourcelink = False

html_logo = '../_static/logo.png'
html_favicon = '../_static/favicon.png'
html_use_index = True
html_domain_indices = False

html_theme_options = {
    'repo_url': 'https://github.com/ale10bb/blog/',
    'repo_name': 'Personal Blog',
    "repo_type": "github",
    "html_minify": False,
    "html_prettify": True,
    "css_minify": True,
    'globaltoc_depth': 2,
    "master_doc": False,
    "nav_links": [
        {"href": "../index", "internal": True, "title": "项目简介"},
        {"href": "index", "internal": True, "title": "CheckList"}
    ],
    "heroes": {
        "index": "照这些核查 肯定不及格"
    }
}

html_sidebars = {
    "**": ["globaltoc.html", "localtoc.html", "searchbox.html"]
}