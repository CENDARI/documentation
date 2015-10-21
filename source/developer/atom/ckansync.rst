AtoM-CKAN Synchronisation
=========================

The files edited in AtoM are synchronised to the CENDARI CKAN repository once per day.
This is achieved by a script collection specifically created during the CENDARI project.
The code is availabe on `GitHub <https://github.com/CENDARI/atom2ckan>`_.

The scripts rely on modifications to the AtoM Database that need to be guessed form the scripts Readme or the code itself.

There are three satelite tables in the atom database:

.. code-block:: bash
    
    harvester_ead
    +------------------------+--------------+------+-----+---------+-------+
    | Field                  | Type         | Null | Key | Default | Extra |
    +------------------------+--------------+------+-----+---------+-------+
    | atom_ead_id            | int(11)      | NO   | PRI | NULL    |       |
    | atom_ead_slug          | varchar(255) | YES  |     | NULL    |       |
    | atom_eag_slug          | varchar(255) | YES  |     | NULL    |       |
    | repository_resource_id | varchar(40)  | YES  |     | NULL    |       |
    | sync_date              | datetime     | YES  |     | NULL    |       |
    +------------------------+--------------+------+-----+---------+-------+

    harvester_eag
    +------------------------+--------------+------+-----+---------+-------+                                                                                                                                          
    | Field                  | Type         | Null | Key | Default | Extra |                                                                                                                                          
    +------------------------+--------------+------+-----+---------+-------+                                                                                                                                          
    | atom_eag_id            | int(11)      | NO   | PRI | NULL    |       |                                                                                                                                          
    | atom_eag_slug          | varchar(255) | YES  |     | NULL    |       |                                                                                                                                          
    | repository_resource_id | varchar(40)  | YES  |     | NULL    |       |                                                                                                                                          
    | sync_date              | datetime     | YES  |     | NULL    |       |                                                                                                                                          
    +------------------------+--------------+------+-----+---------+-------+

    harvester_date
    +-------+----------+------+-----+---------+-------+                                                                                                                                                               
    | Field | Type     | Null | Key | Default | Extra |                                                                                                                                                               
    +-------+----------+------+-----+---------+-------+                                                                                                                                                               
    | date  | datetime | YES  |     | NULL    |       |                                                                                                                                                               
    +-------+----------+------+-----+---------+-------+

Table harvester_ead contains AtoM id and slug of the description, AtoM slug and ID of the description's repository, CKAN ID of the description and the date of the synchronization.

Table harvester_eag contains AtoM slug and ID of the repository, CKAN ID of the repository and the date of the synchronization.

Table harvester_date contains time of the last execution of this script. 

.. toctree::
   :hidden:
   :maxdepth: 1


