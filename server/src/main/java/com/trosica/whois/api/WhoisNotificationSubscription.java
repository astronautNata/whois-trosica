package com.trosica.whois.api;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class WhoisNotificationSubscription {

	private String email;
	private String token;
	private String domain;
	private boolean test;

}
