package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn; // �ڹٿ� DB�� ����
	private PreparedStatement pstmt; // ������ ��� �� ����
	private ResultSet rs; // ���� ����� �޾ƿ���
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/myBBS_db";
			String dbID = "root";
			String dbPassword = "asd123";
			
			Class.forName("com.mysql.cj.jdbc.Driver"); // jdbc ����̹� �ε�
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // Ŀ�ؼ� ��ü �����Ͽ� conn �ʵ忡 ����
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public int login(String userID, String userPassword) {
		String sql = "select userPassword from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(sql); // '?'�� �ִ� �ҿ����� �������� ���� �� ���
			pstmt.setString(1, userID); // ����Ų �������� ù ��° '?'�� userID ����
			rs = pstmt.executeQuery(); // ���� ���� ��� rs�� ����
			
			// ���̵� �ִ� ���
			if(rs.next()) { 
				if(rs.getString(1).equals(userPassword)) {
					return 1; // �α��� ����
				}
				else {
					return 0; // ��й�ȣ Ʋ��
				}
			}
			// ���̵� ����
			return -1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2; // ����
	}
}
