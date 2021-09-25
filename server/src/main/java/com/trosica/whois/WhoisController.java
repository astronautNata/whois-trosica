package com.trosica.whois;

import lombok.RequiredArgsConstructor;
import org.springframework.lang.NonNull;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class WhoisController {

	private final WhoisExecutor executor;

	@GetMapping("/whois")
	public WhoisDataM getWhois(@RequestParam @NonNull String domain) {
		return executor.getWhois(domain);
	}

}
