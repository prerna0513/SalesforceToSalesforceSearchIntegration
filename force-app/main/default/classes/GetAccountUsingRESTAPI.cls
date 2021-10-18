/*
*
*    Class  : GetAccountUsingRESTAPI
*    Summary : This class is designed to send the request to org 1 for sending the acoounts that are releavnat with the search from the account UI.
*    Return : List of accountwrapper
*/

public class GetAccountUsingRESTAPI {
    

    public class deserializeResponse
    {
        public String id;
        public String access_token;
    }
    
    public static List<accountWrapper> callGetAccount(String accName)
    {
        List<accountWrapper> accDataList = new List<accountWrapper>();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Source_Org/services/apexrest/v1/getAccounts/'+accName);
        req.setMethod('GET');
        system.debug('req:::'+req);
        Http http = new Http();
        HTTPResponse res;
        try{
            res = http.send(req);
            System.debug(res.toString());
            System.debug('STATUS:'+res.getStatus());
            System.debug('STATUS_CODE:'+res.getStatusCode());
            System.debug('Content: ' + res.getBody());
        }
        catch(System.CalloutException ex){
             system.debug('EXCEPTION::'+ex.getMessage());
        }  
        
        String trimmedResponse = res.getBody().unescapeCsv().remove('\\');
        system.debug('@@@RESPONSE@@'+trimmedResponse);
        JSONParser parser = JSON.createParser(res.getBody());
        system.debug('parser:::'+parser);
        List<accountWrapper> accList=new List<accountWrapper>();
        
        system.debug('AccountList@@@@'+(List<accountWrapper>) JSON.deserialize(trimmedResponse,List<accountWrapper>.class));
        accDataList = (List<accountWrapper>) JSON.deserialize(trimmedResponse,List<accountWrapper>.class); 
        return accDataList;
    }
    
    
    
}