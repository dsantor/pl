package com.dakiplast.requests;

public class ThresholdRequest {
    private String sort;
    private Long width;
    private Long height;
    private Long innerWidth;
    private Long price;
    private Long quantity;

    public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
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
	public Long getInnerWidth() {
		return innerWidth;
	}
	public void setInnerWidth(Long innerWidth) {
		this.innerWidth = innerWidth;
	}
	public Long getPrice() {
		return price;
	}
	public void setPrice(Long price) {
		this.price = price;
	}
	public Long getQuantity() {
		return quantity;
	}
	public void setQuantity(Long quantity) {
		this.quantity = quantity;
	}
}
