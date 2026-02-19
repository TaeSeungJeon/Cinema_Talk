<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Modal-based member re-confirmation form. This fragment can be used standalone (it will show the modal immediately)
     or included in another JSP (it will show the modal on DOMContentLoaded). The form posts to the original action.
-->

<div id="check-member-modal-overlay" aria-hidden="true">
    <div id="check-member-modal" role="dialog" aria-modal="true" aria-labelledby="check-member-title">
        <button id="check-member-close" aria-label="Close">×</button>
        <h2 id="check-member-title">회원정보 수정 확인</h2>

        <form id="check-member-form" name="frm" action="memberEdit.do" method="post">
            <div class="input-group">
                <label for="mem-id">아이디</label>
                <input id="mem-id" type="text" name="mem-id" placeholder="Username" required>
            </div>
            <div class="input-group">
                <label for="mem-pwd">비밀번호</label>
                <input id="mem-pwd" type="password" name="mem-pwd" placeholder="Password" required>
            </div>

            <div class="actions">
                <button type="submit" class="btn-submit">확인</button>
                <button type="button" id="btn-cancel" class="btn-cancel">취소</button>
            </div>
        </form>

        <c:if test="${not empty msg}">
            <div class="server-msg">${msg}</div>
        </c:if>
    </div>
</div>

<style>
:root {
    --bg-color: rgba(15, 23, 42, 0.6);
    --modal-bg: #ffffff;
    --accent-color: #6366f1;
    --accent-gradient: linear-gradient(135deg, #6366f1 0%, #4338ca 100%);
    --text-main: #0f172a;
    --radius-soft: 12px;
}

/* Overlay */
#check-member-modal-overlay {
    position: fixed;
    inset: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(0,0,0,0.45);
    z-index: 9999;
    opacity: 0;
    pointer-events: none;
    transition: opacity 180ms ease-in-out;
}
#check-member-modal-overlay.open {
    opacity: 1;
    pointer-events: auto;
}

/* Modal box */
#check-member-modal {
    background: var(--modal-bg);
    width: 96%;
    max-width: 420px;
    border-radius: var(--radius-soft);
    padding: 22px;
    box-shadow: 0 20px 40px rgba(2,6,23,0.2);
    position: relative;
    transform: translateY(-8px);
    transition: transform 180ms ease-in-out;
}
#check-member-modal-overlay.open #check-member-modal { transform: translateY(0); }

#check-member-close {
    position: absolute;
    right: 12px;
    top: 12px;
    background: transparent;
    border: none;
    font-size: 20px;
    line-height: 1;
    cursor: pointer;
}

#check-member-title { margin: 0 0 14px 0; font-size: 1.1rem; color: var(--text-main); }

.input-group { margin-bottom: 12px; display: flex; flex-direction: column; }
.input-group label { font-size: 0.85rem; color: #475569; margin-bottom: 6px; }
.input-group input {
    padding: 10px 12px;
    border-radius: 10px;
    border: 1px solid #e2e8f0;
    font-size: 0.95rem;
}
.input-group input:focus { outline: none; border-color: var(--accent-color); box-shadow: 0 6px 18px rgba(99,102,241,0.12); }

.actions { display:flex; gap:10px; margin-top:8px; }
.btn-submit { flex:1; padding:10px; border-radius:10px; border: none; color: #fff; background: var(--accent-gradient); cursor: pointer; }
.btn-cancel { flex:1; padding:10px; border-radius:10px; border: 1px solid #cbd5e1; background: #fff; cursor: pointer; }

.server-msg { margin-top:12px; color:#b91c1c; font-size:0.95rem; }

/* When this JSP is opened as a full page, make body background neutral */
html, body { height: 100%; margin: 0; font-family: 'Inter', 'Apple SD Gothic Neo', sans-serif; }
</style>

<script>
(function(){
    // Helpers
    var overlay = document.getElementById('check-member-modal-overlay');
    var modal = document.getElementById('check-member-modal');
    var closeBtn = document.getElementById('check-member-close');
    var cancelBtn = document.getElementById('btn-cancel');
    var form = document.getElementById('check-member-form');
    var firstInput = document.getElementById('mem-id');

    function openModal() {
        overlay.classList.add('open');
        overlay.setAttribute('aria-hidden', 'false');
        // focus first input after animation frame for better UX
        requestAnimationFrame(function(){ firstInput && firstInput.focus(); });
        // trap focus
        document.addEventListener('focus', trapFocus, true);
        document.addEventListener('keydown', onKeyDown);
    }

    function closeModal() {
        overlay.classList.remove('open');
        overlay.setAttribute('aria-hidden', 'true');
        document.removeEventListener('focus', trapFocus, true);
        document.removeEventListener('keydown', onKeyDown);
        // If this JSP is a standalone page, navigate back on cancel to avoid leaving blank page
        try {
            // If parent exists and is same origin, try to close a dialog-like opener
            if (window.opener && !window.opener.closed) {
                window.close();
            }
        } catch (e) {
            // ignore
        }
    }

    function onKeyDown(e) {
        if (e.key === 'Escape') {
            closeModal();
        }
    }

    function trapFocus(ev) {
        if (!modal.contains(ev.target)) {
            ev.stopPropagation();
            // return focus to first input
            firstInput && firstInput.focus();
        }
    }

    // Close when clicking on overlay background
    overlay.addEventListener('click', function(ev){
        if (ev.target === overlay) closeModal();
    });
    closeBtn.addEventListener('click', closeModal);
    cancelBtn.addEventListener('click', closeModal);

    // Simple client-side validation mirroring "required" (keeps normal submit behavior)
    form.addEventListener('submit', function(ev){
        var idVal = form['mem-id'].value.trim();
        var pwdVal = form['mem-pwd'].value.trim();
        if (!idVal) { ev.preventDefault(); alert('아이디를 입력하세요'); form['mem-id'].focus(); return false; }
        if (!pwdVal) { ev.preventDefault(); alert('비밀번호를 입력하세요'); form['mem-pwd'].focus(); return false; }
        // Allow normal form submission (full page POST) so server-side flow is unchanged
    });

    // Open modal automatically when fragment loads. If this JSP is included into a larger page,
    // it will still trigger the modal on DOMContentLoaded.
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', openModal);
    } else {
        openModal();
    }
})();
</script>
