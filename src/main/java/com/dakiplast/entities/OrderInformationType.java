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

import com.dakiplast.enums.OrderInformationTypes;

@Entity
@Table(name = "Order_information_type")
@NamedQueries({
	@NamedQuery( name = "OrderInformationType.findByType", query = "Select o from OrderInformationType o where o.type = :type"),
	@NamedQuery( name = "OrderInformationType.findOptionsByType", query = "Select o.data from OrderInformationType o where o.type = :type"),
	@NamedQuery( name = "OrderInformationType.findAll", query = "Select o from OrderInformationType o")
})
public class OrderInformationType implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Long id;
	
	@Column(name = "type")
	@Enumerated(EnumType.STRING)
	private OrderInformationTypes type;
	
	@Column(name = "data")
	private String data;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public OrderInformationTypes getType() {
		return type;
	}

	public void setType(OrderInformationTypes type) {
		this.type = type;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}
}
