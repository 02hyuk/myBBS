package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
	// ���� �������� �� �Խñ� ����Ʈ �޼ҵ�
	public ArrayList<Bbs> getList(int pageNumber){
		// bbsID�� � ���ں��� �۰� bbsAvailable�� 1�� ���� ������������ �ִ� 10�� ���� 
		String sql = "select * from bbs where bbsID < ? and bbsAvailable = 1 order by bbsID desc limit 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext()-(pageNumber - 1) * 10); // ?�� �� ����: �� �������� ������ �Խñ��� id
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	// ����¡ ó�� �޼ҵ� - �������� �����ϴ��� Ȯ��
	public boolean isPageExist(int pageNumber) {
		String sql = "select * from bbs where bbsID < ? and bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	// id�� �´� Bbs ��ü ��ȯ�ϴ� �޼ҵ�
	public Bbs getBbs(int bbsID) {
		String sql = "select * from bbs where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String sql = "update bbs set bbsTitle = ?, bbsContent = ? where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate(); // pstmt �ȿ� ����ִ� sql�� ������ �� ��ȭ�� ��� ����(1 ����)
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	public int delete(int bbsID) {
		// ������ �����͸� �����ϴ� ���� �ƴ�, ��ȿ����(bbsAvailable)�� 0���� �ٲ���
		String sql = "update bbs set bbsAvailable = 0 where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate(); // pstmt �ȿ� ����ִ� sql�� ������ �� ��ȭ�� ��� ����(1 ����)
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
		
	}
}
