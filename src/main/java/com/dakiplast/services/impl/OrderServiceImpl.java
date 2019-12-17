package com.dakiplast.services.impl;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dakiplast.entities.interfaces.IClient;
import com.dakiplast.entities.interfaces.IOrder;
import com.dakiplast.enums.OrderStatus;
import com.dakiplast.repository.OrderRepository;
import com.dakiplast.requests.ClientRequest;
import com.dakiplast.requests.DoorRequest;
import com.dakiplast.requests.MosquitoRequest;
import com.dakiplast.requests.OrderRequest;
import com.dakiplast.requests.ShutterRequest;
import com.dakiplast.requests.ThresholdRequest;
import com.dakiplast.requests.WindowRequest;
import com.dakiplast.services.ClientService;
import com.dakiplast.services.OrderService;
import com.dakiplast.services.WorkerService;
import com.google.gson.Gson;

@Service
public class OrderServiceImpl implements OrderService {

		@Autowired
		private OrderRepository orderRepository;
		@Autowired 
		private ClientService clientService;
		@Autowired
		private WorkerService workerService;
		
		@Override
		public IOrder create(OrderRequest orderRequest, Long createdBy) {
			
			List<DoorRequest> doors 		  = orderRequest.getDoors();
			List<ThresholdRequest> thresholds = orderRequest.getThresholds();
			List<MosquitoRequest> mosquitos	  = orderRequest.getMosquitos();
			List<WindowRequest> windows 	  = orderRequest.getWindows();
			List<ShutterRequest> shutters 	  = orderRequest.getShutters();
			Long clientId 					  = orderRequest.getClientId();
			ClientRequest clientRequest 	  = orderRequest.getCreateClient();
			List<Long> workerIds		      = orderRequest.getWorkerIds();
			Long buildDateMillis 			  = orderRequest.getBuildDate();
			boolean oldClientIsChosen		  = orderRequest.isOldClientIsChosen();
			OrderStatus	status 				  = orderRequest.getOrderStatus();
			IClient client;
			
			if (oldClientIsChosen && clientId == null) {
				return null;
			}
			
			if (oldClientIsChosen) {
				client = clientService.getClientById(clientId);
				if (client == null) {
					return null;
				}	
			}
			
			if (!oldClientIsChosen && clientRequest == null) {
				return null;
			}
			
			if (!oldClientIsChosen) {
				client = clientService.create(clientRequest, createdBy);
				if (client == null) {
					return null;
				}
			}
			
			if (workerIds == null || workerIds.isEmpty()) {
				return null;
			}
			
//			IWorker worker = workerService.getById(workerId);
//			if (worker == null) {
//				return null;
//			}
			
			if (buildDateMillis == null) {
				return null;
			}
			Gson gson = new Gson();
			String workerIdsJson = gson.toJson(workerIds);
			IOrder order = orderRepository.create(createdBy, Calendar.getInstance(), clientId, workerIdsJson, 0L, 0L, status);
			Long saldo = 0L;
			// TODO: order id
			Long orderId = order.getId();
			if (doors != null) {
				String sort;
				String type;
				String openSide;
				String glass;
				Long width;
				Long height;
				Long innerWidth;
				Long price;
				Long quantity;
				for (DoorRequest door: doors) {
					if (door.getQuantity() < 1) {
						continue;
					}
					
					sort = door.getSort().trim();
					type = door.getType().trim();
					openSide = door.getOpenSide().trim();
					glass = door.getGlass().trim();
					width = door.getWidth();
					height = door.getHeight();
					innerWidth = door.getInnerWidth();
					quantity = door.getQuantity();
					price = door.getPrice() * quantity;
					saldo += price;
					orderRepository.createOrderDoor(sort, type, openSide, glass, width, height, innerWidth, price, quantity, orderId);
				}
			}
			
			if (thresholds != null) {
				String sort;
				Long width;
				Long height;
				Long innerWidth;
				Long price;
				Long quantity;
				for (ThresholdRequest threshold: thresholds) {
					if (threshold.getQuantity() < 1) {
						continue;
					}
					sort = threshold.getSort();
					width = threshold.getWidth();
					height = threshold.getHeight();
					innerWidth = threshold.getInnerWidth();
					quantity = threshold.getQuantity();
					price = threshold.getPrice() * quantity;
					saldo += price;
					orderRepository.createOrderThreshold(sort, width, height, innerWidth, price, quantity, orderId);
				}
			}
			if (mosquitos != null) {
				String sort;
				String type;
				String openSide;
				Long width;
				Long height;
				Long quantity;
				Long price;
				for (MosquitoRequest mosquito: mosquitos) {
					if (mosquito.getQuantity() < 1) {
						continue;
					}
					sort = mosquito.getSort().trim();
					type = mosquito.getType().trim();
					openSide = mosquito.getOpenSide();
					width = mosquito.getWidth();
					height = mosquito.getHeight();
					quantity = mosquito.getQuantity();
					price = mosquito.getPrice() * quantity;
					saldo += price;
					orderRepository.createOrderMosquitoRepeller(sort, type, openSide, width, height, price, quantity, orderId);
				}
			}
			
			if (windows != null) {
				String sort;
				String glass;
				String openSide;
				boolean tipper;
				Long width;
				Long height;
				Long innerWidth;
				Long price;
				Long quantity;
				for (WindowRequest window: windows) {
					if (window.getQuantity() < 1) {
						continue;
					}
					
					sort = window.getSort();
					glass = window.getGlass();
					openSide = window.getOpenSide();
					tipper = window.isTipper();
					width = window.getWidth();
					height = window.getHeight();
					innerWidth = window.getInnerWidth();
					quantity = window.getQuantity();
					price = window.getPrice() * quantity;;
					saldo += price;
					orderRepository.createOrderWindow(sort, openSide, glass, tipper, width, height, innerWidth, price, quantity, orderId);
				}
			}
			
			if (shutters != null) {
				String sort, box, boxType, openSide;
				Long width, height, price, quantity;
				for (ShutterRequest shutter: shutters) {
					if (shutter.getQuantity() < 1) {
						continue;
					}
					
					sort = shutter.getSort();
					box = shutter.getBox();
					boxType = shutter.getBoxType();
					openSide = shutter.getOpenSide();
					width = shutter.getWidth();
					height = shutter.getHeight();
					quantity = shutter.getQuantity();
					price = shutter.getPrice();
					saldo += price;
					orderRepository.createOrderShutter(sort, box, boxType, openSide, width, height, price, quantity, orderId);
				}
			}
			
			orderRepository.setSaldo(orderId, saldo);
			return order;
		}

		@Override
		public IOrder getById(Long orderId) {
			return orderRepository.getById(orderId);
		}

		@Override
		public IOrder setAccepted(Long orderId) {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public IOrder setDeclined(Long orderId) {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public IOrder setFinished(Long orderId) {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public List<IOrder> getAll() {
			return orderRepository.getAll();
		}
		
	
}
