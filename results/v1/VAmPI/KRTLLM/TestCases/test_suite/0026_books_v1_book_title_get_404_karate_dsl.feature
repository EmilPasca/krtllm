Feature: API Security Testing Scenario

Background:
  * URL path: /books/v1/{book_title}
  * Request headers: None

Scenario: [ScenarioID]-[Scenario Name]
  Given url '/books/v1/{book_title}'
  And request body {}
  When method GET