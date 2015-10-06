CKAN
====

Start by following the instructions to set up `CKAN <http://docs.ckan.org/en/latest/maintaining/installing/install-from-source.html>`_, version 2.2.1.


To install CKAN, the following requirements should be met:


.. code-block:: puppet

    package{ 
      'libredis-perl':             ensure => present;
      'postgresql-contrib-9.3':    ensure => present;
      'postgresql-postgis':        ensure => present;
      'postgresql-server':         ensure => present;
      'postgresql-server-dev-9.3': ensure => present;
      'python-pastescript':        ensure => present;
      'redis-server':              ensure => present;
      'solr-tomcat':               ensure => present;
      'tomcat6':                   ensure => present;
    }

You need two databases for CKAN and the DataStore.

Make sure the config files
``/etc/solr/conf/schema.xml``, ``/etc/ckan/apache.wsgi``, ``/etc/ckan/production.ini``, ``/etc/ckan/who.ini``
have the right contents.

.. code-block:: bash

    mkdir -p /var/www/ckan
    cd /var/www/ckan
    rm -rf *
    virtualenv --no-site-packages /var/www/ckan
    source /var/www/ckan/bin/activate
    pip install -e "git+https://github.com/ckan/ckan.git@ckan-2.2.2#egg=ckan"
    pip install -r /var/www/ckan/src/ckan/requirements.txt
    deactivate
    source /var/www/ckan/bin/activate
    cd /var/www/ckan/src/ckan
    ../../bin/python setup.py install

    # BUILD EXTENSIONS

    git clone https://github.com/CENDARI/ckanext-dariahshibboleth.git /var/www/ckan/src/ckanext-dariahshibboleth
    cd /var/www/ckan/src/ckanext-dariahshibboleth
    ../../bin/python setup.py install
    git clone https://github.com/CENDARI/ckanext-cendari.git /var/www/ckan/src/ckanext-cendari
    cd /var/www/ckan/src/ckanext-cendari
    ../../bin/python setup.py install
    git clone https://github.com/okfn/ckanext-archiver.git /var/www/ckan/src/ckanext-archiver
    pip install -r /var/www/ckan/src/ckanext-archiver/pip-requirements.txt
    cd /var/www/ckan/src/ckanext-archiver
    ../../bin/python setup.py install
    git clone https://github.com/okfn/ckanext-datastorer.git /var/www/ckan/src/ckanext-datastorer
    pip install -r /var/www/ckan/src/ckanext-datastorer/pip-requirements.txt
    cd /var/www/ckan/src/ckanext-datastorer
    ../../bin/python setup.py install
    git clone https://github.com/okfn/ckanext-harvest.git /var/www/ckan/src/ckanext-harvest
    pip install -r /var/www/ckan/src/ckanext-harvest/pip-requirements.txt
    cd /var/www/ckan/src/ckanext-harvest
    ../../bin/python setup.py install
    cd /var/www/ckan/src
    pip install -e git://github.com/kata-csc/ckanext-kata.git@1.2#egg=ckanext-kata
    git clone https://github.com/kata-csc/ckanext-oaipmh.git /var/www/ckan/src/ckanext-oaipmh
    cd /var/www/ckan/src/ckanext-oaipmh
    ../../bin/python setup.py install


The following plugins are required:

* `DARIAH Shibboleth authentication plugin for CKAN <https://github.com/CENDARI/ckanext-dariahshibboleth>`_, see also :doc:`/developer/ckan/shibboleth`
* `CKAN Archiver Extension <https://github.com/okfn/ckanext-archiver>`_
* `CKAN Datastorer Extension <https://github.com/okfn/ckanext-datastorer>`_
* `Remote harvesting extension for CKAN <https://github.com/okfn/ckanext-harvest>`_
* `Kata extension for CKAN <https://github.com/kata-csc/ckanext-kata>`_, version 1.2
* `OAI PMH extension to CKAN <https://github.com/kata-csc/ckanext-oaipmh>`_


