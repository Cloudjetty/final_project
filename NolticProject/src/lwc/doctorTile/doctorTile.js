import {LightningElement, api} from 'lwc';
import ursusResources from '@salesforce/resourceUrl/doctors';

export default class DoctorTile extends LightningElement {

    @api doctor;

    appResources = {
        doctorSilhouette: `${ursusResources}/doctor.png`,
    };

    handleOpenRecordClick() {
        const selectEvent = new CustomEvent('doctorview', {
            detail: this.doctor.Id
        });
        this.dispatchEvent(selectEvent);
    }
}

