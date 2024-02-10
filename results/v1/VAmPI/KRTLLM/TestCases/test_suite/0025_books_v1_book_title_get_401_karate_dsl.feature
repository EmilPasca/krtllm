Feature: Book Retrieval API Security Testing
Background:
  * URL path: /books/v1/{book_title}
  * Request headers: { "Content-Type": "application/json", "Authorization": "Bearer token" }
  * Request body (if any): {}

Scenario: BKR-001-BookRetrievalAPI
  Given url /books/v1/{book_title}
  And headers { "Content-Type": "application/json", "Authorization": "Bearer token" }
  When method GET
  Then status 200

  And match response.body == { "status": "fail", "message": "Invalid Token" } when status code is 401