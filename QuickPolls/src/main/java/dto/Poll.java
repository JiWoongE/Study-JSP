package dto;

import java.time.LocalDateTime;

public class Poll {
    private int poll_id;
    private String title;
    private String description;
    private LocalDateTime deadline;
    private boolean isMultipleChoice;

    public Poll() {
        // 기본 생성자
    }
    
    public Poll(int poll_id, String title, String description, LocalDateTime deadline) {
        this.poll_id = poll_id;
        this.title = title;
        this.description = description;
        this.deadline = deadline;
    }

    
    // Getters and Setters
    public int getPoll_id() {
        return poll_id;
    }
    public void setPoll_id(int poll_id) {
        this.poll_id = poll_id;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getDeadline() {
        return deadline;
    }
    public void setDeadline(LocalDateTime deadline) {
        this.deadline = deadline;
    }
    public boolean isMultipleChoice() {
        return isMultipleChoice;
    }
    public void setMultipleChoice(boolean isMultipleChoice) {
        this.isMultipleChoice = isMultipleChoice;
    }
}
