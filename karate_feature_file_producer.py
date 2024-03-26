# Karate Feature File Producer

import os
import openai
import json
import logging
import time
from oas_decomposer import process_openapi_file
# Directory where the OAS description files are saved
api_name = 'VAmPI'  # Replace with actual API name used in oas_decomposer.py
output_dir = f'output/{api_name}'
log_dir = f'{output_dir}/log/'
os.makedirs(output_dir, exist_ok=True)  # Ensure the directory exists
os.makedirs(log_dir, exist_ok=True)  # Ensure the directory exists
log_file_path = os.path.join(log_dir, 'log.txt')

# Configure logging
# Configure logging to file
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S',
    handlers=[
        logging.FileHandler(log_file_path),
        logging.StreamHandler()  # To also log to console; remove if not needed
    ]
)
logger = logging.getLogger()
# Assuming you have the oas_decomposer.py content in a function named decompose_oas


# Set the base URL for the LLM
openai.api_base = "http://192.168.0.101:4893/v1"

# Function to generate Karate DSL test scenario using Open LLM
def generate_karate_test_scenario(oas_json):
    # Convert the JSON object to a string and escape double quotes
    oas_json_string = json.dumps(oas_json).replace('"', '\\"')

    # Set up the prompt with the sanitized OAS JSON content
    prompt = (
        "Write a Karate DSL scenario specifically targeting API security testing for vulnerabilities such as "
        "Broken Object Level Authorization (BOLA), Authentication Flaws, and Authorization Issues. Tailor the scenarios "
        "to handle and validate authentication tokens, ensure proper authorization checks, and avoid common pitfalls "
        "like hardcoded endpoints. Structure the scenario with dynamic data handling for authentication tokens and "
        "include domain-specific endpoint paths to enhance realism. The scenario structure is as follows:\n\n"
        "Feature: [Feature Name] for BOLA and Auth Vulnerabilities\n"
        "    Background:\n"
        "         * url 'http://localhost:5000'\n"
        "    Scenario: [ScenarioID]-[Scenario Name]\n"
        "         Given path '[endpoint]'\n"
        "         And request [request details]\n"
        "         When method POST/PUT/GET/DELETE\n"
        "         Then status 200/401/403\n"
        "         And match response body to expected schema\n\n"
        "Include only the essential Karate DSL code for the java feature scenario. Ensure the scenario comprehensively "
        "covers the endpoint path, request headers, and JSON body (if required) with all fields as per the schema. "
        "Emphasize dynamic data handling for tokens and sensitive fields, ensuring that setup steps common to BOLA and "
        "authentication tests are detailed in the Background section. Gracefully handle potential error responses.\n"
        "For scenario generation, use the specific OpenAPI specification provided:\n\n"
        f"\"{oas_json_string}\"\n"
    )

    old_prompt = (
        "Write a Karate DSL scenario for API security testing, considering vulnerabilities like SQL injection, "
        "Broken Authentication, CSRF, and others. Depending on the required fields (body params, query params, "
        "assertion types and so on) "
        "The scenario should be structured as follows:\n\n"
        "Feature: [Feature Name]\n"
        "    Background:\n"
        "         * [Background details such as URL path/headers]\n"
        "    Scenario: [ScenarioID]-[Scenario Name]\n"
        "         Given url/path\n"
        "         And request body (if any)\n"
        "         And headers \n"
        "         When method POST/PUT/GET/DELETE\n"
        "         Then status\n\n"
        "         And match body (if any)\n\n"
        "Include only the required Karate DSL code for the java feature scenario code. "
        "The scenario should include the endpoint path, request headers, and a JSON body (if required) with "
        "all required fields as per the schema. Validate the response to ensure it has the required status code and "
        "the response body matches the expected schema. Include dynamic data handling for fields where applicable "
        "and, ensure that common setup steps are in the Background section."
        "Handle potential error responses gracefully. "
        "Use the following OpenAPI specification for the scenario generation:\n\n"
        f"\"{oas_json_string}\"\n"
    )

    model = "krtllm_model_v1_7.q8_0.gguf"
    logger.info(f"The following prompt was sent: \n {prompt} ")

    # Make the API request
    response = openai.Completion.create(
        model=model,
        prompt=prompt,
        max_tokens=1024,
        temperature=0.28,
        top_p=0.95,
        n=1,
        echo=False,
        stream=False
    )
    logger.info(f"The LLM response was: \n {response} ")

    # Return the generated completion
    return response.choices[0].text

# Main function to decompose OAS and generate Karate DSL test scenarios
def main():
    start_time = time.time()
    # Replace 'openapi_file.yaml' with the path to your actual OpenAPI file
    process_openapi_file('input/vampi_openapi3.yaml')
    decompose_duration = time.time() - start_time
    logger.info(f"Decomposition completed in {decompose_duration:.2f} seconds")

    # Iterate over each OAS description file asnd generate Karate DSL test scenarios
    initialTotalOutputedJsonFiles = sum(1 for f in os.listdir(output_dir) if f.endswith('.json'))
    totalOutputedJsonFiles = initialTotalOutputedJsonFiles

    for file_name in os.listdir(output_dir):
        if file_name.endswith('.json'):
            file_path = os.path.join(output_dir, file_name)
            try:
                with open(file_path, 'r') as file:
                    oas_json = json.load(file)

                start_time = time.time()
                # Generate Karate DSL test scenario
                karate_dsl = generate_karate_test_scenario(oas_json)
                generation_duration = time.time() - start_time
                logger.info(f"LLM scenario generation for {file_name} completed in {generation_duration:.2f} seconds")

                start_time = time.time()
                # Save the Karate DSL test scenario to a file
                feature_output_dir = f'{output_dir}/test_suite'
                os.makedirs(feature_output_dir, exist_ok=True)
                test_scenario_file = file_name.replace('.json', '_karate_dsl.feature')
                with open(os.path.join(feature_output_dir, test_scenario_file), 'w') as file:
                    file.write(karate_dsl)
                save_duration = time.time() - start_time
                logger.info(f"Karate DSL test scenario saved to {test_scenario_file} in {save_duration:.2f} seconds")
                totalOutputedJsonFiles -= 1
                logger.info(f"Remaining tests to write {totalOutputedJsonFiles} out of {initialTotalOutputedJsonFiles}")

            except Exception as e:
                logger.error(f"Error processing {file_name}: {e}", exc_info=True)


if __name__ == "__main__":
    t_start_time = time.time()
    main()
    total_duration = time.time() - t_start_time
    minutes, seconds = divmod(total_duration, 60)
    logger.info(f"Test suite written in {int(minutes)} minutes and {seconds:.2f} seconds")
