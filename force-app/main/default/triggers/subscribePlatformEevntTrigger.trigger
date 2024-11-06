/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 11-03-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger subscribePlatformEevntTrigger on Order_Detail__e (after insert) {

     if(trigger.isAfter && trigger.isInsert){
        subscribePlatformEevnt.afterInsert(trigger.new);

        
     }
}