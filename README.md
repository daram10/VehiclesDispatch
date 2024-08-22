# Operation National Dispatch of Vehicles National

This project focuses on analyzing the intercity trips made by transport fleets to and from the various transportation terminals in Colombian cities, using data provided by Open Data Colombia. The primary objectives are to perform a descriptive analysis that provides insights into the number of passengers per city, the cities that receive the most passengers, the most frequently used routes, and the seasons with the highest passenger flow and number of trips, from 2018 to 2024.			

The data integration process will be carried out using ETL (Extract, Transform, Load) methodology, which involves:
Extraction: Collecting relevant data from Open Data Colombia.
Transformation: Cleaning, sorting, and organizing the data for analysis.
Loading: Importing the processed data into a suitable database or analysis tool for further study.

![MovilidadETL drawio](https://github.com/user-attachments/assets/ed3f0f33-5a1a-4b1b-a73e-2b17937b8f17)

The project aims to offer valuable insights into transportation patterns and trends in Colombia, which can inform decision-making and improve transportation planning and services.

## Table of contents 
- [Requirements](#Requirements)
- [Instalación](#instalación)
- [Uso](#uso)
- [Contribución](#contribución)
- [Licencia](#licencia)

 
## Requirements
1.   -The National Vehicles Dispatch data source is: [Datos Abiertos](https://www.datos.gov.co/Transporte/Operaci-n-de-pasajeros-y-despacho-de-veh-culos-en-/eh75-8ah6/data_preview). 
     -Divipola (National Geopolitical Colombian Division) dataset: [Datos Abierto](https://www.datos.gov.co/Mapas-Nacionales/DIVIPOLA-C-digos-municipios/gdxc-w37w/about_data)

2. Data manipulation: SQL Server (creation of the tables and quality check of the information) and Visual Studio 2019 (ETL creation).

3. Data visualization: Power BI.

## Process 
The project is divided in three data manipulation stages: 1. upload raw information by an ETL, 2. ER model (entity design), and 3. Kimbal Model or Star Model (dimension and fact tables design). In the next sections will be explained on detail each process.   

### Upload raw information
From the official Colombian Data Repository, the dataset contents most of 20,000,000 rows of information. For this reason, the process of upload to the Relational Data Base Management System (RDBMS) through a ETL.

[alt text][MovilidadSourceDataFlow.png]

### Upload information
Once the data is in the RDBMS, there were created 9 entities tables and relations through 

### ETL Upload information
The project aims to offer valuable insights into transportation patterns and trends in Colombia, which can inform decision-making and improve transportation planning and services.

### DatawareHouse
    Definition of tables and theoretical information behind 
    
### ETL Data warehouse
The project aims to offer valuable insights into transportation patterns and trends in Colombia, which can inform decision-making and improve transportation planning and services.

### Kimball Model 
why do we use this model and not others???
The project aims to offer valuable insights into transportation patterns and trends in Colombia, which can inform decision-making and improve transportation planning and services.

## Visualization 
Power BI file 
The project aims to offer valuable insights into transportation patterns and trends in Colombia, which can inform decision-making and improve transportation planning and services.



[def]: image.png


check 