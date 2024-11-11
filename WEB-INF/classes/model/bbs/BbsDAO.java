package model.bbs;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import jakarta.servlet.ServletContext;

import service.DAOService;

//DAO(Data Access Object):데이타에 접근해서 CRUD작업을 수행하는 업무처리 로직을 갖고 있는 객체
public class BbsDAO implements DAOService<BbsDTO> {

	//필드]
	private Connection conn;
	private ResultSet rs;
	private PreparedStatement psmt;
	
	//생성자]
	public BbsDAO(ServletContext context) {
	    try {
	        Context initContext = new InitialContext();
	        Context envContext = (Context) initContext.lookup("java:comp/env");
	        DataSource dataSource = (DataSource) envContext.lookup("jdbc/ICTUSER");
	        conn = dataSource.getConnection();
	    } catch (NamingException | SQLException e) {
	        e.printStackTrace();
	    }
	}
	
	//자원반납용]
	@Override
	public void close() {
		try {
			if(rs !=null) rs.close();
			if(psmt !=null) psmt.close();
			if(conn !=null) conn.close();
		}
		catch(SQLException e) {}
	}/////
	//전체 목록 가져오기]
	/*
	 * 페이징 로직 추가하기
	 * DAO에서 할일
	 * 1. 전체 목록 쿼리를 구간 쿼리 혹은 RANK()함수로 변경
	 * 2. 총 레코드수 구하는 메소드 추가	
	 * JSP에서는 
	 * List.jsp에 페이징 관련 코드 추가
	 */
	public List<BbsDTO> findAll(Map<String, String> map) {
	    List<BbsDTO> items = new ArrayList<>();

	    String sql = "SELECT b.id, b.title, b.content, b.hitcount, b.postdate, b.username "
	               + "FROM bbs b ";

	    // 검색 조건 추가
	    if (map.get("searchColumn") != null) {
	        if ("username".equals(map.get("searchColumn"))) {
	            sql += "WHERE b.username LIKE '%" + map.get("searchWord") + "%' ";
	        } else {
	            sql += "WHERE " + map.get("searchColumn") + " LIKE '%" + map.get("searchWord") + "%' ";
	        }
	    }

	    sql += "ORDER BY b.id DESC";

	    try {
	        psmt = conn.prepareStatement(sql);
	        rs = psmt.executeQuery();

	        while (rs.next()) {
	            BbsDTO item = new BbsDTO();
	            item.setId(rs.getInt("id"));
	            item.setTitle(rs.getString("title"));
	            item.setContent(rs.getString("content"));
	            item.setHitCount(rs.getInt("hitcount"));
	            item.setPostDate(rs.getDate("postdate"));
	            item.setUsername(rs.getString("username"));

	            items.add(item);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        // 자원 해제
	        close();
	    }

	    return items;
	}

	
	
	
	//총 레코드 수 얻기용
	@Override
	public int getTotalRecordCount(Map<String,String> map) {
		int totalRecordCount=0;
		String sql="SELECT COUNT(*) FROM bbs b JOIN users u ON b.username=u.username ";
		//검색시 아래 쿼리 추가
		if(map !=null && map.get("searchColumn") !=null) {
			sql+=" WHERE "+map.get("searchColumn") + " LIKE '%"+map.get("searchWord")+"%' ";
		}
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			rs.next();
			totalRecordCount= rs.getInt(1);
		}
		catch(SQLException e) {e.printStackTrace();}
		return totalRecordCount;
	}//////////////////
	//상세보기용-레코드 하나 조회
	@Override
	public BbsDTO findById(String ... params) {
		BbsDTO item=null;
		
		try {
			
			//목록에서 넘어온 경우에만
			if(params.length >=2 && params[1].toUpperCase().startsWith("BBSLIST")) {
				//조회수 증가
				psmt = conn.prepareStatement("UPDATE bbs SET hitcount= hitcount+1 WHERE id=?");
				psmt.setString(1, params[0]);
				psmt.executeUpdate();
			}
				
			//레코드 하나 조회
			psmt = conn.prepareStatement("SELECT b.*,name FROM bbs b JOIN users u ON b.username=u.username WHERE id=?");
			psmt.setString(1, params[0]);
			rs = psmt.executeQuery();
			if(rs.next()) {
				item = new BbsDTO();
				item.setContent(rs.getString(4));
				item.setHitCount(rs.getInt(5));
				item.setId(rs.getInt(1));
				item.setPostDate(rs.getDate(6));
				item.setTitle(rs.getString(3));
				item.setUsername(rs.getString(2));
			}
		}
		catch(SQLException e) {e.printStackTrace();}
		return item;
	}
	//이전글/다음글 조회
	public Map<String, BbsDTO> prevNext(String curentId){
		Map<String, BbsDTO> map = new HashMap<>();
		try {
			//이전글 얻기]
			psmt = conn.prepareStatement("SELECT id,title FROM bbs WHERE id=(SELECT MAX(id) FROM bbs WHERE id < ?)");
			psmt.setString(1,curentId);
			rs = psmt.executeQuery();
			if(rs.next()) {
				map.put("PREV", new BbsDTO(rs.getLong(1), null, rs.getString(2), null, 0, null));
			}
			
			//다음글 얻기]
			psmt = conn.prepareStatement("SELECT id,title FROM bbs WHERE id=(SELECT MIN(id) FROM bbs WHERE id > ?)");
			psmt.setString(1,curentId);
			rs = psmt.executeQuery();
			if(rs.next()) {
				map.put("NEXT", new BbsDTO(rs.getLong(1), null, rs.getString(2), null, 0, null));
			}
			
		}
		catch(SQLException e) {e.printStackTrace();}
		
		return map;
	}	
	
	//입력용
	@Override
	public int insert(BbsDTO dto) {
		int affected=0;
		try {
			psmt = conn.prepareStatement("INSERT INTO BBS VALUES(SEQ_BBS.NEXTVAL,?,?,?,DEFAULT,DEFAULT)");
			psmt.setString(1, dto.getUsername());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			affected=psmt.executeUpdate();
			
			rs = psmt.getGeneratedKeys();
			if (rs.next()) {
			    dto.setId(rs.getLong(1)); // 삽입된 ID를 DTO에 설정
			}
			
		}
		catch(SQLException e) {e.printStackTrace();}
		return affected;
	}////////////

	@Override
	public int update(BbsDTO dto) {
		int affected=0;
		try {
			psmt = conn.prepareStatement("UPDATE bbs SET title=?,content=? WHERE id=?");
			psmt.setLong(3, dto.getId());
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			affected=psmt.executeUpdate();
			
		}
		catch(SQLException e) {e.printStackTrace();}
		return affected;
	}
	//삭제용
	@Override
	public int delete(BbsDTO dto) {
		int affected=0;
		try {
			psmt = conn.prepareStatement("DELETE FROM bbs WHERE id=?");
			psmt.setLong(1, dto.getId());
			affected = psmt.executeUpdate();
		}
		catch(SQLException e) {e.printStackTrace();}
		return affected;
	}
	
	//회원여부 판단용]
	public boolean isUser(String username,String password) {
		try {
			psmt = conn.prepareStatement("SELECT COUNT(*) FROM users WHERE username=? AND password=?");
			psmt.setString(1, username);
			psmt.setString(2, password);
			rs = psmt.executeQuery();
			rs.next();
			if(rs.getInt(1)==0) return false;
		
		}
		catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

}////
