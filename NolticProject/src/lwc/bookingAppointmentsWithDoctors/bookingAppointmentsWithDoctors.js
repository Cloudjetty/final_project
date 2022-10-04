import {LightningElement, track, wire} from 'lwc';
import searchDoctors from '@salesforce/apex/ContactController.searchDoctors';
import getPatients from '@salesforce/apex/ContactController.getAllPatients';
import getDoctors from '@salesforce/apex/ContactController.getDoctors';
import createEvent from '@salesforce/apex/EventController.createEvent';
import {getPicklistValues, getObjectInfo} from 'lightning/uiObjectInfoApi';
import Specialization_FIELD from '@salesforce/schema/Contact.Specialization__c';
import {NavigationMixin} from 'lightning/navigation';
import {ShowToastEvent} from "lightning/platformShowToastEvent";

export default class BookingAppointmentsWithDoctors extends NavigationMixin(LightningElement) {

    searchTerm = '';

    @track duration;
    @track activity;
    @track whoId;
    @track patient;
    @track picklistValue = '';
    @track optionsArrayPatients = [];
    @track optionsArrayDoctors = [];

    @wire(searchDoctors, {searchTerm: '$searchTerm'})
    doctors;

    @wire(getPatients)
    connectedCallBack() {
        getPatients()
            .then(r => {
                this.optionsArrayPatients = [];
                for (let i = 0; i < r.length; i++) {
                    this.optionsArrayPatients.push({label: r[i].Name, value: r[i].Id})
                }
            })
    }

    @wire(getPicklistValues, {recordTypeId: '012000000000000AAA', fieldApiName: Specialization_FIELD})
    specializationPickList;

    handleSpecializationChange(event) {
        this.picklistValue = event.target.value;
        this.connectedCall();
    }

    @wire(getDoctors)
    connectedCall() {
        getDoctors({specialization: this.picklistValue})
            .then(r => {
                this.optionsArrayDoctors = [];
                for (let i = 0; i < r.length; i++) {
                    this.optionsArrayDoctors.push({label: r[i].Name, value: r[i].Id})
                }
            })
    }

    handleDoctorChange(event) {
        this.whoId = event.detail.value;
    }

    handlePatientChange(event) {
        this.patient = event.detail.value;
    }

    handleDurationChange(event) {
        this.duration = event.target.value;
    }

    handleActivityChange(event) {
        this.activity = event.target.value;
    }

    handleClick() {
        createEvent({
            activity: this.activity,
            duration: this.duration,
            whoId: this.whoId,
            patientId: this.patient,
            special: this.picklistValue
        })
            .then(result => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Event created',
                        variant: 'success',
                    }),
                );
                eval("$A.get('e.force:refreshView').fire();");
            })
            .catch(error => {
                this.message = undefined;
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Please choose another time.',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
    }

    get options() {
        return this.optionsArrayPatients;
    }

    get options2() {
        return this.optionsArrayDoctors;
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
    }
}


