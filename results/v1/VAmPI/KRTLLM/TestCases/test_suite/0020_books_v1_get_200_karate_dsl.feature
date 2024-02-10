Feature: API Security Testing Scenario
Background:
  * URL path: /books/v1
  * Request headers: Authorization: Bearer <token>
Scenario: [ScenarioID]-GetAllBooks
  Given url '/books/v1'
  And request body {}
  When method GET
  Then status 200
  And match response.body == { "Books": [{"book_title": "bookTitle77", "user": "name1"}, {"book_title": "bookTitle85", "user": "name2"}, {"book_title": "bookTitle47", "user": "admin"}]}