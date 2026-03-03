document.addEventListener("DOMContentLoaded", function() {
    // 1. 함수 선언 (Hoisting을 위해 function 키워드로 선언하거나 상단에 위치)
    const submitVote = function() {
		
        const $this = $(this); 
        const voteId = $(this).closest('.submit-vote-btn').attr('data-vote-id');

        if($this.hasClass("go-to-votecont")){
            location.href = "voteCont.do?voteId=" + voteId + "&filter=comments";
        } else {
            let $selectedOption = $("input[name='movie-vote-" + voteId + "']:checked");


            if ($selectedOption.length === 0) {
                alert("영화를 선택해 주세요!");
                return;
            }

            const movieId = $selectedOption.val();

            $.ajax({
                type: "POST",
                url: "voteOk.do", 
                data: { "voteId": voteId, "movieId": movieId, "comment": "" },
                success: function(response) {

                    if(response == "ERROR"){
                        alert("문제가 발생했습니다.");
                        return;
                    }


                    let data = typeof response === "string" ? JSON.parse(response) : response;
					
                    if (data.status === "LOGIN_REQUIRED") {
                        alert("로그인이 필요합니다.");
                        location.href = "memberLogin.do";
                        return;
                    }
					
					

                    if (data.status === "SUCCESS") {
                        const results = data.results;
						
                        results.forEach(function(item) {
                            const $input = $(`input[data-movie-id="${item.movieId}"][name="movie-vote-${voteId}"]`);
                            const $label = $input.closest('.movie-option');

                            if ($label.length > 0) {
                                $label.find(".m-result").fadeIn();
                                $label.find(".res-count").text(item.count);
                                $label.find(".res-pct").text(Math.round(item.percentage));
                                
                                setTimeout(() => {
                                    $label.css("background-size", `${item.percentage}% 100%`);
                                }, 50);
                            }
                        });
						
						const participants = data.comments;
						if(participants && participants.length > 0){
							const voterCount = participants.length;
							const commentCount = participants.filter(p => p.commentText && p.commentText.trim().length > 0).length;
							
							if($(".voter-count-span").length > 0) $(".voter-count-span").html(`<strong>${voterCount}</strong> 참여`);
							if($(".voter-count-span-home").length > 0) $(".voter-count-span-home").text(`${voterCount}`);
							if($(".comment-count-span").length > 0) $(".comment-count-span").html(`<strong>${commentCount}</strong> 댓글`);
							
						}
                        $this.text("댓글 보기").addClass("go-to-votecont");
                        alert("투표가 성공적으로 기록되었습니다!");

						const comments = data.comments;
						let commentHtml = "";
						if(comments){
							comments.forEach(function(comment) {
					            commentHtml += `
					                <div class="comment-item">
					                    <strong>${comment.memName}</strong>
					                    <p>${comment.commentText}</p>
					                    <small>${comment.createdDate}</small>
					                </div>
					            `;
					        });
					        
					
					        $(".comment-list").html(commentHtml);
					        $(".comment-count").text(comments.length);
						}
						
						//투표메인페이지에서 투표후 '내가 참여한투표' 에 추가되게 하기 2026/02/25
						$(".no-record-msg").remove();
						const currentVoteId = voteId;
						let isAlreadyInList = false; //목록에 있는지 없는지 확인을 위한 변수
						
						
						$("#my-vote-items .done-item").each(function() {
				            if($(this).attr("onclick").includes("voteId=" + currentVoteId)) {
				                isAlreadyInList = true;
				            }
				        });
						
						if(!isAlreadyInList) {
				            // 사용자가 선택한 영화 제목 (라벨 등에서 텍스트 가져오기)
				            const selectedMovieTitle = $selectedOption.closest('.movie-option').find('.movie-info').find('.m-title').text();
				            const voteTitle = $this.closest('.vote-content').find('.vote-title').text().trim();
							
				            const newItemHtml = `
				                <div class="upcoming-item" onclick="location.href='voteCont.do?voteId=${currentVoteId}'" style="display:none;">
				                    <div style="font-weight: 600;">${voteTitle}</div>
				                    <div style="font-size: 0.8rem; color: var(--accent-color);">나의 픽: ${selectedMovieTitle}</div>
				                </div>
				            `;
				            
				            // 맨 앞에 추가하고 부드럽게 나타나기
				            $("#my-vote-items").prepend(newItemHtml);
				            $("#my-vote-items .upcoming-item").first().fadeIn(500);
							
							//위젯 안에 3개만 노출
							if ($("#my-vote-items .upcoming-item").length > 3) {
							    $("#my-vote-items .upcoming-item").last().remove();
							}
				        }
						
						
                    }// if SUCCESS 종료
                },
                error: function(err) {
                    alert("통신 중 오류가 발생했습니다.");
                }
            });
        }
    };

    // 슬라이드 관련 로직
    const track = document.querySelector('.vote-track');
    const slides = document.querySelectorAll('.vote-content');
    const prevBtn = document.getElementById('votePrevBtn');
    const nextBtn = document.getElementById('voteNextBtn');
    
    let currentIndex = 0;
    const slideCount = slides.length;

    function moveSlide(index) {
        if (slideCount === 0) return;	
		if (track == null) return;
        track.style.transform = `translateX(-${index * 100}%)`;
        currentIndex = index;
		if(slideCount == 1){
			if(prevBtn) prevBtn.classList.add('disabled');
			if(nextBtn) nextBtn.classList.add('disabled');
		}
    }

    if (slideCount > 0) {
        moveSlide(0);
    } else {
        if(prevBtn) prevBtn.style.display = 'none';
        if(nextBtn) nextBtn.style.display = 'none';
    }
	
	if(nextBtn){
		nextBtn.addEventListener('click', () => {
			currentIndex = (currentIndex >= slideCount - 1) ? 0 : currentIndex + 1;
			moveSlide(currentIndex);
		})
	}
	
	if(prevBtn){
		prevBtn.addEventListener('click', () => {
		        currentIndex = (currentIndex <= 0) ? slideCount - 1 : currentIndex - 1;
		        moveSlide(currentIndex);
		    });
	}
   
    $(".submit-vote-btn").on("click", submitVote);


    document.querySelectorAll('.movie-option a').forEach(link => {
        link.addEventListener('click', (e) => {
            e.stopPropagation(); 
        });
    });
});