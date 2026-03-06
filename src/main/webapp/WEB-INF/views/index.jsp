<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Intro</title>

    <style>
        html, body {
            height: 100%;
            margin: 0;
            background: #000;
            overflow: hidden;
            font-family: sans-serif;
        }

        .splash {
            position: fixed;
            inset: 0;
            background: #000;
            overflow: hidden;
        }

        /* YouTube iframe */
        #ytVideo {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            border: 0;
            display: none;
            z-index: 2;
        }

        /* 블랙 오버레이 */
        #black {
            position: absolute;
            inset: 0;
            background: #000;
            z-index: 3;
            pointer-events: none;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* 로고 이미지 */
        #lyo {
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 1;
            transition: opacity 1s ease;
        }
        #lyo.fadeout { opacity: 0; }

        /* 페이드 아웃 */
        #fade {
            position: absolute;
            inset: 0;
            background: #000;
            opacity: 0;
            transition: opacity 1s ease;
            z-index: 10;
            pointer-events: none;
        }

        /* skip 버튼 */
        .skip {
            position: fixed;
            top: 16px;
            right: 16px;
            z-index: 20;
            padding: 10px 14px;
            border-radius: 999px;
            border: 1px solid rgba(255,255,255,.35);
            background: rgba(0,0,0,.35);
            color: #fff;
            cursor: pointer;
            backdrop-filter: blur(5px);
        }
    </style>
</head>

<body>

<button class="skip" id="skip">Skip</button>

<div class="splash" id="splash">

    <%-- 영상 1: 음성만 (블랙화면) --%>
    <iframe
            id="audioOnly"
            src="https://www.youtube.com/embed/0n2uOC8WNqs?autoplay=1&mute=0&controls=0&rel=0&playsinline=1"
            allow="autoplay; encrypted-media"
            allowfullscreen
            style="position:absolute; width:1px; height:1px; opacity:0; z-index:1;">
    </iframe>

    <%-- 영상 2: 영상+소리 --%>
    <iframe
            id="ytVideo"
            src=""
            allow="autoplay; encrypted-media"
            allowfullscreen>
    </iframe>

    <%-- 블랙 오버레이 (이미지 포함) --%>
    <div id="black">
        <img id="lyo" src="${pageContext.request.contextPath}/Image/lyo.webp" alt=""/>
    </div>

    <div id="fade"></div>

</div>

<script>

    const HOME_URL = "${pageContext.request.contextPath}/index.do";

    const AUDIO_DURATION_MS = 4000;   // 영상1: 4초 (블랙 + 음성만)
    const VIDEO_DURATION_MS = 13000;  // 영상2: 13초 (영상 + 소리)
    const FADE_TIME_MS      = 800;    // 페이드 아웃

    const black   = document.getElementById("black");
    const ytVideo = document.getElementById("ytVideo");
    const fade    = document.getElementById("fade");
    const lyo     = document.getElementById("lyo");

    let moved = false;
    let timers = [];

    function setT(fn, ms) {
        const t = setTimeout(fn, ms);
        timers.push(t);
        return t;
    }

    function cleanup() {
        timers.forEach(clearTimeout);
        timers = [];
    }

    function goHome() {
        if (moved) return;
        moved = true;
        cleanup();
        fade.style.opacity = "1";
        setTimeout(() => location.replace(HOME_URL), FADE_TIME_MS);
    }

    // Step 1: 4초간 블랙 + 이미지 표시 + 음성 재생
    setT(() => {

        // 영상1 재생 중단
        document.getElementById("audioOnly").src = "";

        // 이미지 페이드 아웃 시작
        lyo.classList.add("fadeout");

        // 영상2 미리 로드 (블랙 유지한 채로)
        ytVideo.src =
            "https://www.youtube.com/embed/gX0CmJa5Gdk" +
            "?autoplay=1&mute=0&controls=0&rel=0&playsinline=1";

        // 1초 후 블랙 오버레이 제거 → 영상2 표시
        setT(() => {
            black.style.display = "none";
            ytVideo.style.display = "block";
        }, 1000);

        // 13초 후 홈으로
        setT(goHome, VIDEO_DURATION_MS);

    }, AUDIO_DURATION_MS);

    document.getElementById("skip").addEventListener("click", goHome);

</script>

</body>
</html>