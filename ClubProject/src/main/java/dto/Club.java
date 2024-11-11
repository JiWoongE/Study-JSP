package dto;

import java.io.Serializable;

public class Club implements Serializable {
    private String id;
    private String name;
    private String description;
    private String leader;

    public Club(String id, String name, String description, String leader) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.leader = leader;
    }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getLeader() {
		return leader;
	}

	public void setLeader(String leader) {
		this.leader = leader;
	}

    
}
