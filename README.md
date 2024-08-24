# Operation National Dispatch of Vehicles National

This project focuses on analyzing the intercity trips made by transport fleets to and from the various transportation terminals in Colombian cities, using data provided by Open Data Colombia. The primary objectives are to perform a descriptive analysis that provides insights into the number of passengers per city, the cities that receive the most passengers, the most frequently used routes, and the seasons with the highest passenger flow and number of trips, from 2018 to 2024.			

The data integration process will be carried out using ETL (Extract, Transform, Load) methodology, which involves:
Extraction: Collecting relevant data from Open Data Colombia.
Transformation: Cleaning, sorting, and organizing the data for analysis.
Loading: Importing the processed data into a suitable database or analysis tool for further study.

![MovilidadETL drawio](https://github.com/user-attachments/assets/ed3f0f33-5a1a-4b1b-a73e-2b17937b8f17)

The project aims to offer valuable insights into transportation patterns and trends in Colombia, which can inform decision-making and improve transportation planning and services.

## Table of Contents
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Process](#process)
- [Visualization](#visualization)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

 
## Requirements
- The National Vehicles Dispatch data source: [Datos Abiertos](https://www.datos.gov.co/)
- Divipola (National Geopolitical Colombian Division) dataset: [Datos Abiertos](https://www.datos.gov.co/)
- SQL Server: For creation of tables and quality check of the information
- Visual Studio 2019: For ETL creation

## Installation
1. Clone the repository.
2. Set up the SQL Server and Visual Studio 2019 as per the requirements.
3. Install Power BI Desktop from [Power BI](https://powerbi.microsoft.com/desktop/).

## Usage
1. Upload raw information from the official Colombian Data Repository. The dataset contains over 20,000,000 rows of information.
2. Use the ETL process to upload data to the Relational Database Management System (RDBMS).
3. Follow the steps in the `DWHMovilidadTables.sql` script to create the necessary tables and relationships.

## Process
The project is divided into three data manipulation stages:
1. **Upload Raw Information**: Using an ETL process.
[![alt text](https://github.com/daram10/VehiclesDispatch/blob/main/MovilidadSourceDataFlow.png)]
2. **ER Model (Entity Design)**: Creating entities and relationships.
3. **ETL DWH upload information**: The data is transformed to fit the entity-relationship model, ensuring consistency and integrity.
4. **Kimball Model (Star Schema)**: Designing dimension and fact tables.
5. **ETL Kimball Model upload information**: The data is transformed into a star schema, organizing it into dimension and fact tables for efficient querying.


### Dataware House (ER Model)
Once the data is in the RDBMS, nine entities (tables) and their relationships are created in the Data Warehouse model. These tables are normalized to maintain data integrity.

![alt text](https://github.com/daram10/VehiclesDispatch/blob/main/DWHModelMovilidad.png)
    
### ETL Data Warehouse

The information is uploaded using an ETL process. Each entity has a pipeline, which is then joined into a principal package.
![!\[alt text\]](https://github.com/daram10/VehiclesDispatch/blob/main/DWHETLMovilidad.png)

### Star Model (Kimball) 
For the tables made in the Star Model 

### ELT Kimball Model 

## Visualization 
Power BI file 
The project aims to offer valuable insights into transportation patterns and trends in Colombia, which can inform decision-making and improve transportation planning and services.