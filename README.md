# Karate DSL LLM Assisted Test Case Generator 


## OAS/Swagger File Decomposer

For various needs, such as using a separate file for a REST API request method. This program will decompose a given OAS requirement file into separate files.

Requirements:
- Python v3.7+
- OAS(Swagger) yaml file 3.0+ 

This script will:

- Load the Swagger YAML file.
- Iterate over each path and method.
- Create a file name based on the path, method, and response status code.
- Extract the necessary definitions for each method.
- Save each method and its responses, along with the necessary definitions, into a separate JSON file.

## Karate API Framework

Requirements:
- Java 17+
- Maven 3.6+ 

## Karate Project Builder
The main fields you need to modify are:
`api_name = "Swagger_Petstore_Lite"` 

## Karate Feature File Producer
    
### Path to OpenAPI file

process_openapi_file('input/petstore_lite.yaml')

### Name of the folder with the ouptufiles,tThis will be used in oas_decomposer.py
api_name = 'Swagger_Petstore_Lite'  

