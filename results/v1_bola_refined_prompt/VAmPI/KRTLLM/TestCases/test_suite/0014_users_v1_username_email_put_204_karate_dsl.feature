```karate
// Define the OpenAPI Spec for the endpoint
const openApiSpec = {
  "path": "/users/v1/{username}/email",
  "method": "PUT",
  "responses": {"204": {"description": "Sucessfully updated user email", "content": {}}, "403": {"description": "User does not have permission to update the email", "content": {}}},
  "requestBody": {"description": "field to update", "content": {"application/json": {"schema": {"type": "object", "properties": {"email": {"type": "string", "example": "mail3@mail.com"}}}}}, "required": true},
  "parameters": [{"name": "username", "in": "path", "description": "username to update email", "required": true, "schema": {"type": "string", "example": "name1"}}]}" [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "/users/v1/{userId}/role", "method": "POST", "responses": {"200": {"description": "User role updated successfully", "content": {}}}, "requestBody": {"description": "field to update user role", "content": {"application/json": {"schema": {"type": "object", "properties": {"userId": {"type": "string", "example": "user123"}, "role": {"type": "string", "example": "admin"}}}}}, "required": true}, "parameters": [{"name": "userId", "in": "path", "description": "UserId to update role", "required": true, "schema": {"type": "string", "example": "user123"}}]}" [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "/auth/validateToken", "method": "GET", "responses": {"200": {"description": "Token is valid", "content": {}}}, "requestParams": ["token"], "parameters": [{"name": "token", "in": "query", "description": "Authentication token to validate", "required": true, "schema": {"type": "string", "example": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NSIsImV4cCI6MTUxNjIzOTAyMH0."}}} [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "/user/profile/{userId}/follow", "method": "POST", "responses": {"204": {"description": "User followed successfully", "content": {}}, "403": {"description": "User does not have permission to follow", "content": {}}}, "requestBody": {"description": "field to follow a user", "content": {"application/json": {"schema": {"type": "object", "properties": {"userIdToFollow": {"type": "string", "example": "user4"}, "followedByUserId": {"type": "string", "example": "user3"}}}}}, "required": true}, "parameters": [{"name": "userIdToFollow", "in": "path", "description": "UserId of the user to follow", "required": true, "schema": {"type": "string", "example": "user4"}}]}" [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "/settings/profile/{userId}/privacy", "method": "POST", "responses": {"204": {"description": "Profile privacy settings updated successfully", "content": {}}, "403": {"description": "User does not have permission to update privacy settings", "content": {}}}, "requestBody": {"description": "field to update profile privacy settings", "content": {"application/json": {"schema": {"type": "object", "properties": {"userId": {"type": "string", "example": "user14"}, "privacySettings": {"type": "boolean", "example": true}}}}}, "required": true}, "parameters": [{"name": "userId", "in": "path", "description": "UserId to update privacy settings", "required": true, "schema": {"type": "string", "example": "user14"}}]}" [question]: Write me a security test case using karate