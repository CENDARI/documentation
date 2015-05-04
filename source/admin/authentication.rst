Authentication
==============

CENDARI uses the Authentication and Authorisation Infrastructure provided by DARIAH [#dariah]_, the DARIAH AAI.

Consequently, all account management is handled externally by and through DARIAH. 

The DARIAH AAI provides SAML [#SAML]_ authentication using the open source solution Shibboleth.
The AAI is integrated into the DFN-AAI Shibboleth federation [#dfnaai]_, which in turn is part of the European eduGAIN meta federation [#edugain]_.


A very extensive and in-depth explanation of Shibboleth and an AAI federation is provided by the SWITCH online demo [#switchaaidemo]_.

Accessing user identity
-----------------------

All CENDARI front end applications can access the user's attributes from the server's environment variables or headers, as listed in the following table.

============== ========
Attribute      Contents
============== ========
``eppn``       the *eduPersonPrincipalName*, the user's unique username
``givenName``  the user's first name
``sn``         the user's last name
``cn``         the user's full name
``mail``       comma seperated list of the user's email addresses
``isMemberOf`` comma seperated list of the user's DARIAH groups
============== ========

.. todo:: username from API

The ``isMemberOf`` attribute contains a list of groups that the user was added to by DARIAH AAI management.
These groups are used to grant access and privileges to users on a per-application basis.

.. rubric:: Footnotes

.. [#dariah] `DigitAl Research Infrastructure for the Arts and Humanities <https://de.dariah.eu/>`_
.. [#SAML]   Security Assertion Markup Language
.. [#dfnaai] `DFN-AAI – Authentifikations- und Autorisierungs-Infrastruktur <https://www.aai.dfn.de/>`_
.. [#edugain] `eduGAIN – Interconnecting federations to link services and users worldwide <http://www.geant.net/service/eduGAIN/Pages/home.aspx>`_
.. [#switchaaidemo] `SWITCH  AAI Demo <https://www.switch.ch/aai/demo/>`_

