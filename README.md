# Karate DSL LLM Assisted Test Case Generator 


## Repository Structure
- Results folder contains specific test cases, results and aditional files for the respective API. 

## How to Use


## Additional Resources
- For more detailed information, refer to the AdditionalResources/ folder.

## Karate Project Builder
The main fields you need to modify are:
`api_name = "Swagger_Petstore_Lite"` 

## Karate Feature File Producer
This script will write the Karate DSL feature files using the output files from the oas_decomposer script, they will writen in the output directory in named as the API.

### Path to OpenAPI file

process_openapi_file('input/petstore_lite.yaml')

### Name of the folder with the ouptufiles,tThis will be used in oas_decomposer.py
api_name = 'Swagger_Petstore_Lite'  

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

## Results 
We've documented our framework performance in terms of test generated, test results, and other findings in our `results` folder. 

- Navigate to the version folder corresponding to the framework version.
- Inside each version folder, find folders for each API tested.
- Explore `{ApiName}/KRTLLM/TestCases/` for the test scripts and `{ApiName}/KRTLLM/TestResults/` for the outcome of these tests.
-  `GeneratedFramework` for the test scripts and `KRTLLM/TestResults/` for the outcome of these tests.
- We've included test cases and test results from other frameworks like `RESTest` for comparison.
