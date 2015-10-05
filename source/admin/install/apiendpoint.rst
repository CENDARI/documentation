Data API endpoint
=================

To provide local access to the CENDARI Data API, create a passphrase-less ssh keypair and distribute it to the Back Office's ``apiuser``.
Finally use ``autossh`` to establish port forwarding::

  autossh -NL 42042:127.0.0.1:42042 -i /path/to/key apiuser@back.office

