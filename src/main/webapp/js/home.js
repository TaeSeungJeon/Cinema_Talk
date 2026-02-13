function toggleMenu(element) {
       const isActive = element.classList.contains('active');
       document.querySelectorAll('.category-bubble').forEach(b => b.classList.remove('active'));
       if (!isActive) {
           element.classList.add('active');
       }
   }

   window.addEventListener('click', function (e) {
       if (!e.target.closest('.category-bubble')) {
           document.querySelectorAll('.category-bubble').forEach(b => b.classList.remove('active'));
       }
   });
   
   document.addEventListener('DOMContentLoaded', function () {
       let heroPage = 1;
       const movies = [
           { id: 1, title: "범죄도시 3", info: "범죄, 액션 • 현재 인기 순위 1위", color: "linear-gradient(to right, #6366f1 0%, #4338ca 50%, #1e1b4b 100%)" },
           { id: 2, title: "아바타: 물의 길", info: "SF, 어드벤처 • 현재 인기 순위 2위", color: "linear-gradient(to right, #0ea5e9 0%, #0369a1 50%, #082f49 100%)" },
           { id: 3, title: "더 퍼스트 슬램덩크", info: "애니메이션, 스포츠 • 현재 인기 순위 3위", color: "linear-gradient(to right, #f43f5e 0%, #be123c 50%, #4c0519 100%)" }
       ];

       const updateHero = (dir) => {
           if (dir === 'next') heroPage = (heroPage % 3) + 1;
           else heroPage = (heroPage === 1) ? 3 : heroPage - 1;
           const current = movies[heroPage - 1];
           document.querySelector("#movie-title").innerText = current.title;
           document.querySelector("#movie-info").innerText = current.info;
           document.querySelector("#hero-banner").style.background = current.color;
           document.querySelector("#pageIdx").innerText = heroPage + " / 3";
           document.querySelector("#movie-title-link").setAttribute("href", `movieDetail.jsp?id=${current.id}`);
       };

       document.getElementById("nextBtn").onclick = () => updateHero('next');
       document.getElementById("prevBtn").onclick = () => updateHero('prev');

       const track = document.getElementById('movieTrack');
       const cards = track.querySelectorAll('.movie-card-small');
       const totalCards = cards.length;
       const visibleCards = 5;
       const maxIdx = Math.max(0, totalCards - visibleCards); // 7-5=2
       const cardWidth = 190; // 170px 카드 + 20px gap 고정
       let currentIdx = 0;
       
       const updateSlider = () => {
           track.style.transform = `translateX(-${currentIdx * cardWidth}px)`;
       };
       
       document.getElementById('listNext').onclick = () => {
           if (currentIdx < maxIdx) {
               currentIdx++;
               updateSlider();
           }
       };

       document.getElementById('listPrev').onclick = () => {
           if (currentIdx > 0) {
               currentIdx--;
               updateSlider();
           }
       };
   });/**
 * 
 */