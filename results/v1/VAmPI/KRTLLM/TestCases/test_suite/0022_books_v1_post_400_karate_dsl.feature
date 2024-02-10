Feature: Add Book
Background:
  * URL path: /books/v1
  * Request headers: { "Content-Type": "application/json" }
Scenario: add_book_01-AddBookWithInvalidTitle
  Given url '/books/v1'
  And request body '{"book_title":"", "secret":"pass1secret"}'
  When method POST
  Then status 400
  And match response { "status": "fail", "message": "Book Already exists!" }