package Service.Movie;

import java.util.List;

import DAO.Movie.PersonDAO;
import DAO.Movie.PersonDAOImpl;
import DTO.Movie.PersonDTO;

public class PersonServiceImpl implements PersonService {

	private PersonDAO personDAO = PersonDAOImpl.getInstance();

	@Override
	public List<PersonDTO> searchPerson(String keyword) {
		if (keyword == null || keyword.trim().isEmpty()) {
            throw new IllegalArgumentException("검색어는 비어 있을 수 없습니다.");
        }

        return personDAO.searchPerson(keyword.trim());
	}

}
