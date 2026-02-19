package Service.Vote;

import java.util.List;

import DTO.Vote.VoteRecordDTO;
import DTO.Vote.VoteRegisterDTO;
import DTO.Vote.VoteResultDTO;

public interface VoteService {

	void insertVoteRecord(VoteRecordDTO voteRecord);

	List<VoteResultDTO> getVoteResult(int voteId);

	List<VoteRegisterDTO> getVoteRegList();

	VoteRegisterDTO getVoteRegById(int voteId);

	List<VoteRecordDTO> getVoteRecordList();

	VoteRecordDTO getVoteRecordByMemNo(VoteRecordDTO vrdto);

	void updateVoteRecord(VoteRecordDTO voteRecord);

	List<VoteRegisterDTO> getVoteRegFullList();

	List<VoteRegisterDTO> getVoteRegActiveForMem();

	List<VoteRecordDTO> getVoteRecordByVoteId(int voteId);

	VoteRegisterDTO getVoteRegFullById(int voteId);

	void updateVoteStatus(VoteRegisterDTO voteReg);

    List<VoteRegisterDTO> sortVote(List<VoteRegisterDTO> voteRegFullList);

    boolean insertVoteRegister(VoteRegisterDTO vdto);

	

}
