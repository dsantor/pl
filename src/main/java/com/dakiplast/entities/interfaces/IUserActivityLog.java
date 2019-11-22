package com.dakiplast.entities.interfaces;

import java.util.Calendar;

import com.dakiplast.enums.UserActivityLogType;

public interface IUserActivityLog {

	Long getActionUserId();
	Long getClientId();
	Long getUserId();
	UserActivityLogType getType();
	Calendar getTime();
}
