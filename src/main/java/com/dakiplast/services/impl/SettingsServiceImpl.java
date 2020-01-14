package com.dakiplast.services.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dakiplast.entities.dto.DoorSettingsDto;
import com.dakiplast.enums.OrderInformationTypes;
import com.dakiplast.repository.SettingsServiceRepository;
import com.dakiplast.responses.DoorSettingsResponse;
import com.dakiplast.services.SettingsService;

@Service
public class SettingsServiceImpl implements SettingsService {

	@Autowired
	private SettingsServiceRepository settingsServiceRepository;
	
	@Override
	public boolean saveOrderInformationTypes(OrderInformationTypes orderInformationType, List<String> data) {
		return settingsServiceRepository.saveOrderInformationTypes(orderInformationType, data);
	}

	@Override
	public DoorSettingsResponse getDoorSettings() {
		return settingsServiceRepository.getDoorSettings();
	}

	@Override
	public DoorSettingsDto converToDto(DoorSettingsResponse data) {
		DoorSettingsDto dataDto = new DoorSettingsDto();
		dataDto.setDoorSorts(data.getDoorSorts());
		dataDto.setDoorTypes(data.getDoorTypes());
		dataDto.setDoorGlass(data.getDoorGlass());
		return dataDto;
	}

	@Override
	public Map<String, String[]> getAllOrderTypes() {
		return settingsServiceRepository.getAllOrderTypes();
	}

}
