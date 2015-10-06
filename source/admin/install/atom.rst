AtoM
====

* Follow the instructions to `install AtoM <https://www.accesstomemory.org/en/docs/2.1/admin-manual/installation/linux/>`_ from CENDARI's `AtoM fork <https://github.com/CENDARI/atom>`_ on GitHub.
* The fork includes the the following addtional components as git submodules:

  * :doc:`Shibboleth authentication plugin </developer/atom/shibboleth>`
  * the :doc:`AtoM2CKAN sync </developer/atom/ckansync>` scripts


Prerequisites
-------------

AtoM is a PHP application served through Apache

.. code-clock:: puppet

    package {'php5-cli': ensure => installed }

It relies on **ElasticSearch** and **MySQL**.


Install
-------

Clone the repository's CENDARI-branch with its submodules

.. code-block:: bash

    git clone --branch stable/2.2.x-cendari https://github.com/CENDARI/atom.git
    git submodule update --init --recursive --remote

than run

.. code-block:: bash

    OLDDIR=$(pwd)
    for dir in arDominionPlugin sfCendariThemePlugin; do
      cd plugins/$dir
      make
      cd $OLDDIR
    done

    chmod -R og+rX .

    chown -R www-data data
    chown -R www-data log
    chown -R www-data cache
    chown -R www-data atom2ckan

After an upgrade, make sure to upgrade the database and clear the cache

.. code-block:: bash

    sudo -u www-data php symfony tools:upgrade-sql
    sudo -u www-data php symfony cc

If necessary, recreate the Elastic index

.. code-block:: bash

    sudo -u www-data php symfony search:populate
    
    
Configuration
-------------

Verify Language and Timezone in ``apps/qubit/config/settings.yml`` 
and add the database settings to ``config/config.php`` and the ElasticSearch settings to ``config/search.yml``.

Add the Shibboleth mapping to ``apps/qubit/config/app.yml``:

.. code-block:: bash

    all:
      shibboleth_administrator_groups: 'cendari-archives-admins;cendari-admins'
      shibboleth_editor_groups: 'cendari-archives-editors'
      shibboleth_contributor_groups: 'cendari-archives-contributors;cendari-contributors'
      shibboleth_translator_groups: 'cendari-archives-translators'



CKAN upload
-----------

To regularily upload all config files to CKAN, install `atom2ckan <https://github.com/CENDARI/atom2ckan>`_ by cloning from GitHub 
and filling in the settings to ``complete_atom_to_ckan_config.php``.

.. todo:: Database modifications

The following command should be executed by the ``www-data`` user periodically, i.e. via cron

.. code-block:: bash

    cd /var/www/atom2/atom2ckan && php complete_atom_to_ckan.php


