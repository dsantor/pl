package com.dakiplast.repositoryImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.dakiplast.entities.User;
import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.repository.UserRepository;

@Repository
@Transactional
public class UserRepositoryImpl implements UserRepository {

	@Autowired
	private EntityManager entityManager;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
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
		
		if (users == null || users.isEmpty()) {
	        return null;
	    }
	    return users.get(0);
	}

	@Override
	public boolean save(IUser user) {
		try {
			entityManager.persist(user);
			return true;
		} catch (Exception e) {
			return false;
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

	@SuppressWarnings("unchecked")
	@Override
	public List<User> findAll() {
		 Query query = entityManager.createNamedQuery("User.findAll");
		 if (query == null) {
			 return new ArrayList<>();
		 }
		 return query.getResultList();
	}

	@Override
	public boolean delete(Long id) {
		User entity = entityManager.find(User.class, id);
		if (entity == null) {
			return false;
		}
		entity.setActive(false);
		entityManager.persist(entity);
		
		return true;
	}

	@Override
	public List<User> findAllExcludeUser(Long userId) {
		 Query query = entityManager.createNamedQuery("User.findAllExcludeUser").setParameter("userId", userId);
		 if (query == null) {
			 return new ArrayList<>();
		 }
		 return query.getResultList();
	}

}
