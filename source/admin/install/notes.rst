Notes VRE
=========

Follow the instructions provided with the `editorsnotes repository <https://github.com/CENDARI/editorsnotes>`_ on GitHub.

The following packages are required to compile the Notes VRE on Ubuntu 14.04

.. code-block:: puppet

    package {
      'libcurl4-gnutls-dev': ensure => installed;
      'libjpeg-dev':         ensure => installed;
      'libopenjpeg-dev':     ensure => installed;
      'libpq-dev':           ensure => installed;
      'libtiff5-dev':        ensure => installed;
      'libvips-tools':       ensure => installed;
      'libxml2-dev':         ensure => installed;
      'libxslt1-dev':        ensure => installed;
      'python-dev':          ensure => installed;
      'python-vipscc':       ensure => installed;
      'ruby-dev':            ensure => installed;
      'unixodbc-dev':        ensure => installed;
      'zlib1g-dev':          ensure => installed;
    }




