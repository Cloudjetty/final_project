import {LightningElement, track, wire} from 'lwc';
import getDoctors from '@salesforce/apex/ContactController.getAllDoctors';
import getEvents from '@salesforce/apex/EventController.getDoctorEvents';

const columns = [
    {label: 'Start', fieldName: 'StartDateTime'},
    {label: 'End', fieldName: 'EndDateTime'}, //??? потрібно відобразити тільки час
    {label: 'Event', fieldName: 'Subject'}
]
export default class ListEvents extends LightningElement {

    @track value = '';
    @track optionsArray = [];
    @track cardVisible = false;
    @track data = [];
    @track columns = columns;


    get options() {
        return this.optionsArray;
    }

    @wire(getDoctors)
    connectedCallBack() {
        getDoctors()
            .then(response => {
                let arr = [];
                for (let i = 0; i < response.length; i++) {
                    arr.push({label: response[i].Name, value: response[i].Id})
                }
                this.optionsArray = arr;
            })
    }

    handleDoctorChange(event) {
        this.cardVisible = true;
        this.value = event.detail.value;

        getEvents({contactId: this.value})
            .then(result => {
                this.data = result;
            })
    }
}
