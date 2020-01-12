package com.dakiplast.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dakiplast.entities.interfaces.IWorker;
import com.dakiplast.repository.WorkerRepository;
import com.dakiplast.requests.WorkerRequest;
import com.dakiplast.services.WorkerService;
import com.dakiplast.utils.Validation;

@Service
public class WorkerServiceImpl implements WorkerService {

	@Autowired
	private WorkerRepository workerRepository;
	
	@Override
	public IWorker create(WorkerRequest worker, String createdByFullName) {
		String firstName   = worker.getFirstName().trim();
		String lastName    = worker.getLastName().trim();
		String street	   = worker.getStreet().trim();
		String buildNumber = worker.getBuildNumber().trim();
		String city 	   = worker.getCity().trim();
		String phoneNumber = worker.getPhoneNumber().trim();
		String email 	   = worker.getEmail().trim();
		
		if (Validation.isEmptyString(firstName) || Validation.isEmptyString(lastName)) {
			return null;	
		}
		
		if (!Validation.phone(phoneNumber)) {
			return null;
		}
		
		return workerRepository.create(firstName, lastName, email, phoneNumber, city, street, buildNumber, createdByFullName);
	}

	@Override
	public IWorker getById(Long id) {
		return workerRepository.getById(id);
	}

	@Override
	public List<IWorker> getAll() {
		return workerRepository.getAll();
	}

	@Override
	public boolean toggleBlockWorker(Long workerId) {
		return workerRepository.toggleBlockWorker(workerId);
	}

	@Override
	public IWorker update(WorkerRequest workerRequest) {
		Long id			   = workerRequest.getId();
		String firstName   = workerRequest.getFirstName().trim();
		String lastName    = workerRequest.getLastName().trim();
		String street	   = workerRequest.getStreet().trim();
		String buildNumber = workerRequest.getBuildNumber().trim();
		String city 	   = workerRequest.getCity().trim();
		String phoneNumber = workerRequest.getPhoneNumber().trim();
		String email 	   = workerRequest.getEmail().trim();
		
		if (Validation.isEmptyString(firstName) || Validation.isEmptyString(lastName)) {
			return null;	
		}
		
		if (!Validation.phone(phoneNumber)) {
			return null;
		}
		
		return workerRepository.update(id, firstName, lastName, email, phoneNumber, city, street, buildNumber);
	}

}
