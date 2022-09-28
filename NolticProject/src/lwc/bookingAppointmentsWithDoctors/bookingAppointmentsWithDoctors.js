import {api, LightningElement, track, wire} from 'lwc';
import searchDoctors from '@salesforce/apex/ContactController.searchDoctors';
import getPatients from '@salesforce/apex/ContactController.getAllParticipants';
import EVENT_OBJECT from '@salesforce/schema/Event';
import START_DATE_FIELD from '@salesforce/schema/Event.StartDateTime';
import END_DATE_FIELD from '@salesforce/schema/Event.EndDateTime';
import Duration_FIELD from '@salesforce/schema/Event.DurationInMinutes';
import Activity_FIELD from '@salesforce/schema/Event.ActivityDateTime';
import WhoId_FIELD from '@salesforce/schema/Event.WhoId';
import createEvent from '@salesforce/apex/EventController.createEvent';
//import getEventPicklist from '@salesforce/apex/EventController.getEventPicklist';
import {NavigationMixin} from 'lightning/navigation';
import {ShowToastEvent} from "lightning/platformShowToastEvent";

export default class BookingAppointmentsWithDoctors extends NavigationMixin(LightningElement) {

    searchTerm = '';

    @track startDate = START_DATE_FIELD;
    @track endDate = END_DATE_FIELD;
    @track duration = Duration_FIELD;
    @track activity = Activity_FIELD;
    @track value = WhoId_FIELD;
    @track optionsArray = [];

    columns = {
        StartDate: this.startDate,
        EndDate: this.endDate,
        Duration: this.duration,
        Activity: this.activity
    }

    handleStartDateChange(event) {
        this.columns.StartDate = event.target.value;
    }

    handleEndDateChange(event) {
        this.columns.EndDate = event.target.value;
    }

    handleDurationChange(event) {
        this.columns.Duration = event.target.value;
    }

    handleActivityChange(event) {
        this.columns.Activity = event.target.value;
    }

    handlePatientChange(event) {
        this.value = event.detail.value;
    }

    handleClick() {
        createEvent({ev: this.columns, value: this.value}) // створюю івент, але інпут значення не зберігаються
            .then(result => {
                this.message = result;
                this.error = undefined;
                if (this.message !== undefined) {
                    this.columns.StartDate = '';
                    this.columns.EndDate = '';
                    this.columns.Duration = '';
                    this.columns.Activity = '';
                    console.log('test' + this.columns.StartDate);
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Event created',
                            variant: 'success',
                        }),
                    );
                }
                console.log(JSON.stringify(result));
                console.log('result', this.message);
                console.log('test' + this.columns.StartDate);
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
        console.log('test' + doctorId);
    }
}


