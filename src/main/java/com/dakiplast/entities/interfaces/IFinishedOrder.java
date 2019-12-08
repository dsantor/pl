package com.dakiplast.entities.interfaces;

import java.util.Calendar;

public interface IFinishedOrder {
	Long getId();
	String getBuildByFullName();
	Calendar getBuildAt();
	String getNote();
}
