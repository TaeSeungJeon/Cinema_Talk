package DAO.Vote;

import java.util.List;

import DTO.Vote.VoteRecordDTO;
import DTO.Vote.VoteRegisterDTO;
import DTO.Vote.VoteResultDTO;

public interface VoteDAO {

	void insertVoteRecord(VoteRecordDTO voteRecord);

	List<VoteResultDTO> getVoteResult(int voteId);

	List<VoteRegisterDTO> getVoteRegList(VoteRegisterDTO findVoteReg);

	VoteRegisterDTO getVoteRegById(int voteId);

	List<VoteRecordDTO> getVoteRecordList();

	VoteRecordDTO getVoteRecordByMemNoVoteId(VoteRecordDTO vrdto);

	void updateVoteRecord(VoteRecordDTO voteRecord);

	List<VoteRegisterDTO> getVoteRegFullList();

    List<VoteRecordDTO> getVoteRecordByVoteId(int voteId);

	VoteRegisterDTO getVoteRegFullById(int voteId);

    boolean insertVoteRegister(VoteRegisterDTO vdto);

	boolean editVoteRegister(VoteRegisterDTO vdto);

	boolean deleteVoteRegister(VoteRegisterDTO vdto);

	List<VoteRecordDTO> getVoteRecordByMemNo(int memNo);

	int getRowCount(VoteRegisterDTO findVoteReg);

}
