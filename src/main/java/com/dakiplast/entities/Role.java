//package com.dakiplast.entities;
//
//import javax.persistence.Column;
//import javax.persistence.Entity;
//import javax.persistence.EnumType;
//import javax.persistence.Enumerated;
//import javax.persistence.GeneratedValue;
//import javax.persistence.GenerationType;
//import javax.persistence.Id;
//import javax.persistence.Table;
//
//import com.dakiplast.enums.RolesEnum;
//
//@Entity
//@Table(name = "role")
//public class Role {
//
//	@Id
//	@GeneratedValue(strategy = GenerationType.IDENTITY)
//	@Column(name = "role_id")
//	private Long id;
//	
//	@Column(name = "role")
//	@Enumerated(EnumType.STRING)
//	private RolesEnum role;	
//	
//	public Long getId() {
//		return id;
//	}
//
//	public void setId(Long id) {
//		this.id = id;
//	}
//
//	public RolesEnum getRole() {
//		return role;
//	}
//
//	public void setRole(RolesEnum role) {
//		this.role = role;
//	}
//}
