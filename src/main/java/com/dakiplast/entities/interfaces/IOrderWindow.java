package com.dakiplast.entities.interfaces;

public interface IOrderWindow {
	public String getSort();
	public String getOpenSide();
	public String getGlass();
	public boolean isTipper();
	public Long getWidth();
	public Long getHeight();
	public Long getInnerWidth();
	public Long getPrice();
	public Long getOrderId();
}
