document.addEventListener("DOMContentLoaded", function() {
        const track = document.querySelector('.vote-track');
        const slides = document.querySelectorAll('.vote-content');
        const prevBtn = document.getElementById('votePrevBtn');
        const nextBtn = document.getElementById('voteNextBtn');
		const radioButtons = document.querySelectorAll('input[name^="movie-vote-"]');
        
        let currentIndex = 0;
        const slideCount = slides.length;

        function moveSlide(index) {
            if (slideCount === 0) return;
            
            // 트랙 이동
            track.style.transform = `translateX(-${index * 100}%)`;
            
            // 버튼 활성화 상태
        //    prevBtn.classList.toggle('disabled', index === 0);
          //  nextBtn.classList.toggle('disabled', index === slideCount - 1);
            
            currentIndex = index;
        }

        if (slideCount > 0) {
            moveSlide(0);
        } else {
            prevBtn.style.display = 'none';
            nextBtn.style.display = 'none';
        }

		nextBtn.addEventListener('click', () => {
		    if (currentIndex >= slideCount - 1) {
		        moveSlide(0); // 마지막이면 처음으로
		    } else {
		        moveSlide(currentIndex + 1);
		    }
		});

		prevBtn.addEventListener('click', () => {
		    if (currentIndex <= 0) {
		        moveSlide(slideCount - 1); // 처음이면 마지막으로
		    } else {
		        moveSlide(currentIndex - 1);
		    }
		});
		
		$(".submit-vote-btn").on("click", function() {
const voteId = $(this).data("vote-id"); 
			if($(this).hasClass("go-to-votecont")){
location.href = "voteCont.do?voteId=" + voteId;
			}else{
  // 2. 클릭한 버튼의 data-vote-id 값을 가져옴
		        
		        
		        // 3. 해당 투표 그룹(name="movie-vote-번호")에서 체크된 라디오 버튼 찾기
		        const $selectedOption = $("input[name='movie-vote-" + voteId + "']:checked");

		        if ($selectedOption.length === 0) {
		            alert("영화를 선택해 주세요!");
		            return;
		        }

		        const movieId = $selectedOption.val(); // 선택된 영화 ID

		        // 4. AJAX 전송
		        $.ajax({
		            type: "POST",
		            url: "voteOk.do", 
		            data: {
		                "voteId": voteId,
		                "movieId": movieId,
						"comment": ""
		            },
		            success: function(response) {
						let data = JSON.parse(response)
						if (data.status === "LOGIN_REQUIRED") {
							console.log("login")
						        alert("로그인이 필요합니다.");
						        location.href = "memberLogin.do";
						        return;
						    }

						    if (data.status === "SUCCESS") {
						        const results = data.results;
								
								results.forEach(function(item) {
								            // 1. 해당 영화 ID를 가진 카드를 찾음
											const $input = $(`input[data-movie-id="${item.movieId}"]`);
											const $label = $input.closest('.movie-option');

											if ($label.length > 0) {

											    $label.find(".m-result").fadeIn();
											    $label.find(".res-count").text(item.count);
											    $label.find(".res-pct").text(Math.round(item.percentage));

											    // ⭐ 왼쪽 → 오른쪽 채우기
											    setTimeout(()=>{
											        $label.css("background-size", `${item.percentage}% 100%`);
											    },50);
											}
								        });
								$(`.submit-vote-btn[data-vote-id="${voteId}"]`).text("댓글 보러 가기");	
								$(`.submit-vote-btn[data-vote-id="${voteId}"]`).addClass("go-to-votecont")	
								alert("투표가 성공적으로 기록되었습니다!");
						    }

		            },	error: function(err) {
							console.error("Error:", err);
							alert("통신 중 오류가 발생했습니다.");
							}
								});
			}
		        
		      
		    });

			
		
    });