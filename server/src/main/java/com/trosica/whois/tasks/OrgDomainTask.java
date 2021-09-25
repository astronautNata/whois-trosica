package com.trosica.whois.tasks;

import com.trosica.whois.CmdExecUtil;
import com.trosica.whois.WhoisDataM;
import com.trosica.whois.WhoisTask;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OrgDomainTask implements WhoisTask {

	@Override
	public List<String> getDomainNames() {
		return List.of(".org", ".орг");
	}

	@Override
	public String getServiceUrl() {
		return "whois.publicinterestregistry.net";
	}

	@Override
	public WhoisDataM getWhois(String domain) {

		String response = CmdExecUtil.execWhoisCommand(domain, getServiceUrl());

		WhoisDataM data = new WhoisDataM();
		for (String line : response.split("\n")) {
			if (line.startsWith("Creation Date:")) {
				data.setRegistrationDate(line.replace("Creation Date:", "")
						.trim());
			}
			if (line.startsWith("Registry Expiry Date:")) {
				data.setExpirationDate(line.replace("Registry Expiry Date:", "")
						.trim());
			}
			if (line.startsWith("Registrar:")) {
				data.setRegistrar(line.replace("Registrar:", "")
						.trim());
			}
			if (line.startsWith("Registrar Abuse Contact Email:")) {
				data.setOwner(line.replace("Registrar Abuse Contact Email:", "")
						.trim());
			}
			if (line.startsWith("Registrant:")) {
				data.setRegistrant(line.replace("Registrant:", "")
						.trim());
			}
			if (line.startsWith("Name Server:")) {
				data.getNameservers()
						.add(line.replace("Name Server:", "")
								.trim());
			}
		}
		data.setCompleteInfo(response);

		return data;
	}
}
