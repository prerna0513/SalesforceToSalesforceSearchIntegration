import { LightningElement ,api, wire, track} from 'lwc';
import getAccountData from '@salesforce/apex/Getdata.getAccountRecordMethod';

const columns = [
    { label: 'Account Name', fieldName: 'accName' },
    { label: 'Country', fieldName: 'country'},
    { label: 'Related Contacts', fieldName: 'contactCount' },
    { label: 'Related Opportunities', fieldName: 'oppCount'},
];


export default class SearchAccountsFromSource extends LightningElement {
    data = [];
    columns = columns;
    @api accName;
    @track accountRecord;
    @track error;
    handleChange(event){
        const userInput = event.target.value;
        this.accName= userInput;
    }

    @wire(getAccountData,{ accNameParamInApex: '$accName'}) 
    accountsData({ error, data }) {
        console.log('data::',data);
        if (data != null) {
            console.log('data 2::',data);
            this.accountRecord = data;
            this.data = data;
            console.log('ACCC::',this.accountRecord);
        } else if (error) {
            console.log('Error block');
            this.error = error;
            this.accountRecord = undefined;
        }

    }
}