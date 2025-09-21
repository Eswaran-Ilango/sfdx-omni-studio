import { LightningElement, api } from 'lwc';

export default class DisplayAccountsListFromOSToLWC extends LightningElement {
    @api allData;
    listCountries = [];
    setCountries;

    connnectedCallback() {
        //this.allData = JSON.parse(SON.stringify(this.omniJsonData));
        console.log('this.allData', this.allData);
        this.listCountries = this.allData?.Country;
        this.setCountries = new Set(this.listCountries);
    }
}