package com.trosica.whois.service.tasks;

import com.trosica.whois.utils.CmdExecUtil;
import com.trosica.whois.api.WhoisDataM;
import com.trosica.whois.service.WhoisTask;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RsDomainTask implements WhoisTask {

	@Override
	public List<String> getDomainNames() {
		return Arrays.asList(".rs", ".срб", ".xn--90a3ac");
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
				data.setRegistrationDate(convertToMillis(line.replace("Registration date:", "")
						.trim()));
			}
			if (line.startsWith("Expiration date:")) {
				data.setExpirationDate(convertToMillis(line.replace("Expiration date:", "")
						.trim()));
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

	@SneakyThrows
	private long convertToMillis(String date) {
		SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy HH:mm:ss");
		Date d = sdf.parse(date);
		return d.getTime();
	}
}
