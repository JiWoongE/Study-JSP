-- 기존 테이블 삭제
DROP TABLE IF EXISTS poll_files;
DROP TABLE IF EXISTS poll_options;
DROP TABLE IF EXISTS polls;

-- 투표 정보를 저장하는 테이블 생성
CREATE TABLE polls (
    poll_id INT AUTO_INCREMENT PRIMARY KEY, -- 투표 ID
    title VARCHAR(255) NOT NULL,            -- 투표 제목
    description TEXT,                       -- 투표 설명
    created_by VARCHAR(50) NOT NULL,        -- 생성자
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 생성 시간
    deadline DATETIME DEFAULT NULL ,-- 마감 시간
    is_multiple_choice BOOLEAN DEFAULT FALSE, -- 복수 선택 여부
	is_anonymous BOOLEAN DEFAULT FALSE, -- 익명 투표 여부
	file_path VARCHAR(255) DEFAULT NULL
);

-- 투표와 관련된 파일 정보를 저장하는 테이블 생성
CREATE TABLE poll_files (
    file_id INT AUTO_INCREMENT PRIMARY KEY, -- 파일 ID
    poll_id INT NOT NULL,                   -- 투표 ID
    file_path VARCHAR(255) NOT NULL,        -- 파일 경로
    FOREIGN KEY (poll_id) REFERENCES polls(poll_id) ON DELETE CASCADE -- 외래 키
);

-- 투표 옵션을 저장하는 테이블 생성
CREATE TABLE poll_options (
    option_id INT AUTO_INCREMENT PRIMARY KEY,
    poll_id INT NOT NULL,
    option_text VARCHAR(255) NOT NULL,
    FOREIGN KEY (poll_id) REFERENCES polls(poll_id) ON DELETE CASCADE
);
