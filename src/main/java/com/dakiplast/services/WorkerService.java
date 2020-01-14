package com.dakiplast.services;

import java.util.List;

import com.dakiplast.entities.interfaces.IWorker;
import com.dakiplast.requests.WorkerRequest;

public interface WorkerService {

	public IWorker create(WorkerRequest worker, String createdByFullName);
	public IWorker getById(Long id);
	public List<IWorker> getAll();
	public boolean toggleBlockWorker(Long workerId);
	public IWorker update(WorkerRequest workerRequest);
	public List<IWorker> getAllActive();
}
