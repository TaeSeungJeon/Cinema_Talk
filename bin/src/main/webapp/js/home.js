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
       const track = document.getElementById('movieTrack');
       if (track) {
           const cards = track.querySelectorAll('.movie-card-small');
           const totalCards = cards.length;
           const visibleCards = 5;
           const maxIdx = Math.max(0, totalCards - visibleCards);
           const cardWidth = 190;
           let currentIdx = 0;
           
           const updateSlider = () => {
               track.style.transform = `translateX(-${currentIdx * cardWidth}px)`;
           };
           
           const listNext = document.getElementById('listNext');
           const listPrev = document.getElementById('listPrev');
           
           if (listNext) {
               listNext.onclick = () => {
                   if (currentIdx < maxIdx) {
                       currentIdx++;
                       updateSlider();
                   }
               };
           }

           if (listPrev) {
               listPrev.onclick = () => {
                   if (currentIdx > 0) {
                       currentIdx--;
                       updateSlider();
                   }
               };
           }
       }
   });