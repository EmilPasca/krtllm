Feature: Add Book
    Scenario: add-book-successfully
        Given url 'http://localhost:5000/books/v1'
         And request body { "book_title": "book99", "secret": "pass1secret" }
         When method POST
         Then status 200

         And match response.body == '{"message":"Book has been added.", "status":"success"}'