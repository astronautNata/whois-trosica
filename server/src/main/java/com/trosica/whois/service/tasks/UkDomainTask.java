package com.trosica.whois.service.tasks;

import com.trosica.whois.api.WhoisDataM;
import com.trosica.whois.service.WhoisTask;
import com.trosica.whois.utils.CmdExecUtil;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UkDomainTask implements WhoisTask {

	@Override
	public List<String> getDomainNames() {
		return Collections.singletonList(".uk");
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
				data.setRegistrationDate(convertToMillis(line.replace("Registered on:", "")
						.trim()));
			}
			if (line.startsWith("Expiry date:")) {
				data.setExpirationDate(convertToMillis(line.replace("Expiry date:", "")
						.trim()));
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

	@SneakyThrows
	private long convertToMillis(String date) {
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
		Date d = sdf.parse(date);
		return d.getTime();
	}
}
