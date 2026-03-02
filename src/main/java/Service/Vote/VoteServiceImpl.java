package Service.Vote;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

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
	public List<VoteRegisterDTO> getVoteRegList(VoteRegisterDTO findVoteReg) {

		return this.vdao.getVoteRegList(findVoteReg);
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
	public VoteRecordDTO getVoteRecordByMemNoVoteId(VoteRecordDTO vrdto) {

		return this.vdao.getVoteRecordByMemNoVoteId(vrdto);
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
	public VoteRegisterDTO getVoteRegFullById(int voteId, boolean includeDeletedMovie) {
		if(includeDeletedMovie){
			return this.vdao.getVoteRegFullById(voteId);
		}
		return this.vdao.getVoteRegFullByIdNoNullMovie(voteId);
	}

	@Override
	public void updateVoteStatus(VoteRegisterDTO voteReg) {
    if (voteReg == null) return;

    try {
        // 1. 날짜 파싱 (DB 포맷이 yyyy-MM-dd라고 가정)
        LocalDate now = LocalDate.now();
        LocalDate start = LocalDate.parse(voteReg.getVoteStartDate());
        LocalDate end = LocalDate.parse(voteReg.getVoteEndDate()); // EndDate로 수정!

        // 2. 상태 판별 로직
        if (now.isBefore(start)) {
            voteReg.setVoteStatus("READY");
        } else if (now.isAfter(end)) {
            voteReg.setVoteStatus("CLOSED");
        } else {
            // 시작일 <= 오늘 <= 종료일 인 경우
            voteReg.setVoteStatus("ACTIVE");
        }
    } catch (Exception e) {
        // 날짜 형식이 잘못되었을 경우 기본값 설정
        System.err.println("날짜 파싱 에러: " + e.getMessage());
        voteReg.setVoteStatus("UNKNOWN");
    }
}

	@Override
	public List<VoteRegisterDTO> sortVote(List<VoteRegisterDTO> voteRegFullList) {
		LocalDate now = LocalDate.now();

return voteRegFullList.stream()
    .sorted(Comparator
        // 1. 상태별 정렬 (ACTIVE: 1, READY: 2, CLOSED: 3)
        .comparing((VoteRegisterDTO v) -> {
            LocalDate start = LocalDate.parse(v.getVoteStartDate());
            LocalDate end = LocalDate.parse(v.getVoteEndDate());
            
            if (now.isBefore(start)) return 2;      // READY
            if (now.isAfter(end)) return 3;       // CLOSED
            return 1;                             // ACTIVE
        })
        // 2. 상태 내에서의 상세 정렬
        .thenComparing((VoteRegisterDTO v) -> {
            LocalDate start = LocalDate.parse(v.getVoteStartDate());
            LocalDate end = LocalDate.parse(v.getVoteEndDate());
            
            // ACTIVE(1)일 때는 종료일이 임박한 순 (오름차순)
            // READY(2)일 때는 시작일이 임박한 순 (오름차순)
            // CLOSED(3)일 때는 종료일이 최신인 순 (내림차순을 위해 날짜 역전)
            if (now.isAfter(end)) {
                return end.toEpochDay() * -1; // 종료된 건 최근 종료순
            }
            return now.isBefore(start) ? start.toEpochDay() : end.toEpochDay();
        })
    )
    .collect(Collectors.toList());
	}

	@Override
	public boolean insertVoteRegister(VoteRegisterDTO vdto) {
		return this.vdao.insertVoteRegister(vdto);
	}

	@Override
	public List<VoteRegisterDTO> getActiveVoteRegList() {
		List<VoteRegisterDTO> voteRegFullList = getVoteRegFullList();
		voteRegFullList.forEach(vote -> {
			//현재 시간 기준으로 상태(READY, ONGOING, CLOSED) 업데이트
			updateVoteStatus(vote);});
		
		List<VoteRegisterDTO> activeVoteRegFullList = (voteRegFullList != null && !voteRegFullList.isEmpty()) 
			    ? voteRegFullList.stream()
			        .filter(vote -> "ACTIVE".equals(vote.getVoteStatus()))
			        .collect(Collectors.toList()) 
			    : new ArrayList<>();
		
		return activeVoteRegFullList;
	}

	@Override
	public boolean editVoteRegister(VoteRegisterDTO vdto) {
		
		return this.vdao.editVoteRegister(vdto);
	}

	@Override
	public boolean deleteVoteRegister(VoteRegisterDTO vdto) {
		return this.vdao.deleteVoteRegister(vdto);
	}

	@Override
	public List<VoteRecordDTO> getVoteRecordByMemNo(int memNo) {
		return this.vdao.getVoteRecordByMemNo(memNo);
	}

	@Override
	public int getRowCount(VoteRegisterDTO findVoteReg) {
		return this.vdao.getRowCount(findVoteReg);
	}

	@Override
	public List<VoteRegisterDTO> getTenRecentVotes() {
		List<VoteRegisterDTO> voteList = this.vdao.getTenRecentVotes();
		voteList.forEach(vote -> {
			updateVoteStatus(vote);
		});

		return voteList;
	}

}
