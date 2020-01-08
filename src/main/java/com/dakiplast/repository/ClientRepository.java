package com.dakiplast.repository;

import java.util.List;

import com.dakiplast.entities.interfaces.IClient;

public interface ClientRepository {
	
	IClient create(String firstName, String lastName, String phoneNumber, String email, String city, String street, String buildNumber, Long createdBy);
	
	IClient getClientById(Long id);
	List<IClient> getAll();

	IClient update(Long clientId, String firstName, String lastName, String phoneNumber, String email, String city,
			String street, String buildNumber);
}
