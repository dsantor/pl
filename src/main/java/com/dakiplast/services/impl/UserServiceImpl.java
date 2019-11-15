package com.dakiplast.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.dakiplast.entities.User;
import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.enums.RolesEnum;
import com.dakiplast.repository.UserRepository;
import com.dakiplast.requests.UserRequest;
import com.dakiplast.services.UserService;
import com.dakiplast.utils.Validation;

@Service
public class UserServiceImpl implements UserService {
	
	private UserRepository userRepository;
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	public UserServiceImpl(UserRepository userRepository, BCryptPasswordEncoder bCryptPasswordEncoder) {
		this.userRepository 	   = userRepository;
		this.bCryptPasswordEncoder = bCryptPasswordEncoder;
	}
	
	@Override
	public IUser getById(Long id) {
		IUser user = userRepository.findById(id);
		return user;
	}

	@Override
	public User create(String firstName, String lastName, String email, String phoneNumber, String city, String street, String buildNumber, String password) {
		// TODO: Add validation
		User entity = new User();
		
		entity.setFirstName(firstName);
		entity.setLastName(lastName);
		entity.setEmail(email);
		entity.setPhoneNumber(phoneNumber);
		entity.setCity(city);
		entity.setStreet(street);
		entity.setBuildNumber(buildNumber);
		entity.setActive(true);
		entity.setPassword(bCryptPasswordEncoder.encode(password));
		entity.setRole(RolesEnum.ROLE_USER);
		
		userRepository.save(entity);
		
		return entity;
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
	public User getByEmail(String username) {
		return userRepository.findByEmail(username);
	}

	@Override
	public List<User> getUsersExcludeUser(Long userId) {
		return userRepository.findAllExcludeUser(userId);
	}
	
}
