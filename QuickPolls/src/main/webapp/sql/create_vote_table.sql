DROP TABLE IF EXISTS votes;

CREATE TABLE votes (
    vote_id INT AUTO_INCREMENT PRIMARY KEY,
    poll_id INT NOT NULL,
    option_id INT NOT NULL,
    voted_by VARCHAR(50), -- 익명 투표의 경우 NULL 허용
    FOREIGN KEY (poll_id) REFERENCES polls(poll_id) ON DELETE CASCADE,
    FOREIGN KEY (option_id) REFERENCES poll_options(option_id) ON DELETE CASCADE,
    UNIQUE (poll_id, option_id, voted_by) -- 복수 선택과 중복 방지
);
