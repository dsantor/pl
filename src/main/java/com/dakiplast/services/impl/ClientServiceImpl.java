package com.dakiplast.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dakiplast.entities.interfaces.IClient;
import com.dakiplast.repository.ClientRepository;
import com.dakiplast.requests.ClientRequest;
import com.dakiplast.services.ClientService;

@Service
public class ClientServiceImpl implements ClientService {
	
	@Autowired
	private ClientRepository clientRepository;
	
	@Override
	public IClient getClientById(Long id) {
		return clientRepository.getClientById(id);
	}

	@Override
	public List<IClient> getAll() {
		return clientRepository.getAll();
	}

	@Override
	public IClient create(ClientRequest clientRequest) {
		return clientRepository.create(clientRequest);
	}

}
