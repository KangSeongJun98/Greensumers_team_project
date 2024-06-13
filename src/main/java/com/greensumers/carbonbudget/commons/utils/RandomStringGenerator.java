package com.greensumers.carbonbudget.commons.utils;

import java.util.Random;
import java.util.UUID;

public class RandomStringGenerator {
	public static String generateRandomString() {
		return UUID.randomUUID().toString();
	}
	
	private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXTZ0123456789";
	private static final Random random = new Random();
	
	public static String generateVerificationString() {
		StringBuilder stringbuilder = new StringBuilder();
		for (int i = 0; i < 4; i++) {
			stringbuilder.append(CHARACTERS.charAt(random.nextInt(CHARACTERS.length())));
		}
		System.out.println(stringbuilder);
		return stringbuilder.toString();
	}

	public static String generateTemporaryPassword() {
		StringBuilder stringbuilder = new StringBuilder();
		for (int i = 0; i < 6; i++) {
			stringbuilder.append(CHARACTERS.charAt(random.nextInt(CHARACTERS.length())));
		}
		System.out.println(stringbuilder);
		return stringbuilder.toString();
	}
}
