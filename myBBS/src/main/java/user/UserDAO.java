package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn; // 자바와 DB를 연결
	private PreparedStatement pstmt; // 쿼리문 대기 및 설정
	private ResultSet rs; // 쿼리 결과값 받아오기
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/myBBS_db";
			String dbID = "root";
			String dbPassword = "asd123";
			
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc 드라이버 로딩
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // 커넥션 객체 연결하여 conn 필드에 대입
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public int login(String userID, String userPassword) {
		String sql = "select userPassword from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(sql); // '?'가 있는 불완전한 쿼리문을 셋팅 및 대기
			pstmt.setString(1, userID); // 대기시킨 쿼리문의 첫 번째 '?'에 userID 대입
			rs = pstmt.executeQuery(); // 쿼리 실행 결과 rs에 저장
			
			// 아이디가 있는 경우
			if(rs.next()) { 
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공
				}
				else {
					return 0; // 비밀번호 틀림
				}
			}
			// 아이디 없음
			return -1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2; // 오류
	}
	public int join(User user) {
		String sql = "insert into user values(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate(); // pstmt로 실행한 DML에 의해 업데이트된 행의 수(여기선 1개니까 1) 리턴
		} catch(Exception e) {
			e.printStackTrace();
		}
		// pstmt에 들어있는 쿼리를 제대로 실행하지 못했다면 -1 리턴
		return -1;
	}
}
