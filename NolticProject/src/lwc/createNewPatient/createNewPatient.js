import {LightningElement, track} from 'lwc';
import FNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LNAME_FIELD from '@salesforce/schema/Contact.LastName';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import EMAIL_FIELD  from '@salesforce/schema/Contact.Email';
import insertContact from '@salesforce/apex/ContactController.insertPatient';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreateNewPatient extends LightningElement {

    @track fname = FNAME_FIELD;
    @track lname = LNAME_FIELD;
    @track phone = PHONE_FIELD;
    @track email = EMAIL_FIELD;

    rec = {
        FNAME:this.fname,
        LNAME:this.lname,
        Phone:this.phone,
        EMAIL:this.email,
    }


    handlefNameChange(event) {
        this.rec.FNAME = event.target.value;
        window.console.log("FNAME", this.rec.FNAME);
    }

    handlelnameChange(event) {
        this.rec.LNAME = event.target.value;
        window.console.log("LNAME", this.rec.LNAME);
    }

    handlePhoneChange(event) {
        this.rec.Phone = event.target.value;
        window.console.log("Phone", this.rec.Phone);
    }

    handleEmailChange(event) {
        this.rec.EMAIL = event.target.value;
        window.console.log("EMAIL", this.rec.EMAIL);
    }


    handleClick() {
        const contact = {
            FirstName: this.rec.FNAME,
            LastName: this.rec.LNAME,
            Phone: this.rec.Phone,
            Email: this.rec.EMAIL,
            RecordTypeId: '0127Q000000uhyxQAA'
        }
        insertContact ({ patient : contact })
   //     insertContact ({ con : this.rec })
            .then(result => {
                this.message = result;
                this.error = undefined;
                if(this.message !== undefined) {
                    this.rec={};
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Account created',
                            variant: 'success',
                        }),
                    );
                }
                window.console.log(JSON.stringify(result));
                window.console.log("result", this.message);
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
                window.console.log("error", JSON.stringify(this.error));
            });
    }
}