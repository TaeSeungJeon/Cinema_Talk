package Service.Vote;

import java.util.List;

import DAO.Vote.VoteDAO;
import DAO.Vote.VoteDAOImpl;
import DTO.Vote.VoteRecordDTO;
import DTO.Vote.VoteRegisterDTO;
import DTO.Vote.VoteResultDTO;

public class VoteServiceImpl implements VoteService {
	
	private VoteDAO vdao = VoteDAOImpl.getInstance();

	@Override
	public void insertVoteRecord(VoteRecordDTO voteRecord) {
		
		this.vdao.insertVoteRecord(voteRecord);
	}

	@Override
	public List<VoteResultDTO> getVoteResult(int vote_id) {
		
		return this.vdao.getVoteResult(vote_id);
	}

	@Override
	public List<VoteRegisterDTO> getVoteRegList() {
		
		return this.vdao.getVoteRegList();
	}

	@Override
	public VoteRegisterDTO getVoteRegById(int vote_id) {
		
		return this.vdao.getVoteRegById(vote_id);
	}

	@Override
	public List<VoteRecordDTO> getVoteRecordList() {
		
		return this.vdao.getVoteRecordList();
	}

	@Override
	public VoteRecordDTO getVoteRecordByMemNo(VoteRecordDTO vrdto) {
		
		return this.vdao.getVoteRecordByMemNo(vrdto);
	}

	@Override
	public void updateVoteRecord(VoteRecordDTO voteRecord) {
		this.vdao.updateVoteRecord(voteRecord);
		
	}

	@Override
	public List<VoteRegisterDTO> getVoteRegFullList() {
		return this.vdao.getVoteRegFullList();
	}

	@Override
	public List<VoteRegisterDTO> getVoteRegActiveForMem() {
		return null;
	}

	@Override
	public List<VoteRecordDTO> getVoteRecordByVoteId(int voteId) {
		return this.vdao.getVoteRecordByVoteId(voteId);
	}

}
