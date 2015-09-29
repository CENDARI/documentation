AtoM Extensions
===================

AtoM (Access to Memory) is used within the CENDARI project for management of Archival descriptions.

.. todo:: Add description of EAD and EAG

The standard installation of AtoM is used in conjunction with a `CENDARI theme <https://github.com/CENDARI/sfCendariThemePlugin>`_.
In addition CENDARI developed a Shibboleth authentication extension and a script to upload AtoM 
archival descriptions in EAD and EAG to the CENDARI repository.

Shibboleth Authentication
-------------------------

.. toctree::
   :hidden:
   :maxdepth: 1

   atom/shibboleth

AtoM is integrated into the DARIAH :doc:`Shibboleth authentication </admin/authentication>`, 
using the plugin :doc:`sfDariahShibUserPlugin <atom/shibboleth>` developed by CENDARI.


Connection to the CKAN Repository
---------------------------------

.. toctree::
   :hidden:
   :maxdepth: 1

   atom/ckansync

A collection of scripts :doc:`atom/ckansync` have been developed by CENDARI.



