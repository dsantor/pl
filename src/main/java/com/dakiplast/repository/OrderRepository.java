package com.dakiplast.repository;

import java.util.Calendar;

import com.dakiplast.entities.interfaces.IOrder;
import com.dakiplast.entities.interfaces.IOrderDoor;
import com.dakiplast.entities.interfaces.IOrderMosquitoRepeller;
import com.dakiplast.entities.interfaces.IOrderShutter;
import com.dakiplast.entities.interfaces.IOrderThreshold;
import com.dakiplast.entities.interfaces.IOrderWindow;

public interface OrderRepository {

	IOrder getById(Long orderId);
	IOrder create(Long createdBy, Calendar createdAt, Long clientId, Long workerId, Long saldo, Long paid);
	IOrder declinedOrder(Long orderId);
	IOrder acceptedOrder(Long orderId);
	IOrder finishedOrder(Long orderId);
	
	IOrderDoor createOrderDoor(String sort, String type, String openSide, String glass, Long width, Long height, Long innerWidth, Long price, Long orderId);
	IOrderShutter createOrderShutter(String sort, String box, String boxType, String openSide, Long width, Long height, Long price, Long orderId);
	IOrderThreshold createOrderThreshold(String sort, Long width, Long height, Long innerWidth, Long price, Long orderId);
	IOrderWindow createOrderWindow(String sort, String openSide, String glass, boolean tipper, Long width, Long height, Long innerWidth, Long price, Long orderId);
	IOrderMosquitoRepeller createOrderMosquitoRepeller(String sort, String type, String openSide, Long width,
			Long height, Long price, Long orderId);
}
