package com.dakiplast.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validation {

	public static boolean email(String email) {
		Pattern pattern = Pattern.compile("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", Pattern.CASE_INSENSITIVE);
		Matcher matcher = pattern.matcher(email);
		return matcher.find();
	}
	
	public static boolean password(String password) {
		Pattern pattern = Pattern.compile("^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9&._@?>!<#^$\\-%&*+]{8,}$");
		Matcher matcher = pattern.matcher(password);
		return matcher.find();
	}
	
	public static boolean phone(String phone) {
		Pattern pattern = Pattern.compile("^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\\s\\./0-9]*$");
		Matcher matcher = pattern.matcher(phone);
		return matcher.find();
	}
	
	public static boolean isEmptyString(String value) {
		if (value == null || value.isEmpty()) {
			return true;
		}
		return false;
	}
}
