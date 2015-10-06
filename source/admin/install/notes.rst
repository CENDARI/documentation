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
      'iipimage-server':     ensure => installed;
      'imagemagick':         ensure => installed;

    }


After cloning, run

.. code-block:: bash

    fab setup
    fab sync_database

Install the package ``supervisor`` and make sure the file ``/etc/supervisor/conf.d/notes.conf`` contains

.. code-block:: bash

    directory=/var/www/notes
    command=/var/www/notes/bin/python manage.py rqworker
    stopasgroup=true
    stopsignal=QUIT
    stderr_logfile=/var/log/notes.err.log
    stdout_logfile=/var/log/notes.out.log


To ``/etc/odbc.ini`` add

.. code-block:: ini

    [VOS]
    Description = Virtuoso
    Driver = /usr/lib/odbc/virtodbcu_r.so
    Server = host.name
    address = host.name:1111
    Port = 1111
    UserName = dba
    Locale = en.UTF-8

The file ``/etc/apache2/mods-available/iipsrv.conf`` must contain

.. code-block:: bash
   
    ScriptAlias /iipsrv/ "/usr/lib/iipimage-server/"

    <Directory "/iipsrv/">
      AllowOverride None
      Options None
      Order allow,deny
      Allow from all
      AddHandler fcgid-script .fcgi
    </Directory>

    # Set our environment variables for the IIP server
    FcgidInitialEnv VERBOSITY "1"
    FcgidInitialEnv LOGFILE "/var/log/iipsrv.log"
    FcgidInitialEnv MAX_IMAGE_CACHE_SIZE "10"
    FcgidInitialEnv JPEG_QUALITY "90"
    FcgidInitialEnv MAX_CVT "5000"
    FcgidInitialEnv FILESYSTEM_PREFIX '/var/www/notes/uploads/'

    FcgidIdleTimeout 0
    FcgidMaxProcessesPerClass 1

Enable the corresponding Apache module with ``a2enmod iipsrv``.
