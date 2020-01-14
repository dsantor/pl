package com.dakiplast.services;

import java.util.List;
import java.util.Map;

import com.dakiplast.entities.dto.DoorSettingsDto;
import com.dakiplast.enums.OrderInformationTypes;
import com.dakiplast.responses.DoorSettingsResponse;

public interface SettingsService {

	boolean saveOrderInformationTypes(OrderInformationTypes orderInformationType, List<String> data);

	DoorSettingsResponse getDoorSettings();

	DoorSettingsDto converToDto(DoorSettingsResponse data);

	Map<String, String[]> getAllOrderTypes();
}
