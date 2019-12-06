package com.dakiplast.repository;

import java.util.List;

import com.dakiplast.entities.interfaces.IWorker;
import com.dakiplast.requests.WorkerRequest;

public interface WorkerRepository {
	
	public IWorker create(String firstName, String lastName, String email, String phoneNumber, String city,
			String street, String buildNumber, String createdByFullName);
	public IWorker getById(Long id);
	public List<IWorker> getAll();
	public IWorker update(WorkerRequest worker);
	public boolean delete(Long id);
	public List<IWorker> workersInDeficit();
	public List<IWorker> workersInSurplus();
}
