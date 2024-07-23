-- Homework 1

/*

1.Data Integrity and Validation: Relational databases provide a structured and controlled environment
                                 for data storage. They allow you to define data types, constraints, 
                                 and relationships between tables.This ensures data integrity and validation,
                                 preventing the entry of inconsistent or incorrect data. In Excel, data validation
                                 is more manual and error-prone, making it easier to introduce data quality issues.

2. Concurrency and Multi-User Support: Relational databases are designed for concurrent access by multiple users.
                                       They offer features like transactions and locking mechanisms to ensure data
                                       consistency when multiple users are working with the data simultaneously. 
                                       Excel files can be locked for editing by a single user, which can lead to
                                       collaboration challenges in multi-user scenarios.

3. Scalability and Performance: Relational databases are better suited for handling large datasets and complex queries.
                                They can optimize data retrieval using indexing and query optimization techniques, 
                                making them more efficient for complex data analysis tasks. Excel files may become 
                                slow and unwieldy with large amounts of data.

4. Data Security and Access Control: Relational databases provide robust security and access control mechanisms. 
                                     You can define user roles and permissions to restrict access to sensitive data. 
                                     In Excel, securing data and controlling access is limited and often relies on file-level security.

5. Data Consistency and Normalization: Relational databases encourage data normalization, which means data is organized
                                       efficiently to reduce redundancy and improve data consistency. Excel files often
                                       have data duplication, making it harder to maintain data consistency across multiple sheets.

6. Data Backup and Recovery: Databases typically offer backup and recovery mechanisms, ensuring that your data is protected
                             from accidental loss or corruption. Excel files may not have the same level of backup and recovery
                             features, and the loss of a file can result in permanent data loss.

7. Query and Reporting Capabilities: Relational databases offer powerful query and reporting capabilities through SQL (Structured Query Language).
                                     Excel has some data analysis features, but it may not be as robust as the querying capabilities of databases.

8. Centralized Data Repository: Databases provide a centralized repository for data, making it easier to manage and update data
                                in one place. In Excel, data can be spread across multiple files and sheets, making 
                                data management more challenging.

9. Version Control: Relational databases often include version control features, allowing you to track changes and maintain a
					history of data modifications. Excel files may require manual version control, which can be error-prone.

*/








-- Homework 2




-- Create an imaginary databank

CREATE DATABASE protein;



-- Active the already created database

USE protein;





-- Create a structure table

CREATE TABLE structure(

    pdb_accession VARCHAR(25) PRIMARY KEY,  -- PDB accession number
    protein_name VARCHAR(100),  -- Name of the protein structure
    resolution DOUBLE  -- Resolution in meters (e.g., 1.25e-10)
    
);






-- Create a sequence table

CREATE TABLE sequence(

    uniport_accession VARCHAR(25),  -- Uniport accession number
    protein_name VARCHAR(100),  -- Name of the protein sequence
    pdb_accession VARCHAR(25), -- Foreign key
    FOREIGN KEY (pdb_accession) REFERENCES structure(pdb_accession)
    
);




/* 

  some input data (fake):
  
    Accession Pair 1:
        Protein Sequence: Q9F4L3
        Protein Structure: 2AG0

    Accession Pair 2:
        Protein Sequence: Q1X2Z5
        Protein Structure: 3BC1

    Accession Pair 3:
        Protein Sequence: P5R9Q2
        Protein Structure: 4DE2

    Accession Pair 4:
        Protein Sequence: M8N3K1
        Protein Structure: 5FG3

    Accession Pair 5:
        Protein Sequence: Z0T7Y9
        Protein Structure: 6HI4 

*/



-- Fill in the structure table 

INSERT INTO structure
VALUES("2AG0", "Structure 1", 1.25e-10),
      ("3BC1", "Structure 2", 2.01e-10),
      ("4DE2", "Structure 3", 3.55e-10),
      ("5FG3", "Structure 4", 2.78e-10),
      ("6HI4", "Structure 5", 1.99e-10);
      
      

-- Fill in the sequence table

INSERT INTO sequence
VALUES("M8N3K1", "Sequence 1", "5FG3"),
      ("Z0T7Y9", "Sequence 2", "6HI4"),
      ("Q9F4L3", "Sequence 3", "2AG0"),
      ("P5R9Q2", "Sequence 4", "4DE2"),
      ("Q1X2Z5", "Sequence 5", "3BC1");
      
      
SELECT * FROM structure;
SELECT * FROM sequence;







# Homework 3



-- Part a:

-- Temperature: 298.15 K

USE mixtures;

SELECT * FROM VISCOSITY
WHERE TEMPERATURE >= 298.15 AND MOLE_FRACTION_WATER < 0.5;




-- Part b:

SELECT LITURATURE_DOI FROM VISCOSITY
WHERE TEMPERATURE >= 298.15 AND MOLE_FRACTION_WATER < 0.5;



-- Part c:

SELECT * FROM VISCOSITY  -- select all columns from the VISCOSITY table 
INNER JOIN MIXTURE ON VISCOSITY.MIXTURE_ID = MIXTURE.ID  -- join the VISCOSITY table with the MIXTURE table using the MIXTURE_ID column
WHERE MIXTURE.NAME = "methanol-water";  -- filter the results to include only mixtures with the name "methanol-water" from the MIXTURE table






















       







       
       

















       


