package DAO.Vote;

import java.util.List;

import DTO.Vote.VoteRecordDTO;
import DTO.Vote.VoteRegisterDTO;
import DTO.Vote.VoteResultDTO;

public interface VoteDAO {

	void insertVoteRecord(VoteRecordDTO voteRecord);

	List<VoteResultDTO> getVoteResult(int vote_id);

	List<VoteRegisterDTO> getVoteRegList();

	VoteRegisterDTO getVoteRegById(int vote_id);

	List<VoteRecordDTO> getVoteRecordList();

	VoteRecordDTO getVoteRecordByMemNo(int mem_no);

	void updateVoteRecord(VoteRecordDTO voteRecord);

}
