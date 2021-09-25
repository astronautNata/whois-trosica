package com.trosica.whois;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.Collections;
import java.util.Map;

import static org.springframework.http.HttpStatus.NOT_FOUND;

@RestControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler({BadDomainException.class})
	@ResponseStatus(NOT_FOUND)
	public Map<String, Object> handle(BadDomainException e) {
		return Collections.singletonMap("message", "Domen nije nadjen");
	}

}


