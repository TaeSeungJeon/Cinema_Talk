<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Intro</title>

    <style>
        html, body { height: 100%; margin: 0; background: #000; overflow: hidden; }
        .splash { position: fixed; inset: 0; background: #000; overflow: hidden; }
        .splash img { width: 100vw; height: 100vh; object-fit: cover; display: block; }
        .skip {
            position: fixed; top: 16px; right: 16px; z-index: 10;
            padding: 10px 14px; border-radius: 999px;
            border: 1px solid rgba(255,255,255,.35);
            background: rgba(0,0,0,.35);
            color: #fff; cursor: pointer;
        }
        .fade-layer{
            position: absolute;
            inset: 0;
            background: #000;
            opacity: 0;
            transition: opacity 0.8s ease;
            pointer-events: none; /* 레이어가 클릭 막지 않게 */
        }
    </style>
</head>
<body>
<button class="skip" id="skip">Skip</button>

<div class="splash" id="splash">
    <img id="gif" src="${pageContext.request.contextPath}/images/start.gif" alt="intro" />
    <div class="fade-layer" id="fade"></div>
</div>

<script>
    const HOME_URL = "${pageContext.request.contextPath}/index.do";
    const DURATION_MS = 9500;
    const FADE_TIME = 400;

    const fade = document.getElementById("fade");

    function goHome(){
        fade.style.opacity = "1";
        setTimeout(() => location.replace(HOME_URL), FADE_TIME);
    }

    // 브라우저 최초 1회만
    if (localStorage.getItem("intro_seen") === "true") {
        location.replace(HOME_URL);
    } else {
        const t = setTimeout(() => {
            localStorage.setItem("intro_seen", "true");
            goHome();
        }, DURATION_MS);

        document.getElementById("skip").addEventListener("click", () => { clearTimeout(t); goHome(); });
        document.getElementById("splash").addEventListener("click", () => { clearTimeout(t); goHome(); });
    }
</script>
</body>
</html>