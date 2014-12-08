CENDARI REST API
================

.. see http://pythonhosted.org//sphinxcontrib-httpdomain/

The API works as follow:


Session
-------

.. http:post:: ${ROOT_NS}/session

   :<json string eppn: ePPN
   :<json string mail: Mail
   :<json string cn: CommonName

   :>json sessionKey: the user's session key

Dataspace
---------

GET URIs
^^^^^^^^

.. http:get:: ${ROOT_NS}/dataspaces/{id}

   :arg integer id: A dataspace id.
   :reqheader Authorization: optional session key for authenticated access

   Information about the specified dataspace.


POST URIs
^^^^^^^^^

Create a dataspace
""""""""""""""""""

.. http:post:: ${ROOT_NS}/dataspaces

   :<json string name: a string between 2 and 100 characters long, containing only lowercase alphanumeric characters, `-` and `_`
   :<json string title: optional
   :<json string descriptio: optional
   :statuscode 200: no error
   :statuscode 404: no such object
   :reqheader Authorization: required session key for authenticated access

   Create a dataspace.

Create a resource in dataspace
""""""""""""""""""""""""""""""

.. http:post:: ${ROOT_NS}/dataspaces/${DATASPACE_ID}/resources

   :form file: file for upload
   :form name: optional
   :form format: optional
   :form description: optional
   :form setId: optional (if not specified, a new set will be created and new resource will be assigned to it)


PUT URIs
^^^^^^^^

Resource update
"""""""""""""""

.. http:put:: ${ROOT_NS}/dataspaces/${DATASPACE_ID}/resources/${RESOURCE_ID}

    :form file: file for upload
    :form name: optional
    :form format: optional
    :form description: optional

Resource
--------


GET URIs
^^^^^^^^

.. http:get:: ${ROOT_NS}/resources/${ID}[.format] 
   
   :param format: json and html are supported

   returns metadata for the resource

.. http:get:: ${ROOT_NS}/resources/${ID}/data 

   binary data of the object with the specified id

.. http:get:: ${ROOT_NS}/resources/${ID}/rdf

   extracted RDF data from the specified resource, N3 format

.. http:get:: ${ROOT_NS}/resources/${ID}/rdf/xml

   extracted RDF data from the specified resource, XML format

Result
------


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


