Feature: Add Book with Secret Content
Background:
  * URL path: /books/v1
  * Request headers: Authorization: Bearer <valid_token>
Scenario: add-book-with-secret-content
  Given url '/books/v1'
  And request body { "book_title": "book99", "secret": "pass1secret" }
  When method POST
  Then status 200