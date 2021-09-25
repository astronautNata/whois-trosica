package com.trosica.whois.tasks;

import com.trosica.whois.CmdExecUtil;
import com.trosica.whois.WhoisDataM;
import com.trosica.whois.WhoisTask;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RsDomainTask implements WhoisTask {

	@Override
	public List<String> getDomainNames() {
		return List.of(".rs", ".срб", ".xn--90a3ac");
	}

	@Override
	public String getServiceUrl() {
		return "whois.rnids.rs";
	}

	@Override
	public WhoisDataM getWhois(String domain) {

		String response = CmdExecUtil.execWhoisCommand(domain, getServiceUrl());

		WhoisDataM data = new WhoisDataM();
		for (String line : response.split("\n")) {
			if (line.startsWith("Registration date:")) {
				data.setRegistrationDate(line.replace("Registration date:", "")
						.trim());
			}
			if (line.startsWith("Expiration date:")) {
				data.setExpirationDate(line.replace("Expiration date:", "")
						.trim());
			}
			if (line.startsWith("Registrar:")) {
				data.setRegistrar(line.replace("Registrar:", "")
						.trim());
			}
			if (line.startsWith("Administrative contact:")) {
				data.setOwner(line.replace("Administrative contact:", "")
						.trim());
			}
			if (line.startsWith("Registrant:")) {
				data.setRegistrant(line.replace("Registrant:", "")
						.trim());
			}
			if (line.startsWith("Address:")) {
				data.setAddress(line.replace("Address:", "")
						.trim());
			}
			if (line.startsWith("DNS:")) {
				data.getNameservers()
						.add(line.replace("DNS:", "")
								.trim());
			}
		}
		data.setCompleteInfo(response);

		return data;
	}
}
