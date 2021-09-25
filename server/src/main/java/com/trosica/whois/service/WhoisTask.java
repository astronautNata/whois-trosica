package com.trosica.whois.service;

import com.trosica.whois.api.WhoisDataM;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface WhoisTask {

	List<String> getDomainNames();

	String getServiceUrl();

	WhoisDataM getWhois(String domain);

}
