package com.trosica.whois;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.Collections;
import java.util.Map;

import static org.springframework.http.HttpStatus.INTERNAL_SERVER_ERROR;

@RestControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler({BadDomainException.class})
	@ResponseStatus(INTERNAL_SERVER_ERROR)
	public Map<String, Object> handle(BadDomainException e) {
		return Collections.singletonMap("message", "Domen nije nadjen");
	}

}


