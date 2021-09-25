package com.trosica.whois.service.tasks;

import com.trosica.whois.api.WhoisDataM;
import com.trosica.whois.utils.CmdExecUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class DefaultDomainTask {

	public WhoisDataM getWhois(String domain) {

		String response = CmdExecUtil.execWhoisCommand(domain, null);

		WhoisDataM data = new WhoisDataM();
		data.setCompleteInfo(response);

		return data;
	}

}
