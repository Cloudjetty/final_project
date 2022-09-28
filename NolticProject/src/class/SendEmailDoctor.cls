public with sharing class SendEmailDoctor {

    public static void generateDoctorsPDF() {

        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();

        List<Contact> doctors = ContactController.getAllDoctors();

        for (Contact c : doctors) {

            Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
            attach.setContentType('application/pdf');
            attach.setFileName('TotalPayment.pdf');

            String body = '<html><body><h1 style=\"text-align:center;\">' +
                    'Total Payment Information</h1><br/><br/>' +
                    '<table align=\"center\">' +
                    '<tr><td>Doctor Name</td><td>' + c.Name + '</td></tr>' +
                    '<tr><td>Total Payment</td><td>' + c.Total_Payment__c + '</td></tr>' +
                    '</table></body></html>';

            attach.body = Blob.toPdf(body);

            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            List<String> sendTo = new List<String>();
            if (c.Email != null) {
                sendTo.add(c.Email);
            }
            mail.setToAddresses(sendTo);
            mail.setSubject('Total Payment Information');
            mail.setFileAttachments(new Messaging.EmailFileAttachment[]{
                    attach
            });
            mail.setHtmlBody('Total Payment Information');
            mails.add(mail);
        }
        if (!mails.isEmpty()) {
            Messaging.sendEmail(mails);
        }
    }
}