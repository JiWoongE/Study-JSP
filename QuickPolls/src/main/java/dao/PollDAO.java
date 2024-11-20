package dao;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.*;
import dto.Poll;

public class PollDAO {
	private static final String DB_URL = "jdbc:mysql://localhost:3306/quickpollsDB";
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "12345678";

	// 투표 결과 가져오기
	public Map<String, Integer> getPollResults(int poll_id) throws SQLException {
		Map<String, Integer> results = new LinkedHashMap<>();
		String sql = "SELECT option_text, vote_count FROM poll_options WHERE poll_id = ?";

		try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, poll_id);

			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
					String optionText = rs.getString("option_text");
					int voteCount = rs.getInt("vote_count");
					results.put(optionText, voteCount);
				}
			}
		}
		return results;
	}

	// 특정 투표 가져오기
	public Poll getPollById(int poll_id) throws SQLException {
		Poll poll = null;
		String sql = "SELECT poll_id, title, description, deadline, is_multiple_choice, is_anonymous " +
		             "FROM polls WHERE poll_id = ?";

		try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, poll_id);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					poll = new Poll();
					poll.setPoll_id(rs.getInt("poll_id"));
					poll.setTitle(rs.getString("title"));
					poll.setDescription(rs.getString("description"));
					if (rs.getTimestamp("deadline") != null) {
						poll.setDeadline(rs.getTimestamp("deadline").toLocalDateTime());
					}
					poll.setMultipleChoice(rs.getBoolean("is_multiple_choice")); // 복수 선택 여부 처리
				}
			}
		}
		return poll;
	}

	// 투표 제목 가져오기
	public String getPollTitle(int poll_id) {
		String title = null;
		String sql = "SELECT title FROM polls WHERE poll_id = ?";
		try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, poll_id);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				title = rs.getString("title");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return title;
	}
	
	// 사용자가 특정 투표에 참여했는지 확인
	public boolean hasUserVoted(int userId, int pollId) {
		String sql = "SELECT last_voted_poll_id FROM users WHERE id = ?";
		try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				int lastVotedPollId = rs.getInt("last_voted_poll_id");
				return lastVotedPollId == pollId; // 마지막 투표 ID가 현재 투표 ID와 같으면 중복
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false; // 기본값
	}
	
	// 특정 사용자가 생성한 투표 가져오기
	public List<Poll> getPollsByUser(String username) {
		List<Poll> polls = new ArrayList<>();
		String sql = "SELECT poll_id, title, description, deadline, is_multiple_choice, is_anonymous " +
		             "FROM polls WHERE created_by = ?";
		try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, username);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				LocalDateTime deadline = null;
				if (rs.getTimestamp("deadline") != null) {
					deadline = rs.getTimestamp("deadline").toLocalDateTime();
				}
				Poll poll = new Poll();
				poll.setPoll_id(rs.getInt("poll_id"));
				poll.setTitle(rs.getString("title"));
				poll.setDescription(rs.getString("description"));
				poll.setDeadline(deadline);
				poll.setMultipleChoice(rs.getBoolean("is_multiple_choice"));
				polls.add(poll);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return polls;
	}
}
