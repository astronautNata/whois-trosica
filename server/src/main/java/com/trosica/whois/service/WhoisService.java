package com.trosica.whois.service;

import com.trosica.whois.dao.Subscription;
import com.trosica.whois.dao.SubscriptionsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.concurrent.TimeUnit;

import static java.lang.System.currentTimeMillis;

@Service
@Transactional
@RequiredArgsConstructor
public class WhoisService {

	private final SubscriptionsRepository subscriptionsRepository;
	private final FirebaseService firebaseService;
	private final WhoisExecutor executor;
	private final MailService mailService;

	public void addSubscription(String email, String token, String domain) {

		Long expirationDate = executor.getWhois(domain)
				.getExpirationDate();

		Subscription subscription = Subscription.builder()
				.domain(domain)
				.email(email)
				.token(token)
				.expirationDate(expirationDate)
				.build();

		subscriptionsRepository.save(subscription);

	}

	@Scheduled(fixedDelay = 60000)
	public void checkExpiredDomains() {

		long currentTime = currentTimeMillis();
		List<Subscription> subscriptions = subscriptionsRepository.findAllByExpirationDateLessThanEqualAndLastNotifiedLessThanEqual(
				currentTime + TimeUnit.DAYS.toMillis(1),
				currentTime - TimeUnit.DAYS.toMillis(1));

		for (Subscription subscription : subscriptions) {

			if (subscription.getExpirationDate() > currentTime) {
				String message = String.format("Domain %s will expire soon.", subscription.getDomain());
				firebaseService.sendNotification(subscription.getToken(), message);
				mailService.sendMail(subscription.getEmail(), message, "WHOIS - Domain will expire soon");
			} else {
				String message = String.format("Domain %s has expired.", subscription.getDomain());
				firebaseService.sendNotification(subscription.getToken(), message);
				mailService.sendMail(subscription.getEmail(), message, "WHOIS - Domain has expired");
			}

			subscription.setLastNotified(currentTime);

		}

		subscriptionsRepository.saveAll(subscriptions);

	}

	public void unsubscribe(String email, String token, String domain) {
		subscriptionsRepository.deleteAllByEmailAndTokenAndDomain(email, token, domain);
	}

}
