package Service.Vote;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
	public List<VoteResultDTO> getVoteResult(int voteId) {

		return this.vdao.getVoteResult(voteId);
	}

	@Override
	public List<VoteRegisterDTO> getVoteRegList() {

		return this.vdao.getVoteRegList();
	}

	@Override
	public VoteRegisterDTO getVoteRegById(int voteId) {

		return this.vdao.getVoteRegById(voteId);
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

	@Override
	public VoteRegisterDTO getVoteRegFullById(int voteId) {
		return this.vdao.getVoteRegFullById(voteId);
	}

	@Override
	public void updateVoteStatus(VoteRegisterDTO voteReg) {
		//투표 상태 셋팅
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();

		
			Date start =now ;
			Date end = now;
			try {
				start= sdf.parse(voteReg.getVoteStartDate());
				end = sdf.parse(voteReg.getVoteEndDate());
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			if(now.before(start)){
				voteReg.setVoteStatus("READY");
			}else if(now.after(end)){
				voteReg.setVoteStatus("CLOSED");
			}else{
				voteReg.setVoteStatus("ACTIVE");
			}


	



	}

}
