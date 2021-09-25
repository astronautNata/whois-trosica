package com.trosica.whois.service;

import com.trosica.whois.api.WhoisDataM;
import com.trosica.whois.service.tasks.DefaultDomainTask;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.net.IDN;
import java.util.List;

@Service
@RequiredArgsConstructor
public class WhoisExecutor {

	private final List<WhoisTask> tasks;
	private final DefaultDomainTask defaultDomainTask;

	public WhoisDataM getWhois(String domain) {

		String punyDomain = IDN.toASCII(removeTrailingSlash(domain));

		return tasks.stream()
				.filter(whoisService -> whoisService.getDomainNames()
						.stream()
						.anyMatch(punyDomain::endsWith))
				.findFirst()
				.map(whoisService -> whoisService.getWhois(punyDomain))
				.orElse(defaultDomainTask.getWhois(punyDomain));

	}

	private String removeTrailingSlash(String domain) {
		if (domain.endsWith("/")) {
			domain = domain.substring(0, domain.lastIndexOf("/") - 1);
		}
		return domain;
	}

}
