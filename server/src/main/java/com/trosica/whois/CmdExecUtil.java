package com.trosica.whois;

import lombok.SneakyThrows;
import org.apache.commons.lang3.StringUtils;

public class CmdExecUtil {

	private static StringBuilder composeWhoisCommand(String domain, String hostServer) {
		StringBuilder sb = new StringBuilder();
		sb.append("whois ");
		if (StringUtils.isNotEmpty(hostServer)) {
			sb.append("-h ");
			sb.append(hostServer);
			sb.append(" ");
		}
		sb.append(domain);
		return sb;
	}

	@SneakyThrows
	public static String execWhoisCommand(String domain, String hostServer) {

		StringBuilder sb = composeWhoisCommand(domain, hostServer);

		Process proc = Runtime.getRuntime()
				.exec(sb.toString());

		java.io.InputStream is = proc.getInputStream();
		java.util.Scanner s = new java.util.Scanner(is).useDelimiter("\\A");

		return s.hasNext() ? s.next() : "";
	}

}
