package com.dakiplast.repository;

import java.util.List;

import com.dakiplast.entities.User;
import com.dakiplast.entities.interfaces.IUser;

public interface UserRepository {

	IUser findById(Long id);
	User findByEmail(String email);
	
	IUser save(Long createdById, String firstName, String lastName, String email, String phoneNumber, String city, String street, String buildNumber);
	
	boolean update(Long userId, String firstName, String lastName, String street, String buildNumber, String city, String phoneNumber, String password);
	List<User> findAll();
	boolean delete(Long id);
	List<User> findAllExcludeUser(Long userId);
	boolean setDefaultPassword(Long userId);
	boolean toggleBlockUser(Long userId);
	
}
