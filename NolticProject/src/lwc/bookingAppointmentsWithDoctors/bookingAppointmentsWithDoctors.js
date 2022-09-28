import {api, LightningElement, track, wire} from 'lwc';
import searchDoctors from '@salesforce/apex/ContactController.searchDoctors';
import getPatients from '@salesforce/apex/ContactController.getAllParticipants';
import createEvent from '@salesforce/apex/EventController.createEvent';
//import getEventPicklist from '@salesforce/apex/EventController.getEventPicklist';
import {NavigationMixin} from 'lightning/navigation';
import {ShowToastEvent} from "lightning/platformShowToastEvent";

export default class BookingAppointmentsWithDoctors extends NavigationMixin(LightningElement) {

    searchTerm = '';

    @track duration;
    @track activity;
    @track whoId;
    @track optionsArray = [];

    handleDurationChange(event) {
        this.duration = event.target.value;
    }

    handleActivityChange(event) {
        this.activity = event.target.value;
    }

    handlePatientChange(event) {
        this.whoId = event.detail.value;
    }

    handleClick() {
        createEvent({
            activity: this.activity,
            duration: this.duration,
            whoId: this.whoId
        })
            .then(result => {
                console.log('test');
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Event created',
                        variant: 'success',
                    }),
                );
                eval("$A.get('e.force:refreshView').fire();");
                console.log('test 2');
                console.log(JSON.stringify(result));
            })
            .catch(error => {
                this.message = undefined;
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
                console.log('error', JSON.stringify(this.error));
            });
    }

    get options() {
        return this.optionsArray;
    }

    @wire(searchDoctors, {searchTerm: '$searchTerm'})
    doctors;

    @wire(getPatients)
    connectedCallBack() {
        getPatients()
            .then(r => {
                let arr = [];
                for (var i = 0; i < r.length; i++) {
                    arr.push({label: r[i].Name, value: r[i].Id})
                }
                this.optionsArray = arr;
            })
    }

    handleSearchTermChange(event) {
        window.clearTimeout(this.delayTimeout);
        const searchTerm = event.target.value;
        this.delayTimeout = setTimeout(() => {
            this.searchTerm = searchTerm;
        }, 300);
    }

    get hasResults() {
        return (this.doctors.data.length > 0);
    }

    handleDoctorView(event) {
        const doctorId = event.detail;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: doctorId,
                objectApiName: 'Contact',
                actionName: 'view',
            },
        });
        console.log('test ' + doctorId);
    }
}


