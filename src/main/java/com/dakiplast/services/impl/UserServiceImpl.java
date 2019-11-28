package com.dakiplast.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dakiplast.entities.User;
import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.repository.UserRepository;
import com.dakiplast.requests.UserRequest;
import com.dakiplast.services.UserService;
import com.dakiplast.utils.Validation;

@Service
public class UserServiceImpl implements UserService {
	
	private UserRepository userRepository;
	
	@Autowired
	public UserServiceImpl(UserRepository userRepository) {
		this.userRepository = userRepository;
	}
	
	@Override
	public IUser getById(Long id) {
		IUser user = userRepository.findById(id);
		return user;
	}

	@Override
	public IUser create(Long createdById, String firstName, String lastName, String email, String phoneNumber, String city, String street, String buildNumber) {
		return userRepository.save(createdById, firstName, lastName, email, phoneNumber, city, street, buildNumber);
	}

	@Override
	public boolean update(Long userId, UserRequest entity) {
		
		String firstName   = entity.getFirstName().trim();
		String lastName    = entity.getLastName().trim();
		String street 	   = entity.getStreet().trim();
		String buildNumber = entity.getBuildNumber().trim();
		String city 	   = entity.getCity().trim();
		String phoneNumber = entity.getPhoneNumber().trim();
		String password	   = entity.getPassword().trim();
		
		if (firstName == null || firstName.isEmpty()) {
			throw new IllegalArgumentException("Obavezno je uneti ime!");
		}
		
		if (lastName == null || lastName.isEmpty()) {
			throw new IllegalArgumentException("Obavezno je uneti prezime!");
		}
		
		if (password != null && !password.isEmpty() && !Validation.password(password)) {
			throw new IllegalArgumentException("Sifra nije validna!");
		}
		
		
		return userRepository.update(userId, firstName, lastName, street, buildNumber, city, phoneNumber, password);
	}

	@Override
	public boolean delete(Long id) {
		return userRepository.delete(id);
	}

	@Override
	public List<User> getUsers() {
		List<User> users = userRepository.findAll();
		return users;
	}

	@Override
	public IUser getByEmail(String username) {
		return userRepository.findByEmail(username);
	}

	@Override
	public List<User> getUsersExcludeUser(Long userId) {
		return userRepository.findAllExcludeUser(userId);
	}

	@Override
	public boolean setDefaultPassword(Long userId) {
		return userRepository.setDefaultPassword(userId);
	}

	@Override
	public boolean toggleBlockUser(Long userId) {
		return userRepository.toggleBlockUser(userId);
	}
	
}
