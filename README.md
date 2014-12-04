CENDARI Documentation
=====================


This repository contains the technical documentation of the CENDARI project.

The documentation is written as [reStructuredText](http://docutils.sourceforge.net/rst.html)
and processed using [Sphinx](http://sphinx-doc.org/).


Inclusion of Source Code Documentation
--------------------------------------

Source Code Documentation is extracted directly from code developed by the CENDARI project.
The relevant code repositories are included as git submodules.

Due to its nature, Sphinx can extract Python Docstring documentation natively.
For other languages, converters and extensions have to be installed.

For converting PHPDoc to reStructuredText, [Dox PHP](https://github.com/avalanche123/doxphp) is used.

The Documentation will only be parsed if the environment variabel `CENDARI_INCLUDE_SUBMODULE_DOCS` is set.
Within the Documentation this can be checked with
```
.. ifconfig:: include_submodule_docs
```
The script `submodules-import.sh` converts converts PHPDoc to reStructuredText for inclusion.
