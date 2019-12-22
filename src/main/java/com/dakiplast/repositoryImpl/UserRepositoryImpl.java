package com.dakiplast.repositoryImpl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.dakiplast.entities.User;
import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.enums.RolesEnum;
import com.dakiplast.repository.UserRepository;

@Repository
@Transactional
@SuppressWarnings("unchecked")
public class UserRepositoryImpl implements UserRepository {

	@Autowired
	private EntityManager entityManager;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	private String DEFAULT_PASSWORD = "password";
	
	@Override
	public IUser findById(Long id) {
		IUser user = entityManager.find(User.class, id);
		return user;
	}


	@Override
	public User findByEmail(String email) {
		Query query = entityManager.createNamedQuery("User.findByEmail").setParameter("email", email);
		query.setMaxResults(1);
		List<User> users = query.getResultList();
		
		if (users.isEmpty()) {
	        return null;
	    }
	    return users.get(0);
	}

	@Override
	public IUser save(Long createdById, String firstName, String lastName, String email, String phoneNumber, String city, String street, String buildNumber) {
		try {
			User entity = new User();
			
			entity.setFirstName(firstName);
			entity.setLastName(lastName);
			entity.setEmail(email);
			entity.setPhoneNumber(phoneNumber);
			entity.setCity(city);
			entity.setStreet(street);
			entity.setBuildNumber(buildNumber);
			entity.setActive(true);
			entity.setDeleted(false);
			entity.setCreatedBy(createdById);
			entity.setPassword(passwordEncoder.encode(DEFAULT_PASSWORD));
			entity.setRole(RolesEnum.ROLE_USER);
			
			entityManager.persist(entity);
			return entity;
		} catch (Exception e) {
			return null;
		}
	}

	@Override
	public boolean update(Long userId, String firstName, String lastName, String street, String buildNumber,
			String city, String phoneNumber, String password) {
		
		try {
			User user = entityManager.find(User.class, userId);
			
			user.setFirstName(firstName);
			user.setLastName(lastName);
			user.setStreet(street);
			user.setBuildNumber(buildNumber);
			user.setCity(city);
			user.setPhoneNumber(phoneNumber);
			
			if (!password.isEmpty()) {
				user.setPassword(passwordEncoder.encode(password));
			}
			
			entityManager.merge(user);
			return true;
			
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public List<User> findAll() {
		 Query query = entityManager.createNamedQuery("User.findAll");
		 return query.getResultList();
	}

	@Override
	public boolean delete(Long id) {
		User entity = entityManager.find(User.class, id);
		if (entity == null) {
			return false;
		}
		entity.setDeleted(true);
		entityManager.persist(entity);
		
		return true;
	}

	@Override
	public List<User> findAllExcludeUser(Long userId) {
		 Query query = entityManager.createNamedQuery("User.findAllExcludeUser").setParameter("userId", userId);
		 return query.getResultList();
	}


	@Override
	public boolean setDefaultPassword(Long userId) {
		User user = entityManager.find(User.class, userId);
		
		if (user != null) {
		user.setPassword(passwordEncoder.encode(DEFAULT_PASSWORD));
		entityManager.persist(user);
		return true;
		}
		
		return false;
	}


	@Override
	public boolean toggleBlockUser(Long userId) {
		User user = entityManager.find(User.class, userId);
		if (user != null) {
			user.setActive(!user.isActive());
			return true;
		}
		return false;
	}

}
