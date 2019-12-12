package com.dakiplast.requests;

public class MosquitoRequest {

	private String sort;
	private String type;
	private String openSide;
	private Long width;
	private Long height;
	private Long price;
	private Long quantity;

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

	public Long getQuantity() {
		return quantity;
	}

	public void setQuantity(Long quantity) {
		this.quantity = quantity;
	}

	public Long getPrice() {
		return price;
	}

	public void setPrice(Long price) {
		this.price = price;
	}
}
