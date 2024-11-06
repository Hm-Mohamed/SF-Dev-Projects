/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 11-03-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class PublishPlatformEvents {
   

public static void publishPlatformEventTest(){
    List<Order_Detail__e> orderDetailListEvent = new List<Order_Detail__e>();
    orderDetailListEvent.add(
    new Order_Detail__e(
        Order_Number__c = '0000001',
        Generate_invoice__c= false
        )
    );
    
    orderDetailListEvent.add(
    new Order_Detail__e(
        Order_Number__c = '0000001',
        Generate_invoice__c= true
        )
    );
    
    orderDetailListEvent.add(
    new Order_Detail__e(
        Order_Number__c = '0000001',
        Generate_invoice__c= false
        )
    );
    
    PublishPlatformEventsCallBack callbackInstance = new PublishPlatformEventsCallBack();
   List<Database.SaveResult> srList = EventBus.publish(orderDetailListEvent,callbackInstance);

   for (Database.SaveResult srItem : srList ) {
    if(srItem.isSuccess()){
        System.debug('Platform Event Published successfully');
    }else {
        List<Database.Error> errList = srItem.getErrors();
        for (Database.Error errorDetail: errList ) {
            System.debug('Error Details  ' + errorDetail.getMessage());
        }
    }
    
   }

}

    
}