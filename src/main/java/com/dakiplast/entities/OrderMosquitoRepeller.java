package com.dakiplast.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.dakiplast.entities.interfaces.IOrderMosquitoRepeller;

@Entity
@Table(name = "order_mosquito_repeller")
public class OrderMosquitoRepeller implements Serializable, IOrderMosquitoRepeller {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Long id;
	
	@Column(name = "sort")
    private String sort;
	
	@Column(name = "type")
    private String type;
	
	@Column(name = "openSide")
    private String openSide;
	
	@Column(name = "width")
    private Long width;
	
	@Column(name = "height")
    private Long height;
	
	@Column(name = "price")
    private Long price;
	
	@Column(name = "quantity")
	private Long quantity;
	
	@Column(name = "order_id")
	private Long orderId;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getOpenSide() {
		return openSide;
	}

	public void setOpenSide(String openSide) {
		this.openSide = openSide;
	}

	public Long getWidth() {
		return width;
	}

	public void setWidth(Long width) {
		this.width = width;
	}

	public Long getHeight() {
		return height;
	}

	public void setHeight(Long height) {
		this.height = height;
	}

	public Long getOrderId() {
		return orderId;
	}

	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}

	public Long getPrice() {
		return price;
	}

	public void setPrice(Long price) {
		this.price = price;
	}

	public Long getQuantity() {
		return quantity;
	}

	public void setQuantity(Long quantity) {
		this.quantity = quantity;
	}
}
