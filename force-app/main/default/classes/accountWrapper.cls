global class accountWrapper{
        @AuraEnabled
        public string accName {get; set;}
        @AuraEnabled
        public string country {get; set;}
        @AuraEnabled
        public string contactCount {get; set;}
        @AuraEnabled
        public string oppCount {get; set;}
        @AuraEnabled
        public string accId {get; set;}
        
        public accountWrapper(){
            this.accName = '';
            this.country = '';
            this.contactCount = '';
            this.oppCount = '';
            this.accId = '';
        }
    
    }