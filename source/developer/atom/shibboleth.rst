AtoM plugin: sfDariahShibUserPlugin
===================================

This plugin is used to enable Shibboleth Authentication in AtoM.
The code is available on `GitHub <https://github.com/CENDARI/documentation>`_.

About the plugin
----------------

The plugin hooks into the authentication dialog, which is only shown on the dedicated login page
``/user/login`` and, assuming the webserver requires Shibboleth authentication for this page,
upon visiting the url the Shibboleth data is used to authenticate the user to AtoM.

User rights are mapped based on the configuration file ``apps/qubit/config/app.yml``.
All CENDARI project members are given contributer status, 
while archivists and historians are granted editor status.

To facilitate the Single-Sign-On experience, 
a number of upstream templates is overwritten:

* The menu template  ``_userMenu`` is changed to remove the drop-down login menu.

* The user templates ``editSuccess`` and ``indexSuccess`` are replaced by simplified versions that remove the password handling from the user interface.

* The user template ``loginSuccess``
  is replaced to remove login dialogs on pages other than the dedicated login page,
  which could appear on session timeout. 
  In this case the user is redirected to the login page.



.. toctree::
   :hidden:
   :maxdepth: 1


.. ifconfig:: include_submodule_docs

   ------------------
   Code Documentation
   ------------------

   Plugin Configuration
   ^^^^^^^^^^^^^^^^^^^^

   .. include:: sfDariahShibUserPluginConfiguration.import


   Extending the login page
   ^^^^^^^^^^^^^^^^^^^^^^^^

   .. include:: loginAction.import


   Performing login and account creation
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   .. include:: sfDariahShibUser.import


