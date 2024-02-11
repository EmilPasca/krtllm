Feature: Retrieve Book Information

  Scenario: retrieve-book-info-successfully
    Given url 'http://localhost:5000/books/v1/bookTitle77'
    When method GET
    Then status 200
    And match response ==
    """
    {
    book_title: "bookTitle77",
    owner: "name1",
    secret: "secret for bookTitle77"
    }
    """