{
  "feature": "[API Security Testing]",
  "scenario": "[Test API for security vulnerabilities including SQL injection, Broken Authentication, CSRF and others]",
  "steps": [
    "* def url = 'http://api.example.com/users/v1/register'",
    "* def headers = { 'Content-Type': 'application/json' }",
    "* def requestBody = { username: 'user', password: 'password', email: 'user@example.com' },",
    "when method post url",
    "then status 200",
    "and match response contains 'User registered successfully.',",
    "# Explanation: This scenario tests the API endpoint for security vulnerabilities by ensuring the application sanitizes and validates input data, particularly in fields like username, password, and email that could be exploited."
  }}, [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "http://api.example.com/oauth/refresh", "method": "POST", "summary": "Refreshes the access token with a refresh token and client ID/secret.", "parameters": ["refresh_token", "client_id", "client_secret"]}
  }}, [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "http://api.example.com/oauth/validate", "method": "GET", "summary": "Validates an access token.", "parameters": ["access_token"]}
  }}, [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "http://api.example.com/users/{userId}/promote", "method": "POST", "summary": "Promotes a user to admin status.", "parameters": ["userId"]}
  }}, [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "http://api.example.com/settings/{userId}/privacy", "method": "POST", "summary": "Updates user's privacy settings.", "parameters": ["userId"]}
  }}, [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "http://api.example.com/messages/{conversationId}/send", "method": "POST", "summary": "Sends a message in a conversation.", "parameters": ["conversationId"]}
  }}, [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "http://api.example.com/messages/{messageId}/delete", "method": "DELETE", "summary": "Deletes a message from a conversation.", "parameters": ["messageId"]}
  }}, [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "http://api.example.com/messages/{conversationId}/receive", "method": "GET", "summary": "Receives messages from a conversation.", "parameters": ["conversationId"]}
  }}, [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "http://api.example.com/messages/{messageId}/like", "method": "POST", "summary": "Likes a message.", "parameters": ["messageId"]}
  }}, [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "http://api.example.com/messages/{conversationId}/dislike", "method": "POST", "summary": "Dislikes a message.", "parameters": ["conversationId"]}
  }}, [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "http://api.example.com/messages/{messageId}/flag", "method": "POST", "summary": "Flags a message as inappropriate.", "parameters": ["messageId"]}
  }}, [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path": "http://api.example.com/messages/{conversationId}/unflag", "method": "POST", "summary": "Unflags a message from being inappropriate.", "parameters": ["conversationId"]}
  }}, [question]: Write me a security test case using karate DSL scenario for the following API Spec: {"path":