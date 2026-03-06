<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Intro</title>

    <style>
        html,body{
            height:100%;
            margin:0;
            background:#000;
            overflow:hidden;
            font-family:sans-serif;
        }

        .splash{
            position:fixed;
            inset:0;
            background:#000;
            overflow:hidden;
        }

        /* GIF */
        #gif{
            position:absolute;
            inset:0;
            width:100vw;
            height:100vh;
            object-fit:cover;
            z-index:1;
        }

        /* YouTube */
        /*
        #ytVideo{
        position:absolute;
        inset:0;
        width:100%;
        height:100%;
        border:0;
        display:none;
        z-index:2;
        }
        */

        /* 블랙 오버레이 */
        #black{
            position:absolute;
            inset:0;
            background:#000;
            opacity:0;
            transition:opacity .35s ease;
            z-index:3;
            pointer-events:none;
        }
        #black.show{ opacity:1; }

        /* 페이드 아웃 */
        #fade{
            position:absolute;
            inset:0;
            background:#000;
            opacity:0;
            transition:opacity 1s ease;
            z-index:10;
            pointer-events:none;
        }

        /* skip 버튼 */
        .skip{
            position:fixed;
            top:16px;
            right:16px;
            z-index:20;

            padding:10px 14px;
            border-radius:999px;

            border:1px solid rgba(255,255,255,.35);
            background:rgba(0,0,0,.35);
            color:#fff;

            cursor:pointer;
            backdrop-filter: blur(5px);
        }
    </style>
</head>

<body>

<button class="skip" id="skip">Skip</button>

<div class="splash" id="splash">

    <img id="gif"
         src="${pageContext.request.contextPath}/Image/PIXAR.gif"
         alt="intro"/>

    <div id="black"></div>

    <!-- YouTube iframe (현재 사용 안함)
    <iframe
    id="ytVideo"
    src="https://www.youtube.com/embed/_TMDhDyMle4?start=48&autoplay=1&mute=1&controls=0&rel=0&playsinline=1"
    allow="autoplay; encrypted-media"
    allowfullscreen>
    </iframe>
    -->

    <div id="fade"></div>

</div>

<script>

    const HOME_URL = "${pageContext.request.contextPath}/index.do";

    /* 타이밍 */
    const GIF_DURATION_MS = 8200;
    const BETWEEN_BLACK_MS = 2000;
    const FADE_TIME_MS = 800;

    /* 유튜브 관련 변수 (현재 미사용)
    const VIDEO_ID = "_TMDhDyMle4";
    const START_TIME = 48;
    */

    const gif = document.getElementById("gif");
    const black = document.getElementById("black");
    /* const video = document.getElementById("ytVideo"); */
    const fade = document.getElementById("fade");

    let moved = false;
    let timers = [];

    function setT(fn, ms){
        const t = setTimeout(fn, ms);
        timers.push(t);
        return t;
    }

    function cleanup(){
        timers.forEach(clearTimeout);
        timers = [];
    }

    function markSeen(){
        localStorage.setItem("intro_seen","true");
    }

    function goHome(){
        if (moved) return;
        moved = true;

        fade.style.opacity = "1";
        setT(() => location.replace(HOME_URL), FADE_TIME_MS);
    }

    function endAndGo(){
        cleanup();
        markSeen();
        goHome();
    }

    if (localStorage.getItem("intro_seen") === "true") {
        location.replace(HOME_URL);
    }else{

// GIF 종료
        setT(()=>{

            gif.style.display="none";

// 블랙 화면
            black.classList.add("show");

            setT(()=>{

// 원래 여기서 유튜브 실행했음
                /*
                video.style.display="block";

                video.src =
                "https://www.youtube.com/embed/"+VIDEO_ID+
                "?start="+START_TIME+
                "&autoplay=1"+
                "&mute=0"+
                "&controls=0"+
                "&rel=0"+
                "&playsinline=1";
                */

// 지금은 바로 홈 이동
                endAndGo();

            },BETWEEN_BLACK_MS);

        },GIF_DURATION_MS);

// Skip / Click
        document.getElementById("skip").addEventListener("click",endAndGo);
        document.getElementById("splash").addEventListener("click",endAndGo);

    }

</script>

</body>
</html>