package com.dakiplast.repository;

import java.util.List;

import com.dakiplast.entities.interfaces.IClient;
import com.dakiplast.requests.ClientRequest;

public interface ClientRepository {
	
	IClient create(ClientRequest clientRequest);
	
	IClient getClientById(Long id);
	List<IClient> getAll();
}
