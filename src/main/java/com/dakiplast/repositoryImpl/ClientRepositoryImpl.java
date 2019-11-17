package com.dakiplast.repositoryImpl;

import java.util.List;

import javax.persistence.EntityManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.dakiplast.entities.Client;
import com.dakiplast.entities.interfaces.IClient;
import com.dakiplast.repository.ClientRepository;
import com.dakiplast.requests.ClientRequest;

@Repository
@Transactional
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
	public IClient create(ClientRequest clientRequest) {
		Client entity = new Client();
		
		entity.setBuildNumber(clientRequest.getBuildNumber());
		entity.setCity(clientRequest.getCity());
		entity.setEmail(clientRequest.getEmail());
		entity.setFirstName(clientRequest.getFirstName());
		entity.setLastName(clientRequest.getLastName());
//		entity.setMobileNumber(clientRequest.getMobileNumber());
		entity.setPhoneNumber(clientRequest.getPhoneNumber());
		entity.setStreet(clientRequest.getStreet());
		
		em.persist(entity);
		return entity;
	}

}
