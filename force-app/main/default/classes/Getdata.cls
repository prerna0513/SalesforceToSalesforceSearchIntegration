public with sharing class Getdata {
    public String response {get; set;}
    @AuraEnabled(cacheable=true)
    public static List<accountWrapper> getAccountRecordMethod(String accNameParamInApex) {
        system.debug('accNameKey:::'+accNameParamInApex);
        List<accountWrapper> accDataList = GetAccountUsingRESTAPI.callGetAccount(accNameParamInApex);
        system.debug('accDataList:::'+accDataList);
        return accDataList;
    }
    
   
}