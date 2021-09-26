package com.trosica.whois.api;

import com.trosica.whois.service.WhoisExecutor;
import com.trosica.whois.service.WhoisService;
import lombok.RequiredArgsConstructor;
import org.springframework.lang.NonNull;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class WhoisController {

	private final WhoisExecutor executor;
	private final WhoisService whoisService;

	@GetMapping("/whois")
	public WhoisDataM getWhois(@RequestParam @NonNull String domain) {
		return executor.getWhois(domain);
	}

	@PostMapping("/whois")
	public void subscribeToNotifications(@RequestBody @NonNull WhoisNotificationSubscription param) {
		whoisService.addSubscription(param.getEmail(), param.getToken(), param.getDomain());
	}

	@DeleteMapping("/whois")
	public void unsubscribeToNotifications(@RequestBody @NonNull WhoisNotificationSubscription param) {
		whoisService.unsubscribe(param.getEmail(), param.getToken(), param.getDomain());
	}

}
