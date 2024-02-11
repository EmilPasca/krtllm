Feature: Add Book with Secret Content

  Scenario: add-book-with-secret-content
    Given url 'http://localhost:5000/books/v1'
    And request body
    """
    { "book_title": "book99", "secret": "pass1secret" }
    """
    When method POST
    Then status 200