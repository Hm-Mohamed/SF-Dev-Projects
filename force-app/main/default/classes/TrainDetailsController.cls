/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 11-06-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class TrainDetailsController {

@AuraEnabled
public static TrainDetails getTrainDetails(String trainNumber){



     //Validé l'entré 
     if(String.isEmpty(trainNumber)){
        TrainDetails errorDetails = new TrainDetails();
        errorDetails.message = 'Numero de train requis';
        return errorDetails;
     }
  

     TrainDetails trainD = new TrainDetails();
     try {
        HttpResponse resp = makeApiCall('https://rappid.in/apis/train.php?train_no='+trainNumber);

        if(resp.getStatusCode() == 200){
            trainD = (TrainDetails)JSON.deserialize(resp.getBody(), TrainDetails.class);
        }else {
            trainD.message = 'Erreur: ' +resp.getStatus() + ' - ' + resp.getStatusCode();
        }
     } catch (Exception e) {
        trainD.message = 'Erreur lors de la requete : ' +e.getMessage();
        System.debug('Exception :'+e);
     }
      return trainD;

     }

     private static HttpResponse makeApiCall(String endpoint){
        Http http = new Http();
        HttpRequest req =new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        req.setTimeout(2000);  // Timeout de 2 secondes
        return http.send(req);

       // System.debug(response, ': ' +resp.getBody());    

     }

public class TrainDetails{
    @AuraEnabled public boolean success{get; set;}
    @AuraEnabled public String train_name{get; set;}
    @AuraEnabled public String message{get; set;}
    @AuraEnabled public String updated_time{get; set;}
    @AuraEnabled public List<Data> data {get;set;}


}

public class Data {
    @AuraEnabled  public boolean is_current_station{get;set;}
    @AuraEnabled  public String station_name{get;set;}
    @AuraEnabled  public String distance{get;set;}
    @AuraEnabled  public String timing{get;set;}
    @AuraEnabled  public String delay{get;set;}
    @AuraEnabled  public String platform{get;set;}
    @AuraEnabled  public String halt{get;set;}
}
}
    



