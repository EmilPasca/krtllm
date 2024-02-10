Feature: Retrieve Book Information
Background:
  * URL path: /books/v1/{book_title}
  * Request headers: None
Scenario: retrieve-book-info-successfully
  Given url '/books/v1/{book_title}'
  And request body {}
  When method GET
  Then status 200
    And match response {book_title, owner, secret}
      * book_title: "bookTitle77"
      * owner: "name1"
      * secret: "secret for bookTitle77"