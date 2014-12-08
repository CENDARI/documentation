# CENDARI Documentation


This repository contains the technical documentation of the CENDARI project.

The documentation is written as [reStructuredText](http://docutils.sourceforge.net/rst.html)
and processed using [Sphinx](http://sphinx-doc.org/).


## Inclusion of Component Documentation


Technical Documentation for CENDARI components is extracted directly from the code repository of the relevant component.
These repositories are included as git submodules, tracking their respective `master` branches.
Make sure to use `git 1.8.2+` and always sync them with
```
git submodule update --remote
```

The included Documentation will only be parsed if the environment variabel `CENDARI_INCLUDE_SUBMODULE_DOCS` is set.
Within the main Documentation documents this can be checked with
```
.. ifconfig:: include_submodule_docs
```


### Source Code Documentation

As far as possible, in-line source code documentation is extracted and included.

Due to its nature, Sphinx can extract Python Docstring documentation natively.
For other languages, converters and extensions have to be installed.

For converting PHPDoc to reStructuredText, [Dox PHP](https://github.com/avalanche123/doxphp) is used.

The script `submodules-import.sh` converts converts PHPDoc to reStructuredText for inclusion.
