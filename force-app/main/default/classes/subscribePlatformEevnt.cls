/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 11-03-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class subscribePlatformEevnt {
   
    public static void afterInsert(List<Order_Detail__e> orderDetailPlatformEventList){


    List<Task> taskList = new List<Task>();
    User adminUser = [SELECT id  FROM user WHERE username ='hamitouchemohamed22@sandboxpracrice.com'];
      
     for( Order_Detail__e orderDetail : orderDetailPlatformEventList ) {
        
        Task taskDetail = new Task();
        taskDetail.Subject = 'Platform Event Subscribe Using Trigger';
        taskDetail.Description = orderDetail.Order_Number__c; 
        taskDetail.OwnerId = adminUser.Id;
        taskDetail.ActivityDate = date.today();
        taskList.add(taskDetail);
     }
      
     if(!taskList.isEmpty()){ 
         try {
        if(Schema.sObjectType.Task.isCreateable()){ 
            insert taskList;
            System.debug('Task successfully inserted.');
         }else {
            System.debug('Current user does not have permission to insert Task records.');

         }
         } catch (Exception ex) {
            System.debug('Task creaion failed : ' + ex.getMessage());
         }
      }
    }
    

}