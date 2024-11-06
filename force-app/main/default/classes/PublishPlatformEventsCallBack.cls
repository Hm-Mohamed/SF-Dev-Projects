/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 11-03-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class PublishPlatformEventsCallBack implements EventBus.EventPublishSuccessCallback,EventBus.EventPublishFailureCallback {
   
 
public void onSuccess (EventBus.SuccessResult result){

List<String> eventUUIDList = result.getEventUuids();
insertTask(eventUUIDList,true);
}

public void onFailure (EventBus.FailureResult result){
List<String> eventUUIDList = result.getEventUuids();
insertTask(eventUUIDList, false);
}


public void insertTask(List<String> eventUUIDList, Boolean isSuccess){

    String eventUUIDString = '';
    for (String eventUUID : eventUUIDList ) {
        eventUUIDString = eventUUIDString + eventUUID + '  ';
    }

   Task taskDetail = new Task();

    if( isSuccess == true ){ 
        taskDetail.Subject = 'Platform Eevnt Published Successfully';
        taskDetail.Description ='Total Platform Events Publish ' + eventUUIDList.size() + ' List Of Eevnt UUID Published ' + eventUUIDString;
    }else {
        taskDetail.Subject = 'Platform Eevnt Publish Failed';
        taskDetail.Description ='Total Platform Events Publish' + eventUUIDList.size() + ' List of Eevnt UUID Published ' + eventUUIDString;
    }
    taskDetail.ActivityDate = Date.today();
    User userDetail;
    
    // Vérifiez les permissions d'accès à l'objet User
    if (Schema.sObjectType.User.isAccessible()) {
        userDetail = [
            SELECT Id 
            FROM User 
            WHERE Username = 'hamitouchemohamed22@sandboxpracrice.com'
        ];
        taskDetail.OwnerId = userDetail.Id;
    } else {
        // Gestion du cas où l'utilisateur n'a pas la permission
        System.debug('L\'utilisateur actuel n\'a pas la permission d\'accéder aux informations utilisateur.');
    }
    try {
        // Vérifiez les permissions pour l'insertion de l'objet Task
        if (Schema.sObjectType.Task.isCreateable()) {
            insert taskDetail;
            System.debug('Task successfully inserted.');
        } else {
            System.debug('Current user does not have permission to insert Task records.');
        }
    } catch (Exception ex) {
        System.debug('Task insertion failed: ' + ex.getMessage());
        // Optionnel : Enregistrez l'erreur ou prenez d'autres mesures
    }
    
}
}