/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 11-03-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@IsTest
public with sharing class PublishPlatformEventsCallBackTest {
   

    @IsTest 
    static void testFailedEevnts(){
        Order_Detail__e orderDetail = new Order_Detail__e( 
        Order_Number__c = '0000001',
        Generate_invoice__c= false
        );

        PublishPlatformEventsCallBack cb = new PublishPlatformEventsCallBack();
        EventBus.publish(orderDetail,cb);
        Test.getEventBus().fail();
        List<Task> taskList = [ SELECT Id,Subject,Description FROM TASK where Subject ='Platform Eevnt Publish Failed'];
        System.Assert.areEqual(1,taskList.size(),'Task creation Failed');
    }
     

    @IsTest
     static void testSuccessEevnts(){
        Order_Detail__e orderDetail = new Order_Detail__e( 
        Order_Number__c = '0000001',
        Generate_invoice__c= false
        );

        PublishPlatformEventsCallBack cb = new PublishPlatformEventsCallBack();
        Test.startTest(); 
        EventBus.publish(orderDetail,cb);
        Test.stopTest();     
        // Test.getEventBus().deliver();
        List<Task> taskList = [ SELECT Id,Subject,Description FROM TASK where Subject ='Platform Eevnt Published Successfully'];
        System.Assert.areEqual(1,taskList.size(),'Task creation Successfully ');
    }
}