package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BbsDAO {
	private Connection conn; // �ڹٿ� DB�� ����
	private ResultSet rs; // ���� ����� �޾ƿ���
	
	public BbsDAO() {
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
	// ���� ��¥�� �ð�(�Խñ� �ۼ�����) ��ȯ�ϴ� �޼ҵ�
	public String getDate() {
		String sql = "select now()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return ""; // �����ͺ��̽� ����
	}
	// (����)�Խñ� ��ȣ �ο� �޼ҵ�
	public int getNext() {
		// ���� �Խñ��� ������������ ��ȸ�Ͽ� ���� ������ ���� ��ȣ ���ϱ�
		String sql = "select bbsID from bbs order by bbsID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // ù ��° �Խù��� ���(������ ���� X)
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	// �۾��� �޼ҵ� - writeAction.jsp���� ȣ��
	public int write(String bbsTitle, String userID, String bbsContent) {
		String sql = "insert into bbs values(?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1); // ���� ��ȿ��ȣ
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
}
