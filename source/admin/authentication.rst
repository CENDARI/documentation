Authentication
==============

CENDARI uses the Authentication and Authorisation Infrastructure currently under development by DARIAH-DE [#dariah]_, the DARIAH AAI.
Consequently, all account management is handled externally by and through DARIAH. 

The DARIAH AAI provides SAML [#SAML]_ authentication using the open source solution Shibboleth [#shibbolethnet]_.

Shibboleth explained
--------------------

.. todo:: Basics of Shibboleth.

Accessing user identity
-----------------------

All CENDARI front end applications can access the user's attributes from the server's environment variables or headers, as listed in the following table.

============== ========
Attribute      Contents
============== ========
``eppn``       the *eduPersonPrincipalName*, the user's unique username
``givenName``  the user's first name
``sn``         the user's last name
``cn``         comma seperated list of the user's full names
``mail``       comma seperated list of the user's email addresses
``isMemberOf`` comma seperated list of the user's DARIAH groups
============== ========

All of these attributes are UTF-8 encoded strings, but some will eventually be reduced to ASCII.
At the time of implementing Shibboleth authentication in CENDARI, DARIAH-DE had not finalised the specification of these attributes.

In general, the ``eppn`` is the user's unique identifier, ending in ``@dariah.eu`` for all DARIAH users.
While DARIAH is working towards an integration with DFN-AAI Shibboleth federation [#dfnaai]_, 
which in turn is part of the European eduGAIN meta federation [#edugain]_, 
due to blocking bugs in the beta phase, CENDARI will not support this, but require all users to register a DARIAH Homeless Account with the DARIAH AAI.

The part of the ``eppn`` before the DARIAH domain suffix usually consists of the user's DARIAH login name, but this varies.
The characters encountered can be any ascii character, including spaces, quotes and the `@` symbol.
The acutal CENDARI username and the Data API session key can be requested from the CENDARI Data API
by sending the user's ``eppn``, ``mail`` and ``cn`` to the API, see :doc:`/developer/litef-conductor/docs/session/post-session`

For both the full name and the mail address, some users have more than one entry which are presented to the application as comma seperated list.
Consistency in their order is not guaranteed.


The ``isMemberOf`` attribute contains a list of groups that the user was added to by DARIAH AAI management.
These groups are used to grant access and privileges to users on a per-application basis.

For each application a number of these groups can be mapped to specific access rights.
Thus upon login, the application matches this list against the known groups corresponding to its access rights.

.. rubric:: Footnotes

.. [#dariah] `DigitAl Research Infrastructure for the Arts and Humanities <https://de.dariah.eu/>`_
.. [#dfnaai] `DFN-AAI – Authentifikations- und Autorisierungs-Infrastruktur <https://www.aai.dfn.de/>`_
.. [#edugain] `eduGAIN – Interconnecting federations to link services and users worldwide <http://www.geant.net/service/eduGAIN/Pages/home.aspx>`_
.. [#SAML]   Security Assertion Markup Language
.. [#shibbolethnet] `Shibboleth <https://shibboleth.net/>`_

