## TODO in LM Studio support in progress

import requests
import json

# The URL of the chat model API
url = 'http://localhost:1234/v1/chat/completions'

# The path to the OAS JSON file you want to use
oas_json_file_path = 'output/Swagger_Petstore/0002_pet_post_200.json'

# Load your OAS JSON file and convert it to a string
with open(oas_json_file_path, 'r') as file:
    oas_content = file.read()

# Prepare the custom instruction with the OAS content
instruction = {
    "role": "user",
    "content": "### Instruction: Generate a Karate DSL test scenario for the following OAS specification:\n" + oas_content
}

# Set up the request body
request_body = {
    "messages": [instruction],
    "stop": ["### Instruction:"],
    "temperature": 0.7,
    "max_tokens": 2048,  # Set a reasonable max token limit
    "stream": False
}

# Set up the headers
headers = {
    'Content-Type': 'application/json'
}

# Make the POST request to the chat model API
response = requests.post(url, headers=headers, json=request_body)

# Check if the request was successful
if response.status_code == 200:
    # Print out the response
    print(response.json())
else:
    print(f'Error: {response.status_code}')
    print(response.text)
