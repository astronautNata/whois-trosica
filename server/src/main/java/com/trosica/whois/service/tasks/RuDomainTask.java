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
public class RuDomainTask implements WhoisTask {

	@Override
	public List<String> getDomainNames() {
		return Arrays.asList(".ru", ".xn--p1ai");
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
				data.setRegistrationDate(convertToMillis(line.replace("created:", "")
						.trim()));
			}
			if (line.startsWith("paid-till:")) {
				data.setExpirationDate(convertToMillis(line.replace("paid-till:", "")
						.trim()));
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

	@SneakyThrows
	private long convertToMillis(String date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = sdf.parse(date.split("T")[0]);
		return d.getTime();
	}
}
