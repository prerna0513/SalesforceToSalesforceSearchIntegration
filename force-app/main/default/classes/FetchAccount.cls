/*
*
*    Class  : FetchAccount
*    Summary : This class is designed to fetch the accounts based on the string passed from the org2.
*    Return : List of accountwrapper
*/

@RestResource(urlMapping='/v1/getAccounts/*')
global with sharing class FetchAccount {
    @HttpGet
    global static list<accountWrapper> fetchAccount(){
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        String accname = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        String searchAccStr = '%'+String.escapeSingleQuotes(accname)+'%';
        List<account> listAccount =[Select Id , Name, BillingCountry,  (Select Id From Contacts), (Select Id From Opportunities) from Account WHere Name like : searchAccStr LIMIT 10 ];
        List<accountWrapper> accDataWrapper = new List<accountWrapper>();
        for(Account acc : listAccount){
            accountWrapper accWrapObj = new accountWrapper();
            accWrapObj.accId = acc.Id;
            accWrapObj.accName = acc.Name;
            accWrapObj.country = acc.BillingCountry;
            accWrapObj.contactCount = string.valueof(acc.Contacts.size());
            accWrapObj.oppCount = string.valueof(acc.Opportunities.size());  
            accDataWrapper.add(accWrapObj);          
        }
        system.debug('accDataWrapper::'+accDataWrapper);
        return accDataWrapper ;
    }
    
    
    
    global class accountWrapper{
        public string accId;
        public string accName;
        public string country;
        public string contactCount;
        public string oppCount;
        
        global accountWrapper(){
            this.accName = '';
            this.country = '';
            this.contactCount = '';
            this.oppCount = '';
            this.accId = '';
            
        }
    
    }
}