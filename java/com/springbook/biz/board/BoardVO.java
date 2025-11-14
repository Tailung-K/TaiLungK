package com.springbook.biz.board;

//import java.util.Date;
//
//import javax.xml.bind.annotation.XmlAccessType;
//import javax.xml.bind.annotation.XmlAccessorType;
//import javax.xml.bind.annotation.XmlAttribute;
//import javax.xml.bind.annotation.XmlTransient;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 
 * 1. ClassName : 
 * 2. FileName  : BoardVO.java
 * 3. Package   : com.springbook.biz.board
 * 4. Commnet   : 
 * 5. 작성자    : TaiLung-K
 * 6. 작성일    : 2025. 11. 13. 오후 5:56:02
 */
//VO(Value Object)
//@XmlAccessorType(XmlAccessType.FIELD)
public class BoardVO {
//	@XmlAttribute
	private int seq;
	private String title;
	private String writer;
	private String content;
	private String regdate;
	private int cnt;
	private int pay;
    private String rank;	
	
//	@XmlTransient
	private String searchCondition;
	
//	@XmlTransient
	private String searchKeyword;
	
//	@XmlTransient
	private MultipartFile uploadFile;
	

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

    public String getRegdate() {
        return regdate;
    }

    public void setRegdate( String regdate ) {
        this.regdate = regdate;
    }
    
    public int getPay() {
        return pay;
    }

    public void setPay( int pay ) {
        this.pay = pay;
    }
    
    public String getRank() {
        return rank;
    }

    public void setRank( String rank ) {
        this.rank = rank;
    }
    
    

    @JsonIgnore
	public String getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	
	@JsonIgnore
	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}	
	
	@JsonIgnore
	public MultipartFile getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	

    @Override	
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
    
    public String toStringJson() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
    }
    
    public String toStringMultiline() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
    }
    
    public String toStringNoClass() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.NO_CLASS_NAME_STYLE);
    }
    
    public String toStringNoFieldName() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.NO_FIELD_NAMES_STYLE);
    }
    
    public String toStringShortPrefix() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
    
    public String toStringSimple() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SIMPLE_STYLE);
    }
    
//  @Override
//  public String toString() {
//      return "BoardVO [seq=" + seq + ", title=" + title + ", writer=" + writer + ", content=" + content + ", regdate="
//              + regdate + ", cnt=" + cnt + "]";
//  }
	
}