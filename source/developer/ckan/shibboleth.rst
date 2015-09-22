CKAN plugin "dariahshibboleth"
==============================

This plugin is used to enable Shibboleth Authentication in CKAN.
The code is available on `GitHub <https://github.com/CENDARI/ckanext-dariahshibboleth>`_.

About the plugin
----------------

The plugin hooks into the authentication dialog.
The dialog is extended to include a link to Shibboleth authentication.

If a user vists the login page while being authenticated with Shibboleth,
he is logged in to CKAN.
In case the user does not yet exists in CKAN, an account is created.

On every login, the user's mail address and full name are matched to the Shibboleth data
and updated if neccessary.

To facilitate the Single-Sign-On experience, 
the login page is usually protected on the webserver level and thus never seen by a user.
The CKAN internal user management is disabled so that changes can not be made.


.. toctree::
   :hidden:
   :maxdepth: 1


.. ifconfig:: include_submodule_docs

   ------------------
   Code Documentation
   ------------------

   .. automodule:: dariahshibboleth.plugin
      :members:
      :undoc-members:
      :show-inheritance:

