import yaml
import json
import os
import re

def load_yaml(file_path):
    with open(file_path, 'r') as file:
        return yaml.safe_load(file)

def save_json(data, file_name, api_name):
    output_dir = f'output/{api_name}'
    os.makedirs(output_dir, exist_ok=True)  # Create directory if it doesn't exist
    with open(os.path.join(output_dir, file_name), 'w') as file:
        json.dump(data, file, indent=2)

def resolve_ref(ref, openapi_data):
    parts = ref.replace('#/', '').split('/')
    schema = openapi_data
    for part in parts:
        schema = schema.get(part)
    return schema

def find_and_resolve_refs(obj, openapi_data):
    if isinstance(obj, dict):
        if '$ref' in obj:
            ref_path = obj['$ref']
            return resolve_ref(ref_path, openapi_data)
        else:
            for key, value in obj.items():
                obj[key] = find_and_resolve_refs(value, openapi_data)
    elif isinstance(obj, list):
        for i, item in enumerate(obj):
            obj[i] = find_and_resolve_refs(item, openapi_data)
    return obj

def process_openapi_file(openapi_file_path):
    openapi_data = load_yaml(openapi_file_path)
    paths = openapi_data['paths']
    api_name = openapi_data.get('info', {}).get('title', 'api').replace(' ', '_')
    id_counter = 1

    for path, methods in paths.items():
        for method, spec in methods.items():
            # Resolve $ref for the entire spec
            spec_resolved = find_and_resolve_refs(spec, openapi_data)

            for status_code, response in spec.get('responses', {}).items():
                # Generate the ID prefix
                id_prefix = str(id_counter).zfill(4)
                id_counter += 1

                file_name_parts = [
                    id_prefix,
                    path.strip('/').replace('/', '_'),
                    method,
                    status_code
                ]

                file_name = '_'.join(file_name_parts) + '.json'
                file_name = re.sub(r'[^a-zA-Z0-9_.]', '', file_name)

                # Construct the individual method file data
                method_data = {
                    'path': path,
                    'method': method.upper(),
                    'responses': {status_code: find_and_resolve_refs(response, openapi_data)},
                    'requestBody': find_and_resolve_refs(spec.get('requestBody', {}), openapi_data),
                    'parameters': find_and_resolve_refs(spec.get('parameters', []), openapi_data)
                }

                # Save the method description in a separate file
                save_json(method_data, file_name, api_name)

# Replace 'openapi_file.yaml' with the path to your actual OpenAPI file
process_openapi_file('input/petstore.yaml')
