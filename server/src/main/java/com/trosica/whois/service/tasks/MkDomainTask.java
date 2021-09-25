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
public class MkDomainTask implements WhoisTask {

	@Override
	public List<String> getDomainNames() {
		return Arrays.asList(".mk", ".мкд", ".xn--d1alf");
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
				data.setRegistrationDate(convertRegToMillis(line.replace("registered:", "")
						.trim()));
			}
			if (line.startsWith("expire:")) {
				data.setExpirationDate(convertExpToMillis(line.replace("expire:", "")
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

	@SneakyThrows
	private long convertRegToMillis(String date) {
		SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy HH:mm:ss");
		Date d = sdf.parse(date);
		return d.getTime();
	}

	@SneakyThrows
	private long convertExpToMillis(String date) {
		SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
		Date d = sdf.parse(date);
		return d.getTime();
	}
}
