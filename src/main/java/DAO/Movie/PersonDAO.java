package DAO.Movie;

import DTO.Movie.PersonDTO;
import java.util.List;

public interface PersonDAO {
	void insertPerson(PersonDTO person);
	void insertPersonBatch(List<PersonDTO> persons);
	void mergePerson(PersonDTO person);
	boolean existsPerson(int personId);
	PersonDTO getPersonById(int pid);
	List<PersonDTO> searchPerson(String trim);
}
