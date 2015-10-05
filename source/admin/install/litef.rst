Litef Conductor
===============


The Litef Conductor can be built and installed from its source in the `litef-conductor repository <https://github.com/CENDARI/litef-conductor>`_ on GitHub.

To build it,  Java 1.7.x, Scala 2.10.4 and `SBT <http://www.scala-sbt.org/>`_ are required.
Running

.. code-block:: bash

   sbt compile assembly

will compile a fat jar, that can be deployed to the server.

Additionally, Litef requires a configuration file ``/etc/litef/application.conf``

.. code-block:: json

   logger.scala.slick.session=DEBUG

   litef {
     namespace = "http://localhost:42042/v1/"
   }

   litef.ckan {
     home         = "https://host/ckan"
     namespace    = "https://host/ckan/api/3/"
     apiKey       = "***********"

     localStoragePrefix = "/data/resources"

     postgres {
       url      = "jdbc:postgresql://localhost:5432/***********"
       driver   = "org.postgresql.Driver"
       username = "***********"
       password = "***********"
     }
   }

   litef.virtuoso {
     url = "jdbc:virtuoso://localhost:1111"
     username = "dba"
     password = "***********"
   }

   litef.nerd {
     namespace = "http://traces1.saclay.inria.fr:8090/"
   }

   litef.elastic {
     namespace = "http://localhost:9200/"
   }

   litef.indexer {
     localStoragePrefix = "/var/lib/litef/default/resources"
   }

   litef.conductor {
     fileSizeLimit = 10000
     plugins = "conductor.plugins.DocumentIndexerPlugin,conductor.plugins.NerdPlugin,conductor.plugins.VirtuosoFeederPlugin"
   }

   akka {
     log-dead-letters = 10
     log-dead-letters-during-shutdown = on
     loglevel = "INFO"
   }

   spray {
     can.server {
       request-timeout = 240s
       idle-timeout = 300s
     }
     can.client {
       request-timeout = 240s
       idle-timeout = 300s
     }
 
     routing {
       file-chunking-threshold-size = 10k
       file-chunking-chunk-size = 5k
     }
   }

   logger.scala.slick=ERROR
   logger.scala.slick.session=ERROR


Litef requires a dedicated CKAN sysadmin, thus after installing CKAN create that sysadmin:

.. code-block:: bash

   source /var/www/ckan/bin/activate
   cd /var/www/ckan/src/ckan
   paster sysadmin add litef -c /etc/ckan/production.ini

Add the new sysadmin's API key to ``/etc/litef/application.conf``.

Finally, Litef can be started by

.. code-block:: bash

   java -Dfile.encoding=UTF-8 -cp /etc/litef:/opt/litef/litef-conductor.jar core.Rest

Data API
--------

The Data API is served by Litef on port ``42042`` and can be accessed locally.
To provide remote access from the Front Office server, create a dedicated user named ``apiuser``.
When adding the public keys for connecting to its ``.ssh/authorized_keys``, 
it is recommended to prepend options ``from="1.2.3.4",no-pty,no-X11-forwarding`` for security.



