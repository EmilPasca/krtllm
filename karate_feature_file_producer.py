# Karate Feature File Producer

import os
import openai
import json
import logging
import time

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s', datefmt='%Y-%m-%d %H:%M:%S')
logger = logging.getLogger()
# Assuming you have the oas_decomposer.py content in a function named decompose_oas
from oas_decomposer import process_openapi_file

# Set the base URL for the LLM
openai.api_base = "http://192.168.1.200:4893/v1"

# Function to generate Karate DSL test scenario using Open LLM
def generate_karate_test_scenario(oas_json):
    # Convert the JSON object to a string and escape double quotes
    oas_json_string = json.dumps(oas_json).replace('"', '\\"')

    # Set up the prompt with the sanitized OAS JSON content
    prompt = f"Generate a detailed Karate DSL test scenario for a any request based on the following OAS specification." \
             f"The scenario should include the endpoint path, request headers, and a JSON body (if required) with " \
             f"all required fields as per the schema. Validate the response to ensure it has the required status code and "\
             f"the response body matches the expected schema. Include dynamic data handling for fields where applicable "\
             f"and ensure that common setup steps are in a Background section. Handle potential error responses gracefully"\
             f" for the following oas specification:\n\"{oas_json_string}\" \n "

    model = "Mistral OpenOrca"
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
    # Replace 'openapi_file.yaml' with the path to your actual OpenAPI file
    start_time = time.time()
    process_openapi_file('input/petstore_lite.yaml')
    decompose_duration = time.time() - start_time
    logger.info(f"Decomposition completed in {decompose_duration:.2f} seconds")

    # Directory where the OAS description files are saved
    api_name = 'Swagger_Petstore_Lite'  # Replace with actual API name used in oas_decomposer.py
    output_dir = f'output/{api_name}'

    # Iterate over each OAS description file and generate Karate DSL test scenarios
    totalOutputedJsonFiles = sum(1 for f in os.listdir(output_dir) if f.endswith('.json'))

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
                logger.info(f"Remaining tests to write {--totalOutputedJsonFiles} out of {totalOutputedJsonFiles}")

            except Exception as e:
                logger.error(f"Error processing {file_name}: {e}", exc_info=True)

    total_duration = time.time() - start_time
    minutes, seconds = divmod(total_duration, 60)
    logger.info(f"Test suite written in {int(minutes)} minutes and {seconds:.2f} seconds")


if __name__ == "__main__":
    main()
