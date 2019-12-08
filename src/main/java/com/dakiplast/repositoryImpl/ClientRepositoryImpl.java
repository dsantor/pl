package com.dakiplast.repositoryImpl;

import java.util.List;

import javax.persistence.EntityManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.dakiplast.entities.Client;
import com.dakiplast.entities.interfaces.IClient;
import com.dakiplast.repository.ClientRepository;
@Repository
@Transactional
@SuppressWarnings("unchecked")
public class ClientRepositoryImpl implements ClientRepository {

	@Autowired
	EntityManager em;
	
	@Override
	public IClient getClientById(Long id) {
		return em.find(Client.class, id);
	}


	@Override
	public List<IClient> getAll() {
		List<IClient> clients = em.createNamedQuery("Client.findAll").getResultList();
		return clients;
	}

	@Override
	public IClient create(String firstName, String lastName, String phoneNumber, String email, String city, String street, String buildNumber, Long createdBy) {
		Client entity = new Client();
		
		entity.setBuildNumber(buildNumber);
		entity.setCity(city);
		entity.setEmail(email);
		entity.setFirstName(firstName);
		entity.setLastName(lastName);
		entity.setPhoneNumber(phoneNumber);
		entity.setStreet(street);
		entity.setCreatedBy(createdBy);
		
		em.persist(entity);
		return entity;
	}

}
