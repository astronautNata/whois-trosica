package com.trosica.whois.service;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.io.IOException;
import java.io.InputStream;

import static org.apache.commons.lang3.StringUtils.isEmpty;

@Service
public class FirebaseService {

	private static final Log LOG = LogFactory.getLog(FirebaseService.class);

	@Autowired
	public FirebaseService() {
		try {
			InputStream refreshToken = new ClassPathResource("firebase.json").getInputStream();
			FirebaseOptions options = FirebaseOptions.builder()
					.setCredentials(GoogleCredentials.fromStream(refreshToken))
					.build();
			initializeFirebase(options);
		} catch (IOException e) {
			LOG.error(e.getMessage());
		}
	}

	public void sendNotification(String firebaseToken, String body) {
		if (isEmpty(firebaseToken)) {
			return;
		}

		Message message = Message.builder()
				.setNotification(Notification.builder()
						.setTitle("Trosica Whois")
						.setBody(body)
						.build())
				.setToken(firebaseToken)
				.putData("key", "ACTION_NEW_NOTIFICATION")
				.putData("click_action", "FLUTTER_NOTIFICATION_CLICK")
				.build();

		FirebaseMessaging.getInstance()
				.sendAsync(message);

		LOG.info("sendMobileMessage: fbToken: " + firebaseToken + ",  body: " + body);
	}

	private void initializeFirebase(FirebaseOptions options) {
		if (FirebaseApp.getApps()
				.isEmpty()) {
			FirebaseApp.initializeApp(options);
			LOG.info("Firebase application has been initialized");
		}
	}

}
