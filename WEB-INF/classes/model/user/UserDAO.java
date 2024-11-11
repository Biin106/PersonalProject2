package model.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import oracle.jdbc.pool.OracleDataSource;

public class UserDAO {
	
	private DataSource dataSource;
	
	public UserDAO() {
	    try {
	        Context ctx = new InitialContext();
	        this.dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/ICTUSER"); // JNDI 이름
	    } catch (NamingException e) {
	        e.printStackTrace();
	    }
	}

	//// 데이터베이스 연결 설정
	private static final String jdbcURL = "jdbc:oracle:thin:@localhost:1521/XEPDB1";
	private static final String jdbcUsername = "ICTUSER";
	private static final String jdbcPassword = "ICT1234";

	//// 데이터베이스 연결
	private static Connection getConnection() throws SQLException {
	    OracleDataSource dataSource = new OracleDataSource();
	    dataSource.setURL(jdbcURL);
	    dataSource.setUser(jdbcUsername);
	    dataSource.setPassword(jdbcPassword);
	    return dataSource.getConnection();
	}

	//// 회원 저장 메소드
	public boolean saveUser(UserDTO user) {
	    String INSERT_USERS_SQL = "INSERT INTO USERS " +
	            "(username, password, passwordConfirm, gender, interests, grade, self, token) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

	    try (Connection connection = getConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USERS_SQL)) {
	        preparedStatement.setString(1, user.getUsername());
	        preparedStatement.setString(2, user.getPassword());
	        preparedStatement.setString(3, user.getPasswordConfirm());
	        preparedStatement.setString(4, user.getGender());
	        preparedStatement.setString(5, String.join(",", user.getInterests())); // 배열을 문자열로 변환하여 저장
	        preparedStatement.setString(6, user.getGrade());
	        preparedStatement.setString(7, user.getSelf());
	        preparedStatement.setString(8, user.getToken());

	        int result = preparedStatement.executeUpdate();
	        return result > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	////중복 가입 방지용 메서드
	public boolean checkUsernameExists(String username) {
	    try (Connection conn = dataSource.getConnection();
	         PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM users WHERE username = ?")) {
	        ps.setString(1, username);
	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                int count = rs.getInt(1);
	                return count > 0;
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	////로그인 확인용 메서드
	public boolean validateUser(String username, String password) {
	    try (Connection conn = dataSource.getConnection();
	         PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM users WHERE username = ? AND password = ?")) {
	        ps.setString(1, username);
	        ps.setString(2, password);
	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                int count = rs.getInt(1);
	                return count > 0;
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	// 회원 가입 후 토큰 발급 메서드
	public String issueToken(String username) {
	    String token = UUID.randomUUID().toString();
	    
	    try (Connection conn = dataSource.getConnection();
	         PreparedStatement ps = conn.prepareStatement("UPDATE users SET token = ? WHERE username = ?")) {
	        ps.setString(1, token);
	        ps.setString(2, username);
	        ps.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    
	    return token;
	}

	// 토큰 유효성 검사 메서드
	public boolean validateToken(String username, String token) {
	    try (Connection conn = dataSource.getConnection();
	         PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM users WHERE username = ? AND token = ?")) {
	        ps.setString(1, username);
	        ps.setString(2, token);
	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                int count = rs.getInt(1);
	                return count > 0;
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	public boolean validateUser(String username, String password, String token) {
	    try (Connection conn = dataSource.getConnection();
	         PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM users WHERE username = ? AND password = ? AND token = ?")) {
	        ps.setString(1, username);
	        ps.setString(2, password);
	        ps.setString(3, token);
	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                int count = rs.getInt(1);
	                return count > 0;
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}
}

