package com.dakiplast.entities.dto;

import java.util.List;

public class DoorSettingsDto {

	private List<String> doorSorts;
	private List<String> doorTypes;
	private List<String> doorGlass;
	
	public List<String> getDoorSorts() {
		return doorSorts;
	}
	public void setDoorSorts(List<String> doorSorts) {
		this.doorSorts = doorSorts;
	}
	public List<String> getDoorTypes() {
		return doorTypes;
	}
	public void setDoorTypes(List<String> doorTypes) {
		this.doorTypes = doorTypes;
	}
	public List<String> getDoorGlass() {
		return doorGlass;
	}
	public void setDoorGlass(List<String> doorGlass) {
		this.doorGlass = doorGlass;
	}
}
