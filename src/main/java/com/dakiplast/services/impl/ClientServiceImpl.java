package com.dakiplast.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dakiplast.entities.interfaces.IClient;
import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.repository.ClientRepository;
import com.dakiplast.requests.ClientRequest;
import com.dakiplast.services.ClientService;
import com.dakiplast.services.UserService;

@Service
public class ClientServiceImpl implements ClientService {
	
	@Autowired
	private ClientRepository clientRepository;
	@Autowired
	private UserService userService;
	
	@Override
	public IClient getClientById(Long id) {
		return clientRepository.getClientById(id);
	}

	@Override
	public List<IClient> getAll() {
		return clientRepository.getAll();
	}

	@Override
	public IClient create(ClientRequest clientRequest, Long createdBy) {
		
		String firstName   = clientRequest.getFirstName().trim();
		String lastName    = clientRequest.getFirstName().trim();
		String buildNumber = clientRequest.getBuildNumber().trim();
		String city 	   = clientRequest.getCity().trim();
		String email 	   = clientRequest.getEmail().trim();
		String phoneNumber = clientRequest.getPhoneNumber().trim();
		String street 	   = clientRequest.getStreet().trim();
		
		IUser user = userService.getById(createdBy);
		if (firstName.isEmpty() || lastName.isEmpty() || phoneNumber.isEmpty() || user == null) {
			return null;
		}
		
		return clientRepository.create(firstName, lastName, phoneNumber, email, city, street, buildNumber, createdBy);
	}

}
