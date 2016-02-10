CKAN Modifications and Extension
================================

CKAN serves as central repository for all CENDARI content.
It directly functions as the backend for the :doc:`/developer/litef-conductor/docs/rest`.
Some :ref:`modifications <ckan-db-changes-lbl>` to the database have been made.

.. todo:: Actually provide the specifications of the DB changes. 


Shibboleth Authentication
-------------------------

.. toctree::
   :hidden:
   :maxdepth: 1

   ckan/shibboleth
   ckan/cendari

The CKAN web interface is integrated into the CENDARI authentication mechanism through
the CKAN plugin :doc:`ckan/cendari`.
A pure Shibboleth plugin was also developed by CENDARI, but is no longer in use: :doc:`ckan/shibboleth`.

