package com.casic.iot.core.ext.mail;

public class MailWorker implements Runnable {
    private MailHelper mailHelper;
    private MailDTO mailDto;

    public MailWorker(MailDTO mailDto, MailHelper mailHelper) {
        this.mailDto = mailDto;
        this.mailHelper = mailHelper;
    }

    public void run() {
        mailHelper.send(mailDto);
    }
}
