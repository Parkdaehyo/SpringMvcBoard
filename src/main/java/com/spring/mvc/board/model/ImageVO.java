package com.spring.mvc.board.model;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Date;

public class ImageVO {

	
	private int imageFileNO;
	private String imageFileName;
	private Date regDate;
	private int boardNo;
	
	private String originImageFileName;
	
	
	
	public int getImageFileNO() {
		return imageFileNO;
	}
	public void setImageFileNO(int imageFileNO) {
		this.imageFileNO = imageFileNO;
	}
	
	public String getImageFileName() {
		try {
		if (imageFileName != null && imageFileName.length() != 0) {
		this.imageFileName = URLDecoder.decode(imageFileName, "UTF-8");
		}
		} catch (UnsupportedEncodingException e) {
		e.printStackTrace();
		}
		return imageFileName;
		}
		
		//2021-06-10 수정내역
		/*
		 * setImageFileName이 if문으로 설정해놓지 않으니,
		 * 실제로 imageFileName이 ""임에도 불구하고 실제로 ""로 들어가서 쿼리상에 오류를 일으켰던 것이다. (ImageVO2 처럼 바꿨다.)
		 */
		public void setImageFileName(String imageFileName) {
			try {
				if(imageFileName!= null && imageFileName.length()!=0) {
					this.imageFileName = URLEncoder.encode(imageFileName,"UTF-8");
				}
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		
	public String getOriginImageFileName() {
		return originImageFileName;
	}
	public void setOriginImageFileName(String originImageFileName) {
		this.originImageFileName = originImageFileName;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	
	
	
	
}
