package com.trosica.whois.service;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

@Service
public class MailService {

	private static final Log LOG = LogFactory.getLog(MailService.class);
	private final JavaMailSender mailSender;

	@Autowired
	public MailService() {

		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		mailSender.setHost("smtp.gmail.com");
		mailSender.setPort(587);

		mailSender.setUsername("zeljko.zte@gmail.com");
		mailSender.setPassword("ectknhstcdejlhgd");
		Properties props = mailSender.getJavaMailProperties();
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.auth", "true");
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.starttls.requred", "true");

		this.mailSender = mailSender;
	}

	@Async("mailingExecutor")
	public void sendMail(String recipient, String text, String subject) {

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, false);
			helper.setTo(recipient);
			helper.setSubject(subject);
			helper.setText(text);
			mailSender.send(message);

		} catch (MessagingException e) {
			LOG.error(e, e);
		}
	}

}