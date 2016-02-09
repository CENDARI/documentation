Litef Conductor
===============


The Litef Conductor can be built and installed from its source in the `litef-conductor repository <https://github.com/CENDARI/litef-conductor>`_ on GitHub.

To build it, Java 1.7.x, Scala 2.10.4 and `SBT <http://www.scala-sbt.org/>`_ are required.
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
     plugins = "conductor.plugins.DocumentIndexerPlugin,conductor.plugins.NerdPlugin,conductor.plugins.VirtuosoFeederPlugin,conductor.plugins.ElasticFeederPlugin"
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

Litef needs modifications to the CKAN dabase.

.. code-block:: sql

   CREATE VIEW litef_ckan_resource_view AS
   SELECT resource.id,
    resource.resource_group_id,
    resource.url,
    resource.format,
    resource.description,
    resource."position",
    resource.revision_id,
    resource.hash,
    resource.state,
    resource.extras,
    resource.name,
    resource.resource_type,
    resource.mimetype,
    resource.mimetype_inner,
    resource.size,
    resource.last_modified,
    resource.cache_url,
    resource.cache_last_updated,
    resource.webstore_url,
    resource.webstore_last_updated,
    resource.created,
    GREATEST(resource.last_modified, resource.created) AS modified,
    ( SELECT rg.package_id
      FROM resource_group rg
      WHERE (rg.id = resource.resource_group_id)) AS package_id,
    resource.url_type
   FROM resource;

   ALTER TABLE public.litef_ckan_resource_view OWNER TO ckanuser;
   
   CREATE VIEW litef_ckan_group_resource_view AS
   SELECT p.owner_org AS group_id,
    r.id,
    r.resource_group_id,
    r.url,
    r.format,
    r.description,
    r."position",
    r.revision_id,
    r.hash,
    r.state,
    r.extras,
    r.name,
    r.resource_type,
    r.mimetype,
    r.mimetype_inner,
    r.size,
    r.last_modified,
    r.cache_url,
    r.cache_last_updated,
    r.webstore_url,
    r.webstore_last_updated,
    r.created,
    r.modified,
    p.id AS package_id,
    r.url_type
   FROM ((package p
     JOIN resource_group rg ON ((p.id = rg.package_id)))
     JOIN litef_ckan_resource_view r ON ((r.resource_group_id = rg.id)));

   ALTER TABLE public.litef_ckan_group_resource_view OWNER TO ckanuser;
   
   CREATE VIEW litef_ckan_user_group_role_view AS
   SELECT "user".id AS user_id,
    "user".apikey AS user_apikey,
    member.capacity AS group_role,
    member.group_id,
    member.id,
    member.state
   FROM (member
     JOIN "user" ON ((member.table_id = "user".id)))
   WHERE (member.table_name = 'user'::text);

   ALTER TABLE public.litef_ckan_user_group_role_view OWNER TO ckanuser;
   
   CREATE VIEW litef_ckan_user_group_role_view__through_package_group AS
   SELECT "user".id AS user_id,
    "user".apikey AS user_apikey,
    object_role.role AS group_role,
    role.group_id
   FROM (("user" "user"
     JOIN user_object_role object_role ON (("user".id = object_role.user_id)))
     JOIN group_role role ON ((object_role.id = role.user_object_role_id)));

   ALTER TABLE public.litef_ckan_user_group_role_view__through_package_group OWNER TO ckanuser;
   
   CREATE VIEW litef_ckan_user_package_role_view AS
   SELECT "user".id AS user_id,
    "user".apikey AS user_apikey,
    object_role.role AS package_role,
    role.package_id
   FROM (("user" "user"
     JOIN user_object_role object_role ON (("user".id = object_role.user_id)))
     JOIN package_role role ON ((object_role.id = role.user_object_role_id)));

   ALTER TABLE public.litef_ckan_user_package_role_view OWNER TO ckanuser;
   
   CREATE VIEW litef_ckan_user_package_view AS
   SELECT group_r.user_id,
    group_r.user_apikey,
    group_r.group_role AS package_role,
    package.id,
    package.name,
    package.title,
    package.version,
    package.url,
    package.notes,
    package.license_id,
    package.revision_id,
    package.author,
    package.author_email,
    package.maintainer,
    package.maintainer_email,
    package.state,
    package.type,
    package.owner_org,
    package.private
   FROM ((litef_ckan_user_group_role_view__through_package_group group_r
     JOIN "group" ON ((group_r.group_id = "group".id)))
     JOIN package ON ((package.owner_org = "group".id)));

   ALTER TABLE public.litef_ckan_user_package_view OWNER TO ckanuser;
   
   CREATE TABLE litef_processed_resource (
    resource_id character varying(254) NOT NULL,
    last_processed timestamp without time zone,
    attachment character varying NOT NULL);

   ALTER TABLE public.litef_processed_resource OWNER TO ckanuser;
   
   CREATE TABLE litef_resource_attachment (
    resource_id character varying(254) NOT NULL,
    format character varying(254) NOT NULL,
    created timestamp without time zone NOT NULL,
    modified timestamp without time zone NOT NULL,
    content text);

   ALTER TABLE public.litef_resource_attachment OWNER TO ckanuser;
   
   ALTER TABLE ONLY litef_processed_resource
    ADD CONSTRAINT litef_processed_resource_pkey PRIMARY KEY (resource_id, attachment);
   
   ALTER TABLE ONLY litef_resource_attachment
    ADD CONSTRAINT litef_resource_attachment_pk PRIMARY KEY (resource_id, format);

   CREATE INDEX litef_processed_resource_id_last_processed_idx ON litef_processed_resource USING btree (resource_id, last_processed);

   CREATE INDEX litef_processed_resource_last_processed_idx ON litef_processed_resource USING btree (last_processed);

   CREATE INDEX litef_resource_attachment_resource_id_modified_idx ON litef_resource_attachment USING btree (resource_id, modified);

Finally, Litef can be started by

.. code-block:: bash

   java -Dfile.encoding=UTF-8 -cp /etc/litef:/opt/litef/litef-conductor.jar core.Rest

Data API
--------

The Data API is served by Litef on port ``42042`` and can be accessed locally.
To provide remote access from the Front Office server, create a dedicated user named ``apiuser``.
When adding the public keys for connecting to its ``.ssh/authorized_keys``, 
it is recommended to prepend options ``from="1.2.3.4",no-pty,no-X11-forwarding`` for security.



