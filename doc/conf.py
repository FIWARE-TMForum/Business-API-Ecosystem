# -*- coding: utf-8 -*-

import os

on_rtd = os.environ.get('READTHEDOCS', None) == 'True'

extensions = []
templates_path = ['/home/docs/checkouts/readthedocs.org/readthedocs/templates/sphinx', 'templates', '_templates', '.templates']
source_suffix = ['.rst']
master_doc = 'index'
project = u'biz-ecosystem'
copyright = u'2016'
version = 'latest'
release = 'latest'
exclude_patterns = ['_build']
pygments_style = 'sphinx'
htmlhelp_basename = 'biz-ecosystem'
html_theme = 'sphinx_rtd_theme'
file_insertion_enabled = False
latex_documents = [
  ('index', 'biz-ecosystem.tex', u'Business API Ecosystem Documentation',
   u'', 'manual'),
]

html_context = { 
    'css_files': [
        'https://media.readthedocs.org/css/sphinx_rtd_theme.css',
        'https://media.readthedocs.org/css/readthedocs-doc-embed.css',
        'https://www.fiware.org/style/fiware_readthedocs.css',
        'https://www.fiware.org/style/fiware_readthedocs_publication.css',
    ],  
}
