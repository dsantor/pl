package com.dakiplast.requests;

import java.util.List;

public class OrderRequest {

	private List<DoorRequest> doors;
	private List<ThresholdRequest> thresholds;
	private List<MosquitoRequest> mosquitos;
	private List<WindowRequest> windows;
	private List<ShutterRequest> shutters;
	private Long clientId;
	private ClientRequest createClient;
	private Long workerId;
	private Long buildDate;
	private boolean oldClientIsChosen;
	
	public List<DoorRequest> getDoors() {
		return doors;
	}
	public void setDoors(List<DoorRequest> doors) {
		this.doors = doors;
	}
	public List<ThresholdRequest> getThresholds() {
		return thresholds;
	}
	public void setThresholds(List<ThresholdRequest> thresholds) {
		this.thresholds = thresholds;
	}
	public List<MosquitoRequest> getMosquitos() {
		return mosquitos;
	}
	public void setMosquitos(List<MosquitoRequest> mosquitos) {
		this.mosquitos = mosquitos;
	}
	public List<WindowRequest> getWindows() {
		return windows;
	}
	public void setWindows(List<WindowRequest> windows) {
		this.windows = windows;
	}
	public List<ShutterRequest> getShutters() {
		return shutters;
	}
	public void setShutters(List<ShutterRequest> shutters) {
		this.shutters = shutters;
	}
	public Long getClientId() {
		return clientId;
	}
	public void setClientId(Long clientId) {
		this.clientId = clientId;
	}
	public ClientRequest getCreateClient() {
		return createClient;
	}
	public void setCreateClient(ClientRequest createClient) {
		this.createClient = createClient;
	}
	public Long getWorkerId() {
		return workerId;
	}
	public void setWorkerId(Long workerId) {
		this.workerId = workerId;
	}
	public Long getBuildDate() {
		return buildDate;
	}
	public void setBuildDate(Long buildDate) {
		this.buildDate = buildDate;
	}
	public boolean isOldClientIsChosen() {
		return oldClientIsChosen;
	}
	public void setOldClientIsChosen(boolean oldClientIsChosen) {
		this.oldClientIsChosen = oldClientIsChosen;
	}
}
