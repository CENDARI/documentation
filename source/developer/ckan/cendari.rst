CKAN plugin "cendari"
==============================

This plugin is used to enable Shibboleth Authentication including the interfacing with the CENDARI Data API for CKAN.
The code is available on `GitHub <https://github.com/CENDARI/ckanext-cendari>`_.

About the plugin
----------------

The plugin hooks into the authentication dialog.
The dialog is extended to include a link to Shibboleth authentication.

If a user vists the login page while being authenticated with Shibboleth,
his Shibboleth attributes are sent to the Data API's :doc:`/developer/litef-conductor/docs/session/post-session` endpoint.
Thus user creationg is deferred to the CENDARI Data API and the plugin than simply logs in the user returned by the Data API.
In the event that the API does not respond, the plugin checks wheter a CKAN user corresponding to the Shibboleth attributes exists and logs him in directly.

The plugin further supports the promoting of users to sysadmin status, should this be indicated by the Shibboleth attributes.
To use the feature, add a line to CKAN's configuration in the ``[app:main]`` section, defining groups to be checked against the user's `isMemberOf` attribute::

  shibboleth_sysadmin_groups = shib-admins shib-ckan-admins

To facilitate the Single-Sign-On experience, 
the login page is usually protected on the webserver level and thus never seen by a user.
The CKAN internal user management is diabled so that changes can not be made.


.. toctree::
   :hidden:
   :maxdepth: 1


.. ifconfig:: include_submodule_docs

   ------------------
   Code Documentation
   ------------------

   .. automodule:: cendari.plugin
      :members:
      :undoc-members:
      :show-inheritance:

