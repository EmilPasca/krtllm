Feature: BKR-002-BookRetrievalAPI

  Scenario: BKR-002-BookRetrievalAPI
    Given url 'http://localhost:5000/books/v1/{book_title}'
    And request body {}
    When method GET