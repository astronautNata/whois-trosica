package com.trosica.whois;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.net.IDN;
import java.util.List;

@Service
@RequiredArgsConstructor
public class WhoisExecutor {

	private final List<WhoisTask> whoisTasks;

	public WhoisDataM getWhois(String domain) {
		String punyDomain = IDN.toASCII(domain);
		return whoisTasks.stream()
				.filter(whoisService -> whoisService.getDomainNames()
						.stream()
						.anyMatch(punyDomain::endsWith))
				.findFirst()
				.map(whoisService -> whoisService.getWhois(punyDomain))
				.orElse(null);

	}

}
