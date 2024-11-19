<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, java.util.*, java.io.*, com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%
    // 파일 업로드 경로 설정
    String uploadPath = application.getRealPath("/") + "uploads";
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdirs(); // 디렉토리가 없으면 생성
    }

    // MultipartRequest 객체 생성
    MultipartRequest multi = new MultipartRequest(
        request,
        uploadPath,
        10 * 1024 * 1024, // 파일 크기 제한 (10MB)
        "UTF-8",
        new DefaultFileRenamePolicy()
    );

    // 폼 데이터 가져오기
    String title = multi.getParameter("pollTitle");
    String description = multi.getParameter("pollDescription");
    String deadline = multi.getParameter("pollDeadline");
    boolean isMultipleChoice = "true".equals(multi.getParameter("is_multiple_choice")); // 수정
    boolean isAnonymous = "true".equals(multi.getParameter("is_anonymous")); // 수정
    String createdBy = (String) session.getAttribute("username");

    int pollId = 0; // 생성된 투표 ID를 저장할 변수

    // 데이터베이스 연결 정보
    String dbURL = "jdbc:mysql://localhost:3306/quickpollsDB";
    String dbUser = "root";
    String dbPassword = "12345678";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // 데이터베이스 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // 투표 저장
        String pollSql = "INSERT INTO polls (title, description, created_by, deadline, is_multiple_choice, is_anonymous) VALUES (?, ?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(pollSql, Statement.RETURN_GENERATED_KEYS);
        stmt.setString(1, title);
        stmt.setString(2, description);
        stmt.setString(3, createdBy);
        stmt.setString(4, deadline);
        stmt.setBoolean(5, isMultipleChoice);
        stmt.setBoolean(6, isAnonymous);
        stmt.executeUpdate();

        // 생성된 poll_id 가져오기
        ResultSet rs = stmt.getGeneratedKeys();
        if (rs.next()) {
            pollId = rs.getInt(1);
            System.out.println("Generated poll_id: " + pollId); // 디버깅용
        }

        // 옵션 저장
        String[] options = multi.getParameterValues("options");
        if (options != null) {
            String optionSql = "INSERT INTO poll_options (poll_id, option_text) VALUES (?, ?)";
            PreparedStatement optionStmt = conn.prepareStatement(optionSql);
            for (String option : options) {
                optionStmt.setInt(1, pollId);
                optionStmt.setString(2, option);
                optionStmt.executeUpdate();
                System.out.println("Inserted option: " + option); // 디버깅용
            }
            optionStmt.close();
        }

        // 파일 저장 처리
        Enumeration<String> fileFields = multi.getFileNames(); // 모든 파일 입력 필드 이름 가져오기
        while (fileFields.hasMoreElements()) {
            String fileFieldName = fileFields.nextElement(); // 현재 파일 필드 이름
            File file = multi.getFile(fileFieldName); // 해당 파일 객체 가져오기

            if (file != null) {
                String filePath = "uploads/" + file.getName(); // 상대 경로 저장
                System.out.println("Processing file: " + filePath); // 디버깅용

                // 파일 경로를 poll_files 테이블에 저장
                String fileSql = "INSERT INTO poll_files (poll_id, file_path) VALUES (?, ?)";
                PreparedStatement fileStmt = conn.prepareStatement(fileSql);
                fileStmt.setInt(1, pollId);
                fileStmt.setString(2, filePath);
                fileStmt.executeUpdate();
                fileStmt.close();
            }
        }

        // 성공 메시지와 함께 메인 페이지로 리디렉션
        response.sendRedirect("index.jsp?message=PollCreated");
    } catch (Exception e) {
        e.printStackTrace(); // 디버깅용
        response.sendRedirect("createPoll.jsp?error=PollCreationFailed");
    } finally {
        // 자원 해제
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
