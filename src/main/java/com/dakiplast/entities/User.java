package com.dakiplast.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import com.dakiplast.entities.interfaces.IUser;
import com.dakiplast.enums.RolesEnum;

@Entity
@Table(name = "users")
@NamedQueries({
	@NamedQuery( name = "User.findAll", query = "Select u from User u"),
	@NamedQuery( name = "User.findAllAtiveUsers", query = "Select u from User u where u.deleted = false"),
	@NamedQuery( name = "User.findAllInativeUsers", query = "Select u from User u where u.deleted = true"),
	@NamedQuery( name = "User.findAllExcludeUser", query = "Select u from User u where u.deleted = false and u.id !=: userId"),
	@NamedQuery( name = "User.findById", query = "Select u from User u where user_id =: user_id"),
	@NamedQuery( name = "User.findByEmail", query = "Select u from User u where email =: email")
})
public class User implements Serializable, IUser {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "user_id")
	private Long id;
	
	@Column(name = "first_name", columnDefinition="CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci")
	private String firstName;
	
	@Column(name = "last_name")
	private String lastName;
	
	@Column(name = "street")
	private String street;
	
	@Column(name = "city")
	private String city;
	
	@Column(name = "build_number")
	private String buildNumber;
	
	@Column(name = "email")
	private String email;
	
	@Column(name = "phone_number")
	private String phoneNumber;	
	
	@Column(name = "password")
	private String password;
	
	@Column(name = "active")
	private boolean active = true;
	
	@Column(name = "deleted")
	private boolean deleted = false;
	
	@Column(name = "created_by")
	private Long createdBy;
	
	@Column(name = "role")
	@Enumerated(EnumType.STRING)
	private RolesEnum role;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getBuildNumber() {
		return buildNumber;
	}

	public void setBuildNumber(String buildNumber) {
		this.buildNumber = buildNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}
	public RolesEnum getRole() {
		return role;
	}

	public void setRole(RolesEnum role) {
		this.role = role;
	}

	public boolean isDeleted() {
		return deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}

	public Long getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Long createdBy) {
		this.createdBy = createdBy;
	}

	@Override
	public String getFullName() {
		return this.firstName + ' ' + this.lastName;
	}
}
