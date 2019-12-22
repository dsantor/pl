package com.dakiplast.repositoryImpl;

import java.util.Calendar;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dakiplast.entities.Worker;
import com.dakiplast.entities.interfaces.IWorker;
import com.dakiplast.repository.WorkerRepository;
import com.dakiplast.requests.WorkerRequest;

@Repository
@Transactional
@SuppressWarnings("unchecked")
public class WorkerRepositoryImpl implements WorkerRepository {

	@Autowired
	private EntityManager entityManager;
	
	@Override
	public IWorker create(String firstName, String lastName, String email, String phoneNumber, String city,
							String street, String buildNumber, String createdByFullName) {
		Worker entity = new Worker();
		
		entity.setFirstName(firstName);
		entity.setLastName(lastName);
		entity.setEmail(email);
		
		entity.setPhoneNumber(phoneNumber);
		entity.setCity(city);
		entity.setStreet(street);
		entity.setBuildNumber(buildNumber);
		
		entity.setCreatedAt(Calendar.getInstance().getTimeInMillis());
		entity.setCreatedBy(createdByFullName);
		
		entity.setDeleted(false);
		
		entityManager.persist(entity);
		return entity;
	}

	@Override
	public IWorker getById(Long id) {
		return entityManager.find(Worker.class, id);
	}

	@Override
	public List<IWorker> getAll() {
		Query query = entityManager.createNamedQuery("Worker.findAll");
		return query.getResultList();
	}

	@Override
	public IWorker update(WorkerRequest worker) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean delete(Long id) {
		Worker entity = entityManager.find(Worker.class, id);
		entityManager.remove(entity);
		return true;
	}

	@Override
	public List<IWorker> workersInDeficit() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<IWorker> workersInSurplus() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean toggleBlockWorker(Long workerId) {
		Worker worker = entityManager.find(Worker.class, workerId);
		if (worker != null) {
			worker.setActive(!worker.isActive());
			return true;
		}
		return false;
	}

}
