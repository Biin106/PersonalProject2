package model.bbs;


import java.sql.Date;


//DTO(Data Tranfer Object):데이타를 전송하는 객체로 테이블의 레코드 하나를 저장할 수 있는 자료구조
public class BbsDTO {
	
	private long id;
	private String username;
	private String title;
	private String content;
	private long hitCount;
	private Date postDate;
	

	
	
	//생성자]
	public BbsDTO() {}
	public BbsDTO(long id, String username, String title, String content, long hitCount, Date postDate) {
		
		this.id = id;
		this.username = username;
		this.title = title;
		this.content = content;
		this.hitCount = hitCount;
		this.postDate = postDate;
	}
	//게터/세터]
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public long getHitCount() {
		return hitCount;
	}
	public void setHitCount(long hitCount) {
		this.hitCount = hitCount;
	}
	public Date getPostDate() {
		return postDate;
	}
	public void setPostDate(Date postDate) {
		this.postDate = postDate;
	}
	
}

