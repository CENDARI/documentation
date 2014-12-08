CENDARI REST API
================

The API works as follow:


GET URIs
--------

.. http:method:: GET ${ROOT_NS}/dataspaces/{id}

   :arg integer id: A dataspace id.

   Information about the specified dataspace.


POST URIs
---------

.. http:method:: POST ${ROOT_NS}/dataspaces

   :param string name:  a string between 2 and 100 characters long, containing only lowercase alphanumeric characters, - and _
   :param string title: optional
   :param string description: optional
   :response 201: A dataspace was created successfully.
   :response 400:

   Create a dataspace.

Result
------

.. http:response:: Dataspace object

   A typical resource looks like this::

      {
        "id": "07b8aae6-024d-49e5-ac25-20b15d043d61",
        "url": "http://localhost:42042/v1/resources/07b8aae6-024d-49e5-ac25-20b15d043d61",
        "dataUrl": "http://localhost:42042/v1/resources/07b8aae6-024d-49e5-ac25-20b15d043d61/data",
        "name": "metadata in edm format",
        "description": "metadata in edm format",
        "format": "RDF",
        "mimetype": "",
        "size": 0,
        "created": 1401983959286,
        "modified": 1401983959286,
        "setId": "7a5b81a8-4260-490f-92ab-f00f65bf0a35"
      }

   :format: JSON


