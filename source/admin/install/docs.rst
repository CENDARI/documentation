Documentation
=============

The official CENDARI is created using `Sphinx <http://sphinx-doc.org>`_.
It is build from the code repository on `GitHub <https://github.com/CENDARI/documentation>`_.

Prerequisites
-------------

Make sure you have `doxphp <https://github.com/avalanche123/doxphp.git>`_ installed. 

To build the CENDARI theme you need bower and grunt:

.. code-block:: bash

    npm install -g bower
    npm install -g grunt-cli

To build the PDF version, you need LaTeX installed, i.e.

.. code-block:: puppet

    package {
      'texlive-latex-recommended': ensure => installed;
      'texlive-latex-extra':       ensure => installed;
      'texlive-fonts-recommended': ensure => installed;
      'texlive-fonts-extra':       ensure => installed;
    }


Preparing the build environemnt
-------------------------------

To compile the documentation with parts included directly from submodules, make sure to have the lastest revision

.. code-block:: bash

    git submodule update --init --recursive --remote

You may want to define the version and iteration:


.. code-block:: bash

    VERSION=$(grep ^version source/conf.py | sed 's/version = '\''\([0-9.]*\)'\''/\1/g')
    ITERATION=0
    export CENDARI_RELEASE="${VERSION}-${ITERATION}"
    

Enable the inclusion of the submodules

.. code-block:: bash

    export CENDARI_INCLUDE_SUBMODULE_DOCS="YES"


Install the requirements into a dedicated Python Vitualenv:

.. code-block:: bash

    virtualenv venv
    source venv/bin/activate
    pip install -r requirements.txt
    pip install -r dependency-requirements.txt

Compile the CENDARI theme in ``source/sphinx_rtd_theme`` by running

.. code-block:: bash

    npm install 

    grunt exec:bower_update
    grunt sass:dev
    grunt clean:build
    grunt exec:build_sphinx


In the Repositories main directory run

.. code-block:: bash

    /bin/bash submodules-import.sh

to prepare the imported sources.

Compiling the Documentation
---------------------------

Finally build the documentation in HTML and PDF format.

.. code-block:: bash

    make html
    make latexpdf
    cp build/latex/CENDARI.pdf build/html/

Make sure to serve the content of the ``build/html`` directory.

