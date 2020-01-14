package com.dakiplast.repository;

import java.util.List;
import java.util.Map;

import com.dakiplast.enums.OrderInformationTypes;
import com.dakiplast.responses.DoorSettingsResponse;

public interface SettingsServiceRepository {

	boolean saveOrderInformationTypes(OrderInformationTypes orderInformationType, List<String> data);

	DoorSettingsResponse getDoorSettings();

	Map<String, String[]> getAllOrderTypes();
}
