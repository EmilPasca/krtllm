Feature: BKR-001-BookRetrievalAPI
Scenario: BKR-001-BookRetrievalAPI
  Given url 'http://localhost:5000/books/v1/{book_title}'
  When method GET
  Then status 200
  And match response.body ==
  """
  { "status": "fail", "message": "Invalid Token" }
  """