package com.trosica.whois.tasks;

import com.trosica.whois.CmdExecUtil;
import com.trosica.whois.WhoisDataM;
import com.trosica.whois.WhoisTask;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SeDomainTask implements WhoisTask {

	@Override
	public List<String> getDomainNames() {
		return List.of(".se");
	}

	@Override
	public String getServiceUrl() {
		return "whois.iis.se";
	}

	@Override
	public WhoisDataM getWhois(String domain) {

		String response = CmdExecUtil.execWhoisCommand(domain, getServiceUrl());

		WhoisDataM data = new WhoisDataM();
		for (String line : response.split("\n")) {
			if (line.startsWith("created:")) {
				data.setRegistrationDate(line.replace("created:", "")
						.trim());
			}
			if (line.startsWith("expires:")) {
				data.setExpirationDate(line.replace("expires:", "")
						.trim());
			}
			if (line.startsWith("registrar:")) {
				data.setRegistrar(line.replace("registrar:", "")
						.trim());
			}
			if (line.startsWith("admin-c:")) {
				data.setOwner(line.replace("admin-c:", "")
						.trim());
			}
			if (line.startsWith("Address:")) {
				data.setAddress(line.replace("Address:", "")
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
