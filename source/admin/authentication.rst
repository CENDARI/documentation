Authentication
==============

CENDARI uses the Authentication and Authorisation Infrastructure currently under development by DARIAH-DE [#dariah]_, the DARIAH AAI.
Consequently, all account management is handled externally by and through DARIAH. 

The DARIAH AAI provides SAML [#SAML]_ authentication using the open source solution Shibboleth [#shibbolethnet]_.

Shibboleth explained
--------------------


Shibboleth authentication provides a procedure to deferr the actual login to a known third party.
From the point of view of an application, the login process is deferred to the Shibboleth service provider, the SP, 
which runs on the same server that hosts the application. 
The SP in turn requests the user’s identity attributes from the DARIAH identity provider, the IdP.
Upon receiving the user’s identity and authorisation attributes from the DARIAH IdP, 
the SP provides the attributes to the application via the web- or application server in the form of headers or environment variables. 
In the case of CENDARI, the application than sends the Shibboleth attributes to the CENDARI Data API, which returns the CENDARI internal session token and username, see below.

From the user’s point of view, when trying to log into a CENDARI service, 
he is redirected to the familiar DARIAH AAI login page, where he performs the authentication. 
Upon successful completion, he will instantly be redirected back to the original website and automatically logged in there. 
Apart from the URL changes, the whole process is entirely transparent to the user.

Should the user not have a DARIAH Homeless account, he can directly apply for an account from the DARIAH login page. 
If he does so using an institutional mail address, the account will be created automatically 
and upon accepting the the terms of use for both DARIAH and CENDARI, the user will be able to use CENDARI services.

A very extensive and in-depth explanation of Shibboleth and an AAI federation, see below, is provided by the SWITCH online demo [#switchaaidemo]_.


The user’s attributes are exchanged between the SP and the IdP using public-key cryptography. 
They are sent along with the redirects through the user's brower.
To achieve this, the CENDARI SP and the DARIAH IdP have pre-shared their public-keys through a manual verification process.

Therefore the DARIAH IdP can trust that the authentication requests have been started by a trusted party, i.e. CENDARI, and disclose the user’s private attributes.
Even more importantly, the CENDARI SP can validate the user’s attributes it receives as authoritative. 
The application can thus simply trust the identity it receives from the SP. 
The exchange between the actual application and the SP is handled entirely by the Apache web server.


Enabling Shibboleth authentication
----------------------------------

Within CENDARI, all services have been developed or extended with the use of Shibboleth authentication in mind.

There are two ways Shibboleth authentication is used:

1. Access to the application is permitted only after successful authentication.
2. Public access to the application is possible, but login is required to contribute content.


In both cases, the setup is very similar as the Shibboleth authentication is always enforced directly by Apache.
Either the whole application or a dedicated Login-Page are protected by asserting

Alternatively, Apache can enforce the Shibboleth authentication directly for a certain URL,
i.e. the application can rely on Apache to make sure the user is authenticated through Shibboleth when accessing a certain path on the server

.. code-block:: apache

   # enforcing Shibboleth
   <Location /shibboleth-enforced>
     AuthType shibboleth
     ShibRequestSetting requireSession true
     Require shib-attr isMemberOf cendari-users
   </Location>

in the Apache config.
This way, the application simply checks for the presence of Shibboleth attributes and acts accordingly.
In the first case of full shibboleth protecttion, the application simply fails to work without Shibboleth.

The second case, where authentication is optional, rewuires the application to override its internal authentication in the presence of Shibboleth attributes.
To make this work, the login has to be done on an individual page with a dedicated URL as opposed to a dropdown menu embedded on all pages.

This login URL is than set up to enforce Shibboleth authentication prior to access.
If the login page is called, the application checks for the presence of Shibboleth attributes.
If they are present, the corresponding user is logged in directly, without actually prompting for a password.
In other words, a session is started and the user is immediately directed back to the applications landing page.
If the user is not yet know to the application, the account is created from the Shibboleth data on the fly.

If the login page is called but no shibboleth data provided, as may be the case in development, the application handles authentication through its usual internbal mechanism.

In both cases, the application initiates a session using its own session management after successful authentication either by Shibboleth or internal mechanisms.

This solution has been applied to the CKAN repository and the AtoM Archival directory through :doc:`dedicated </developer/atom/shibboleth>` :doc:`plugins </developer/ckan/cendari>` plugins, as well as CENDARI's own NTE.


Closing the Session
^^^^^^^^^^^^^^^^^^^

To end a Shibboleth session, i.e. log out the current user, the application has to end it's own user session and finally initiate a redirect to

.. code-block:: apache

   https://<fqdn>/Shibboleth.sso/Logout

which will close the Shibboleth session on the Server. 
Unless the user has authenticated within the last 30 minutes with the DARIAH IdP, a new login will be required when next accessing the services.

Accessing user identity
-----------------------

After successful authentication, the CENDARI front end applications can access the user's attributes from the server's environment variables or headers, 
as listed in the following table.

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
.. [#switchaaidemo] `SWITCH  AAI Demo <https://www.switch.ch/aai/demo/>`_

