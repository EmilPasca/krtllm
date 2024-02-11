Feature: Add Book

Scenario: add_book_01-AddBookWithInvalidTitle
  Given url 'http://localhost:5000/books/v1'
  And request body '{"book_title":"", "secret":"pass1secret"}'
  When method POST
  Then status 400
  And match response { "status": "fail", "message": "Book Already exists!" }