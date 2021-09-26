package com.trosica.whois.dao;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SubscriptionsRepository extends CrudRepository<Subscription, Long> {

	void deleteAllByEmailAndTokenAndDomain(String email, String token, String domain);

	List<Subscription> findAllByExpirationDateLessThanEqualAndLastNotifiedLessThanEqual(long date, long lastNotified);

}
