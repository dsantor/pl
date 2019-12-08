package com.dakiplast.services;

import java.util.List;

import com.dakiplast.entities.interfaces.IClient;
import com.dakiplast.requests.ClientRequest;

public interface ClientService {
	
	IClient getClientById(Long id); 
	List<IClient> getAll();
	
	IClient create(ClientRequest clientRequest, Long createdBy);
}
