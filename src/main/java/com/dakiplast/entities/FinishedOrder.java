package com.dakiplast.entities;

import java.io.Serializable;
import java.util.Calendar;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.dakiplast.entities.interfaces.IFinishedOrder;

@Entity
@Table(name = "finished_order")
public class FinishedOrder implements Serializable, IFinishedOrder {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Long id;
	
	@Column(name = "built_by")
	private String buildByFullName;
	
	@Column(name = "built_at")
	private Calendar buildAt;
	
	@Column(name = "note")
	private String note;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getBuildByFullName() {
		return buildByFullName;
	}

	public void setBuildByFullName(String buildByFullName) {
		this.buildByFullName = buildByFullName;
	}

	public Calendar getBuildAt() {
		return buildAt;
	}

	public void setBuildAt(Calendar buildAt) {
		this.buildAt = buildAt;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
}
