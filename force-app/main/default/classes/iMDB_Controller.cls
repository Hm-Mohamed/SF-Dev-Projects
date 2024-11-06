/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 10-13-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
/**
 * @description       : Fetches movie details from an external API.
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 10-13-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class iMDB_Controller {

  @AuraEnabled(cacheable=true)
  public static String getMovies(String searchText) {
      // Initialize return variable
      String result;

      // Create an HTTP request
      HttpRequest request = new HttpRequest();
      //request.setEndpoint('https://api.collectapi.com/imdb/imdbSearchByName?query=inception');
      request.setMethod('GET');

      // Set the authorization header
      //request.setHeader('authorization', 'apikey 28XdkNt2zU9Q4mWhrSEQ7t:3v8JAl2qazmWvzmw0JWO5x');
      // named credentials 
      request.setEndpoint('callout:IMDB/imdb/imdbSearchByName?query=inception');
      // Create an HTTP object to send the request
      Http http = new Http();

      try {
          // Send the request and get the response
          HttpResponse response = http.send(request);

          // Handle the response
          if (response.getStatusCode() == 200) {
              // Return the response body
              result = response.getBody();
              System.debug('Response Body: ' + result);
          } else {
              // Handle unsuccessful response and set error message
              result = 'HTTP Error: ' + response.getStatusCode() + ' ' + response.getStatus();
              System.debug(result);
          }
      } catch (Exception e) {
          // Handle exceptions and set exception message
          result = 'Exception: ' + e.getMessage();
          System.debug(result);
      }

      // Return the result
      return result;
  }
}