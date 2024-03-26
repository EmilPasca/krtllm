{
  "feature": "[Feature Name] for BOLA and Auth Vulnerabilities",
  "scenario": "[ScenarioID]-[Scenario Name]",
  "steps": [
    "url 'http://localhost:5000'",
    "* def generateToken = function() { return java.util.UUID.randomUUID().toString() },",
    "* def userRole = 'admin';",
    "* def token = generateToken();"
  ]} [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "/oauth/refresh", "method": "POST", "responses": {"401": {"description": "Invalid refresh_token or client_id.", "content": {"application/json": {"schema": {"type": "object", "properties": {"status": {"type": "string", "enum": ["fail"], "example": "fail"}, "message": {"type": "string", "example": "Invalid refresh_token or client_id."}}}}}, "requestBody": {"description": "Refreshes the access token with a valid refresh_token and client_id.", "content": {"application/json": {"schema": {"type": "object", "properties": {"refresh_token": {"type": "string"}, "client_id": {"type": "string"}}}}}, "parameters": []}"