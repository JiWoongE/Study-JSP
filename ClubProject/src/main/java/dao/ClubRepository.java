package dao;

import dto.Club;
import java.util.ArrayList;
import java.util.List;

public class ClubRepository {
    private List<Club> clubs = new ArrayList<>();

    public ClubRepository() {
        clubs.add(new Club("1", "Coding Club", "A club for coding enthusiasts", "Alice"));
        clubs.add(new Club("2", "Art Club", "A club for art lovers", "Bob"));
    }

    public List<Club> getAllClubs() {
        return clubs;
    }

    public Club getClubById(String id) {
        return clubs.stream().filter(c -> c.getId().equals(id)).findFirst().orElse(null);
    }
}
