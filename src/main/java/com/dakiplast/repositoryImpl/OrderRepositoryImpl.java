package com.dakiplast.repositoryImpl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dakiplast.entities.Order;
import com.dakiplast.entities.OrderDoor;
import com.dakiplast.entities.OrderMosquitoRepeller;
import com.dakiplast.entities.OrderShutter;
import com.dakiplast.entities.OrderThreshold;
import com.dakiplast.entities.OrderWindow;
import com.dakiplast.entities.interfaces.IOrder;
import com.dakiplast.entities.interfaces.IOrderDoor;
import com.dakiplast.entities.interfaces.IOrderMosquitoRepeller;
import com.dakiplast.entities.interfaces.IOrderShutter;
import com.dakiplast.entities.interfaces.IOrderThreshold;
import com.dakiplast.entities.interfaces.IOrderWindow;
import com.dakiplast.enums.OrderStatus;
import com.dakiplast.repository.OrderRepository;

@Repository
@Transactional
public class OrderRepositoryImpl implements OrderRepository {

	@Autowired
	private EntityManager entityManager;
	
	@Override
	public IOrder getById(Long orderId) {
		return entityManager.find(Order.class, orderId);
	}

	@Override
	public IOrder create(Long createdBy, Calendar createdAt, Long clientId, String workerIdsJson, Long saldo, Long paid, OrderStatus status) {
		Order entity = new Order();
		entity.setCreatedBy(createdBy);
		entity.setCreatedAt(createdAt);
		entity.setClientId(clientId);
		entity.setWorkerIdsJson(workerIdsJson);
		entity.setSaldo(saldo);
		entity.setPaid(paid);
		entity.setStatus(status);
		
		entityManager.persist(entity);
		return entity;
	}

	@Override
	public IOrder declinedOrder(Long orderId) {
		Order entity = entityManager.find(Order.class, orderId);
		entity.setStatus(OrderStatus.DECLINED);
		entityManager.merge(entity);
		return entity;
	}

	@Override
	public IOrder acceptedOrder(Long orderId) {
		Order entity = entityManager.find(Order.class, orderId);
		entity.setStatus(OrderStatus.ACCEPTED);
		entityManager.merge(entity);
		return entity;
	}

	@Override
	public IOrder finishedOrder(Long orderId) {
		Order entity = entityManager.find(Order.class, orderId);
		entity.setStatus(OrderStatus.FINISHED);
		entityManager.merge(entity);
		return entity;
	}

	@Override
	public IOrderDoor createOrderDoor(String sort, String type, String openSide, String glass, Long width, Long height, Long innerWidth, Long price, Long quantity, Long orderId) {
		OrderDoor entity = new OrderDoor();
		entity.setSort(sort);
		entity.setType(type);
		entity.setOpenSide(openSide);
		entity.setGlass(glass);
		entity.setWidth(width);
		entity.setHeight(height);
		entity.setInnerWidth(innerWidth);
		entity.setPrice(price);
		entity.setQuantity(quantity);
		entity.setOrderId(orderId);
		
		entityManager.persist(entity);
		return entity;
	}

	@Override
	public IOrderMosquitoRepeller createOrderMosquitoRepeller(String sort, String type, String openSide, Long width, Long height, Long price, Long quantity, Long orderId) {
		OrderMosquitoRepeller entity = new OrderMosquitoRepeller();
		entity.setSort(sort);
		entity.setType(type);
		entity.setOpenSide(openSide);
		entity.setWidth(width);
		entity.setHeight(height);
		entity.setPrice(price);
		entity.setQuantity(quantity);
		entity.setOrderId(orderId);
		
		entityManager.persist(entity);
		return entity;
	}

	@Override
	public IOrderShutter createOrderShutter(String sort, String box, String boxType, String openSide, Long width, Long height, Long price, Long quantity, Long orderId) {
		OrderShutter entity = new OrderShutter();
		entity.setSort(sort);
		entity.setBox(boxType);
		entity.setBoxType(boxType);
		entity.setOpenSide(openSide);
		entity.setWidth(width);
		entity.setHeight(height);
		entity.setPrice(price);
		entity.setQuantity(quantity);
		entity.setOrderId(orderId);
		
		entityManager.persist(entity);
		return entity;
	}

	@Override
	public IOrderThreshold createOrderThreshold(String sort, Long width, Long height, Long innerWidth, Long price, Long quantity, Long orderId) {
		OrderThreshold entity = new OrderThreshold();
		entity.setSort(sort);
		entity.setWidth(innerWidth);
		entity.setHeight(height);
		entity.setInnerWidth(innerWidth);
		entity.setQuantity(quantity);
		entity.setPrice(price);
		entity.setOrderId(orderId);
		
		entityManager.persist(entity);
		return entity;
	}

	@Override
	public IOrderWindow createOrderWindow(String sort, String openSide, String glass, boolean tipper, Long width, Long height, Long innerWidth, Long price, Long quantity, Long orderId) {
		OrderWindow entity = new OrderWindow();
		entity.setSort(sort);
		entity.setOpenSide(openSide);
		entity.setGlass(glass);
		entity.setTipper(tipper);
		entity.setWidth(width);
		entity.setHeight(height);
		entity.setInnerWidth(innerWidth);
		entity.setPrice(price);
		entity.setQuantity(quantity);
		entity.setOrderId(orderId);
		
		entityManager.persist(entity);
		return entity;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<IOrder> getAll() {
		Query query = entityManager.createNamedQuery("Order.findAll");
		
		List<IOrder> result = query.getResultList();
		return result == null ? new ArrayList<>() : result;
	}

	@Override
	public void setSaldo(Long orderId, Long saldo) {
		Order entity = entityManager.find(Order.class, orderId);
		entity.setSaldo(saldo);
		entityManager.merge(entity);
	}
}
