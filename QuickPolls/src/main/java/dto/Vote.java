package dto;

public class Vote {
    private int poll_id;
    private String optionText;
    private int voteCount;

    // Getters and Setters
    public int getPoll_id() {
        return poll_id;
    }
    public void setPoll_id(int poll_id) {
        this.poll_id = poll_id;
    }

    public String getOptionText() {
        return optionText;
    }
    public void setOptionText(String optionText) {
        this.optionText = optionText;
    }

    public int getVoteCount() {
        return voteCount;
    }
    public void setVoteCount(int voteCount) {
        this.voteCount = voteCount;
    }
}
