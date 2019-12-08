package com.dakiplast.services.impl;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dakiplast.entities.interfaces.IClient;
import com.dakiplast.entities.interfaces.IOrder;
import com.dakiplast.entities.interfaces.IWorker;
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
			Long workerId 				      = orderRequest.getWorkerId();
			Long buildDateMillis 			  = orderRequest.getBuildDate();
			boolean oldClientIsChosen		  = orderRequest.isOldClientIsChosen();
			
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
			
			if (workerId == null) {
				return null;
			}
			
			IWorker worker = workerService.getById(workerId);
			if (worker == null) {
				return null;
			}
			
			if (buildDateMillis == null) {
				return null;
			}
			
			IOrder order = orderRepository.create(createdBy, Calendar.getInstance(), clientId, workerId, 1000L, 0L);
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
				for (DoorRequest door: doors) {
					if (door.getCount() < 1) {
						continue;
					}
					
					sort = door.getSort().trim();
					type = door.getType().trim();
					openSide = door.getOpenSide().trim();
					glass = door.getGlass().trim();
					width = door.getWidth();
					height = door.getHeight();
					innerWidth = door.getInnerWidth();
					price = door.getPrice();
					
					for(int i=0; i<door.getCount(); i++) {
						orderRepository.createOrderDoor(sort, type, openSide, glass, width, height, innerWidth, price, orderId);
					}
				}
			}
			
			if (thresholds != null) {
				String sort;
				Long width;
				Long height;
				Long innerWidth;
				Long price;
				for (ThresholdRequest threshold: thresholds) {
					if (threshold.getCount() < 1) {
						continue;
					}
					sort = threshold.getSort();
					width = threshold.getWidth();
					height = threshold.getHeight();
					innerWidth = threshold.getInnerWidth();
					price = threshold.getPrice();
					
					for(int i=0; i<threshold.getCount(); i++) {
						orderRepository.createOrderThreshold(sort, width, height, innerWidth, price, orderId);
					}
				}
			}
			if (mosquitos != null) {
				String sort;
				String type;
				String openSide;
				Long width;
				Long height;
				Long price;
				for (MosquitoRequest mosquito: mosquitos) {
					if (mosquito.getCount() < 1) {
						continue;
					}
					sort = mosquito.getSort().trim();
					type = mosquito.getType().trim();
					openSide = mosquito.getOpenSide();
					width = mosquito.getWidth();
					height = mosquito.getHeight();
					price = mosquito.getPrice();
					
					for(int i=0; i<mosquito.getCount(); i++) {
						orderRepository.createOrderMosquitoRepeller(sort, type, openSide, width, height, price, orderId);
					}
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
				for (WindowRequest window: windows) {
					if (window.getCount() < 1) {
						continue;
					}
					
					sort = window.getSort();
					glass = window.getGlass();
					openSide = window.getOpenSide();
					tipper = window.isTipper();
					width = window.getWidth();
					height = window.getHeight();
					innerWidth = window.getInnerWidth();
					price = window.getPrice();
					
					for(int i=0; i<window.getCount(); i++) {
						orderRepository.createOrderWindow(sort, openSide, glass, tipper, width, height, innerWidth, price, orderId);
					}
				}
			}
			
			if (shutters != null) {
				String sort, box, boxType, openSide;
				Long width, height, price;
				for (ShutterRequest shutter: shutters) {
					if (shutter.getCount() < 1) {
						continue;
					}
					
					sort = shutter.getSort();
					box = shutter.getBox();
					boxType = shutter.getBoxType();
					openSide = shutter.getOpenSide();
					width = shutter.getWidth();
					height = shutter.getHeight();
					price = shutter.getPrice();
					
					for (int i=0; i<shutter.getCount(); i++) {
						orderRepository.createOrderShutter(sort, box, boxType, openSide, width, height, price, orderId);
					}
				}
			}
			
			
			return null;
		}

		@Override
		public IOrder getById(Long orderId) {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public IOrder getAll() {
			// TODO Auto-generated method stub
			return null;
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
		
	
}
