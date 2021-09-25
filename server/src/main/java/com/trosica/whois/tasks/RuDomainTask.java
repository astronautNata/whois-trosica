package com.trosica.whois.tasks;

import com.trosica.whois.CmdExecUtil;
import com.trosica.whois.WhoisDataM;
import com.trosica.whois.WhoisTask;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RuDomainTask implements WhoisTask {

	@Override
	public List<String> getDomainNames() {
		return List.of(".ru", ".xn--p1ai");
	}

	@Override
	public String getServiceUrl() {
		return "whois.tcinet.ru";
	}

	@Override
	public WhoisDataM getWhois(String domain) {

		String response = CmdExecUtil.execWhoisCommand(domain, getServiceUrl());

		System.err.println(response);

		WhoisDataM data = new WhoisDataM();
		for (String line : response.split("\n")) {
			if (line.startsWith("created:")) {
				data.setRegistrationDate(line.replace("created:", "")
						.trim());
			}
			if (line.startsWith("paid-till:")) {
				data.setExpirationDate(line.replace("paid-till:", "")
						.trim());
			}
			if (line.startsWith("registrar:")) {
				data.setRegistrar(line.replace("registrar:", "")
						.trim());
			}
			if (line.startsWith("admin-contact:")) {
				data.setOwner(line.replace("admin-contact:", "")
						.trim());
			}
			if (line.startsWith("nserver:")) {
				data.getNameservers()
						.add(line.replace("nserver:", "")
								.trim());
			}
		}
		data.setCompleteInfo(response);

		return data;
	}
}
