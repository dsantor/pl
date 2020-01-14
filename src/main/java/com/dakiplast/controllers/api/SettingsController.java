package com.dakiplast.controllers.api;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dakiplast.entities.dto.DoorSettingsDto;
import com.dakiplast.enums.OrderInformationTypes;
import com.dakiplast.requests.OrderTypeRequest;
import com.dakiplast.responses.BaseResponse;
import com.dakiplast.responses.DoorSettingsResponse;
import com.dakiplast.services.SettingsService;

@RestController
@RequestMapping("/api/settings")
public class SettingsController {

	@Autowired
	private SettingsService settingsService;
	
	@PostMapping("/saveOrderTypes")
	public BaseResponse saveOrderTypes(@RequestBody OrderTypeRequest request) {
		OrderInformationTypes orderInformationType = request.getType();
		List<String> data = request.getOptions();
		settingsService.saveOrderInformationTypes(orderInformationType, data);
		return new BaseResponse(null, false, null);
	}
	
	@GetMapping("/getDoorSettings")
	public BaseResponse getDoorSettings() {
		DoorSettingsResponse data = settingsService.getDoorSettings();
		DoorSettingsDto dataDto = settingsService.converToDto(data);
		return new BaseResponse(dataDto, false, null);
	}
	
	@GetMapping("/getAllOrderTypes")
	public BaseResponse getAllOrderTypes() {
		Map<String, String[]> data = settingsService.getAllOrderTypes();
		return new BaseResponse(data, false, null);
	}
}
