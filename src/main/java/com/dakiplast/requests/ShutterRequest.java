package com.dakiplast.requests;

public class ShutterRequest {
    private String sort;
    private String box;
    private String boxType;
    private String openSide;
    private Long price;    
    private Long width;
    private Long height;
    private Long quantity;

    public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getBox() {
		return box;
	}
	public void setBox(String box) {
		this.box = box;
	}
	public String getBoxType() {
		return boxType;
	}
	public void setBoxType(String boxType) {
		this.boxType = boxType;
	}
	public String getOpenSide() {
		return openSide;
	}
	public void setOpenSide(String openSide) {
		this.openSide = openSide;
	}
	public Long getPrice() {
		return price;
	}
	public void setPrice(Long price) {
		this.price = price;
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
}
