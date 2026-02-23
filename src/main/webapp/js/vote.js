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
                    let data = typeof response === "string" ? JSON.parse(response) : response;
					
                    if (data.status === "LOGIN_REQUIRED") {
                        alert("로그인이 필요합니다.");
                        location.href = "memberLogin.do";
                        return;
                    }
					
					

                    if (data.status === "SUCCESS") {
                        const results = data.results;
						
                        results.forEach(function(item) {
                            const $input = $(`input[data-movie-id="${item.movieId}"][name="movie-vote-11"]`);
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
                    }
                },
                error: function(err) {
                    alert("통신 중 오류가 발생했습니다.");
                }
            });
        }
    };

    // 2. 슬라이드 관련 로직
    const track = document.querySelector('.vote-track');
    const slides = document.querySelectorAll('.vote-content');
    const prevBtn = document.getElementById('votePrevBtn');
    const nextBtn = document.getElementById('voteNextBtn');
    
    let currentIndex = 0;
    const slideCount = slides.length;

    function moveSlide(index) {
        if (slideCount === 0) return;
        track.style.transform = `translateX(-${index * 100}%)`;
        currentIndex = index;
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