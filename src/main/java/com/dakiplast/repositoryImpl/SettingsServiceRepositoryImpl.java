package com.dakiplast.repositoryImpl;

import java.lang.reflect.Type;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dakiplast.entities.OrderInformationType;
import com.dakiplast.enums.OrderInformationTypes;
import com.dakiplast.repository.SettingsServiceRepository;
import com.dakiplast.responses.DoorSettingsResponse;
import com.google.gson.Gson;

@Repository
@Transactional
@SuppressWarnings("unchecked")
public class SettingsServiceRepositoryImpl implements SettingsServiceRepository {

	@Autowired
	private EntityManager entityManager;
	
	@Override
	public boolean saveOrderInformationTypes(OrderInformationTypes orderInformationType, List<String> data) {
		Query query = entityManager.createNamedQuery("OrderInformationType.findByType").setParameter("type", orderInformationType);
		
		List<OrderInformationType> list = query.getResultList();
		OrderInformationType entity = new OrderInformationType();
		String dataString = new Gson().toJson(data);
		if (list.size() == 0) {
			entity.setType(orderInformationType);
			entity.setData(dataString);
			entityManager.persist(entity);
		} else {
			entity = list.get(0);
			entity.setType(orderInformationType);
			entity.setData(dataString);
			entityManager.merge(entity);
		}
		return true;
	}

	@Override
	public DoorSettingsResponse getDoorSettings() {
		Query querySort  = entityManager.createNamedQuery("OrderInformationType.findOptionsByType").setParameter("type", OrderInformationTypes.DOOR_SORT);
		Query queryType  = entityManager.createNamedQuery("OrderInformationType.findOptionsByType").setParameter("type", OrderInformationTypes.DOOR_TYPE);
		Query queryGlass = entityManager.createNamedQuery("OrderInformationType.findOptionsByType").setParameter("type", OrderInformationTypes.DOOR_GLASS);
		
		DoorSettingsResponse result = new DoorSettingsResponse();
		List<String> sortList  = querySort.getResultList();
		List<String> typeList  = queryType.getResultList();
		List<String> glassList = queryGlass.getResultList();
		
		if (!sortList.isEmpty()) {
			sortList = Arrays.asList(new Gson().fromJson(sortList.get(0), String[].class));
		}
		if (!typeList.isEmpty()) {
			typeList = Arrays.asList(new Gson().fromJson(typeList.get(0), (Type) String[].class));
		}
		if (!glassList.isEmpty()) {
			glassList = Arrays.asList(new Gson().fromJson(glassList.get(0), (Type) String[].class));
		}
		result.setDoorSorts(sortList);
		result.setDoorTypes(typeList);
		result.setDoorGlass(glassList);
		return result;
	}

	@Override
	public Map<String, String[]> getAllOrderTypes() {
		Query query = entityManager.createNamedQuery("OrderInformationType.findAll");
		List<OrderInformationType> orderInformationTypes = query.getResultList();
		Map<String, String[]> data = new HashMap<>();
		for(OrderInformationType item : orderInformationTypes) {
			String[] items = new Gson().fromJson(item.getData(), String[].class);
			data.put(item.getType().toString(), items);
		}
		return data;
	}

}
