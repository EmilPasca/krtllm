Feature: API Security Testing Scenario
Background:
  * URL path: /v3.1/name/{countryName}
  * Request headers: None

Scenario: CheckSQLInjection-1
  Given url /v3.1/name/{countryName}
  And request body {}
  When method GET
  Then status 200
  And match response { "data": [{"full_name": "John Doe", "country_name": "{countryName}"}] }

Scenario: CheckBrokenAuthentication-1
  Given url /v3.1/name/{countryName}
  And request body {}
  When method GET
  Then status 200
  And match response { "data": [{"full_name": "John Doe", "country_name": "{countryName}"}] }

Scenario: CheckCSRF-1
  Given url /v3.1/name/{countryName}
  And request body {}
  When method GET
  Then status 200
  And match response { "data": [{"full_name": "John Doe", "country_name": "{countryName}"}] }

Scenario: CheckXSS-1
  Given url /v3.1/name/{countryName}
  And request body {}
  When method GET
  Then status 200
  And match response { "data": [{"full_name": "John Doe", "country_name": "{countryName}"}] }

Scenario: CheckInsecureDirectObjectReference-1
  Given url /v3.1/name/{countryName}
  And request body {}
  When method GET
  Then status 200
  And match response { "data": [{"full_name": "John Doe", "country_name": "{countryName}"}] }

Scenario: CheckInformationExposure-1
  Given url /v3.1/name/{countryName}
  And request body {}
  When method GET
  Then status 200
  And match response { "data": [{"full_name": "John Doe", "country_name": "{countryName}"}] }

Scenario: CheckXMLExternalEntity-1
  Given url /v3.1/name/{countryName}
  And request body {}
  When method GET
  Then status 200
  And match response { "data": [{"full_name": "John Doe", "country_name": "{countryName}"}] }