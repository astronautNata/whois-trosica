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
public class SeDomainTask implements WhoisTask {

	@Override
	public List<String> getDomainNames() {
		return Collections.singletonList(".se");
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
				data.setRegistrationDate(convertToMillis(line.replace("created:", "")
						.trim()));
			}
			if (line.startsWith("expires:")) {
				data.setExpirationDate(convertToMillis(line.replace("expires:", "")
						.trim()));
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

	@SneakyThrows
	private long convertToMillis(String date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = sdf.parse(date);
		return d.getTime();
	}

}
