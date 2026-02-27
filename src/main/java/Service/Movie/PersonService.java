package Service.Movie;

import java.util.List;

import DTO.Movie.PersonDTO;

public interface PersonService {

	List<PersonDTO> searchPerson(String keyword);

}
