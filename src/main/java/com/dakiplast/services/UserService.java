package com.dakiplast.services;

import java.util.List;

import com.dakiplast.entities.User;
import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.requests.UserRequest;

public interface UserService {
	
	public IUser getById(Long id);
	
	public IUser create(Long createdById, String firstName, String lastName, String email, String phoneNumber, String city, String street, String buildNumber);
	
	public boolean update(Long userId, UserRequest entity);
	
	public boolean delete(Long id);
	
	public List<User> getUsers();
	
	public IUser getByEmail(String username);

	public List<User> getUsersExcludeUser(Long userId);

	public boolean setDefaultPassword(Long userId);

	public boolean toggleBlockUser(Long userId);
}
