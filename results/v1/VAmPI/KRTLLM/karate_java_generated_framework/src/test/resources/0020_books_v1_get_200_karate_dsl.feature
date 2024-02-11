Feature: [ScenarioID]-GetAllBooks

Scenario: [ScenarioID]-GetAllBooks
  Given url 'http://localhost:5000/books/v1'
  When method GET
  Then status 200
  And match response.body contains { "Books": [{"book_title": "bookTitle77", "user": "name1"}, {"book_title": "bookTitle85", "user": "name2"}, {"book_title": "bookTitle47", "user": "admin"}]}