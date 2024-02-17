# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# http://www.sphinx-doc.org/en/master/config

# -- Path setup --------------------------------------------------------------
import os
this_dir = os.path.dirname(os.path.abspath(__file__))
matlab_src_dir = os.path.abspath(os.path.join(this_dir, '../../..'))
matlab_src_encoding = 'latin-1'
primary_domain = 'mat'

# -- Project information -----------------------------------------------------
project = 'MIR_AUVSimulator'
copyright = '2021, ECA ROBOTICS. (DHAISNE Aurelien, dhaisne.a@ecagroup.com)'
authorautho = 'DHAISNE Aurelien <dhaisne.a@ecagroup.com>'

# The full version, including alpha/beta/rc tags
release = '1.0.0'

# -- General configuration ---------------------------------------------------
# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = ['sphinx.ext.autodoc', 'sphinxcontrib.matlab', 'sphinx.ext.napoleon', 'sphinx.ext.viewcode', 'sphinx.ext.todo']
highlight_language = 'matlab'
napoleon_google_docstring = False
napoleon_use_param = False
napoleon_use_ivar = True
add_module_names = False
show_authors = True

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = []


# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = 'sphinx_rtd_theme'
html_domain_indices = True

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = []
