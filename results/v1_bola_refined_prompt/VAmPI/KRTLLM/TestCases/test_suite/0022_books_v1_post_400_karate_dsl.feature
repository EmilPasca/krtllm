{
  "feature": "[Feature Name] for BOLA and Auth Vulnerabilities",
  "scenario": "[ScenarioID]-[Scenario Name]",
  "steps": [
    "* url 'http://localhost:5000'",
    "* def generateToken = function() { return java.util.UUID.randomUUID().toString() },",
    "* def userRole = 'admin'",
    "* def token = generateToken()"
  ]} [
    "path": "/books/v1",
    "method": "POST",
    "summary": "Adds a new book with title and secret content only available to the user who added it.",
    "parameters": ["book_title", "secret"],
    "requestBody": {"book_title": "book99", "secret": "pass1secret"},
    "header": { Authorization: `Bearer ${token}` },
    "summary": "Ensures the endpoint correctly handles BOLA and authentication flaws by validating token and user role for book addition.",
    "responses": ["400", "401", "403"],
    "match response contains 'Book added successfully.', if status 200",
    "match response contains 'Access denied or insufficient permissions.', if status 403",
    "match response contains 'Invalid token or user role.', if status 401"
  ]} [
    "path": "/books/v1",
    "method": "POST",
    "summary": "Attempts to add a book by an unauthorized user.",
    "parameters": ["book_title", "secret"],
    "requestBody": {"book_title": "book100", "secret": "pass2secret"},
    "header": { Authorization: `Bearer ${generateToken()}` },
    "summary": "Tests the endpoint's security by ensuring it only allows users with 'admin' roles to add books.",
    "responses": ["400", "401", "403"],
    "match response contains 'Access denied or insufficient permissions.', if status 403",
    "match response contains 'Invalid token or user role.', if status 401"
  ]} [
    "path": "/books/v1",
    "method": "POST",
    "summary": "Attempts to add a book by an unauthorized user with a valid token from another user.",
    "parameters": ["book_title", "secret"],
    "requestBody": {"book_title": "book101", "secret": "pass3secret"},
    "header": { Authorization: `Bearer ${generateToken('user')}` },
    "summary": "Ensure the endpoint securely handles token-based authentication, allowing actions only as permitted by the token owner's role.",
    "responses": ["400", "401", "403"],
    "match response contains 'Access denied or insufficient permissions.', if status 403",
    "match response contains 'Invalid token or user role.', if status 401"
  ]} [
    "path": "/books/v1",
    "method": "POST",
    "summary": "Attempts to add a book with an empty title.",
    "parameters": ["book_title", "secret"],
    "requestBody": {"book_title": "", "secret": "pass4secret"},
    "header": { Authorization: `Bearer ${token}` },
    "summary": "Ensure the endpoint properly handles BOLA by rejecting requests with insufficient data.",
    "responses": ["400"],
    "match response contains 'Invalid request data.', if status 400"
  ]} [
    "path": "/books/v1",
    "method": "POST",
    "summary": "Attempts to add a book with an already existing title.",
    "parameters": ["book_title", "secret"],
    "requestBody": {"book_title": "existingTitle", "secret": "pass5secret"},
    "header": { Authorization: `Bearer ${token}` },
    "summary": "Ensure the endpoint correctly handles BOLA by rejecting duplicate titles.",
    "responses": ["400"],
    "match response contains 'Book already exists!', if status 400"
  ]} [
    "path": "/books/v1",
    "