package com.fallarm.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.fallarm.database.Device_data;
import com.fallarm.database.PersonManager;
import com.fallarm.database.Person_information;

public class EmailService {
	private Session getSession() {
		Properties properties = new Properties();
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.socketFactory.port", "465");
		properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.port", "465");
		Session session = Session.getDefaultInstance(properties, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(email, password);
			}
		});
		return session;
	}

	public void sendEmail(Person_information p) {

		Session session = getSession();

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(fromemail));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(p.getEmail()));
			message.setSubject("Fallarm account created.");
			message.setContent("<P>Hello, " + p.getFname() + " " + p.getLname() + "</p><p>your fallarm username="
					+ p.getPid() + "</p><p>and password=" + p.getPwd() + "</p>", "text/html");
			Transport.send(message);
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}

	public void sendEmergencyEmail(Device_data d, Person_information pi) {
		Session session = getSession();

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(fromemail));
			Person_information p = new PersonManager().listPersonDetailsById(pi.getNurse_id());
			String[] mailAddressTo = { pi.getEmail(), p.getEmail() };
			int noOfRecipients = 1;
			if (p.getEmail() != null && p.getEmail().length() > 0) {
				noOfRecipients = 2;
			}

			InternetAddress[] mailAddress_TO = new InternetAddress[noOfRecipients];
			for (int i = 0; i < mailAddressTo.length; i++) {
				mailAddress_TO[i] = new InternetAddress(mailAddressTo[i]);
			}
			message.addRecipients(Message.RecipientType.TO, mailAddress_TO);
			message.setSubject("Attention!");
			message.setContent("<P>For user " + pi.getFname() + " " + pi.getLname() + " (ID:" + pi.getPid()
					+ ").</p><p>Fall with higher risk was detected! Immediate attention required</p><a href='http://maps.google.com/maps?q="
					+ d.getX() + "," + d.getY() + "' ><button>Open Location</button></a>", "text/html");
			Transport.send(message);
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}
	
	public void sendUserVerification(String name,String email) {
		Session session = getSession();

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(fromemail));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
			message.setSubject("user verified");
			message.setContent("<P> Hello, " + name + "</p><p>your fallarm Account is verified. You data is being Recorded.</p>", "text/html");
			Transport.send(message);
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}

}
