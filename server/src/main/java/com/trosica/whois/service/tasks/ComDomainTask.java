package com.trosica.whois.service.tasks;

import com.trosica.whois.utils.CmdExecUtil;
import com.trosica.whois.api.WhoisDataM;
import com.trosica.whois.service.WhoisTask;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ComDomainTask implements WhoisTask {

	@Override
	public List<String> getDomainNames() {
		return Collections.singletonList(".com");
	}

	@Override
	public String getServiceUrl() {
		return "whois.verisign-grs.com";
	}

	@Override
	public WhoisDataM getWhois(String domain) {

		String response = CmdExecUtil.execWhoisCommand(domain, getServiceUrl());

		WhoisDataM data = new WhoisDataM();
		for (String line : response.split("\n")) {
			line = line.trim();
			if (line.startsWith("Creation Date:")) {
				data.setRegistrationDate(convertToMillis(line.replace("Creation Date:", "")
						.trim()));
			}
			if (line.startsWith("Registry Expiry Date:")) {
				data.setExpirationDate(convertToMillis(line.replace("Registry Expiry Date:", "")
						.trim()));
			}
			if (line.startsWith("Registrar:")) {
				data.setRegistrar(line.replace("Registrar:", "")
						.trim());
			}
			if (line.startsWith("Registrar Abuse Contact Email:")) {
				data.setOwner(line.replace("Registrar Abuse Contact Email:", "")
						.trim());
			}
			if (line.startsWith("Registrant Organization:")) {
				data.setRegistrant(line.replace("Registrant Organization:", "")
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

	@SneakyThrows
	private long convertToMillis(String date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = sdf.parse(date.split("T")[0]);
		return d.getTime();
	}

}
