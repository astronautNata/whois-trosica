package com.trosica.whois.api;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@ToString
public class WhoisDataM {

	private String owner;
	private String registrar;
	private String registrant;
	private String address;
	private Long registrationDate;
	private Long expirationDate;

	private List<String> nameservers;

	private String completeInfo;

	public WhoisDataM() {
		nameservers = new ArrayList<>();
		registrar = "";
	}

}
