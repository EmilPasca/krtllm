Feature: Add Book
    Background:
        * URL path: /books/v1
        * Request headers: {} (No specific header required)
    Scenario: add-book-successfully
         Given url '/books/v1'
         And request body { "book_title": "book99", "secret": "pass1secret" }
         When method POST
         Then status 200

         And match response.body == '{"message":"Book has been added.", "status":"success"}'