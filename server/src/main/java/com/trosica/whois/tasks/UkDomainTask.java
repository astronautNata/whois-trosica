package com.trosica.whois.tasks;

import com.trosica.whois.CmdExecUtil;
import com.trosica.whois.WhoisDataM;
import com.trosica.whois.WhoisTask;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UkDomainTask implements WhoisTask {

	@Override
	public List<String> getDomainNames() {
		return List.of(".uk");
	}

	@Override
	public String getServiceUrl() {
		return "whois.nic.uk";
	}

	@Override
	public WhoisDataM getWhois(String domain) {

		String response = CmdExecUtil.execWhoisCommand(domain, getServiceUrl());

		boolean registrar = false;
		boolean nameservers = false;

		WhoisDataM data = new WhoisDataM();
		for (String line : response.split("\n")) {
			line = line.trim();
			if (line.startsWith("Registered on:")) {
				data.setRegistrationDate(line.replace("Registered on:", "")
						.trim());
			}
			if (line.startsWith("Expiry date:")) {
				data.setExpirationDate(line.replace("Expiry date:", "")
						.trim());
			}
			if (registrar) {
				data.setRegistrar(data.getRegistrar() + " " + line.trim());
			}
			if (nameservers) {
				data.getNameservers()
						.add(line.trim());
			}

			if (line.startsWith("Registrar:")) {
				registrar = true;
			}
			if (line.startsWith("Name servers:")) {
				nameservers = true;
			}
			if (StringUtils.isEmpty(line)) {
				registrar = false;
				nameservers = false;
			}

		}
		data.setCompleteInfo(response);

		return data;
	}
}
