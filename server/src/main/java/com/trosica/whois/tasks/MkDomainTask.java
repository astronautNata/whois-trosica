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
public class MkDomainTask implements WhoisTask {

	@Override
	public List<String> getDomainNames() {
		return List.of(".mk", ".мкд");
	}

	@Override
	public String getServiceUrl() {
		return "whois.marnet.mk";
	}

	@Override
	public WhoisDataM getWhois(String domain) {

		String response = CmdExecUtil.execWhoisCommand(domain, getServiceUrl());

		System.err.println(response);

		WhoisDataM data = new WhoisDataM();
		for (String line : response.split("\n")) {
			if (line.startsWith("registered:")) {
				data.setRegistrationDate(line.replace("registered:", "")
						.trim());
			}
			if (line.startsWith("expire:")) {
				data.setExpirationDate(line.replace("expire:", "")
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
			if (line.startsWith("registrant:")) {
				data.setRegistrant(line.replace("registrant:", "")
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
