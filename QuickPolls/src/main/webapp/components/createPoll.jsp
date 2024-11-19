<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="checkSession.jsp"%>
<html lang="ko">
<head>
<title>QuickPolls - 투표 생성</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/createPoll.css">
<script>
        let fileCount = 1;

        // 파일 입력 필드 추가
        function addFileField() {
            fileCount++;
            const fileContainer = document.getElementById("fileContainer");
            const newFileField = document.createElement("div");
            newFileField.className = "file-input-container";
            newFileField.innerHTML = `
                <input type="file" name="file${fileCount}" accept=".jpg,.jpeg,.png,.pdf">
                <button type="button" class="remove-file-button" onclick="removeFileField(this)">삭제</button>
            `;
            fileContainer.appendChild(newFileField);
        }

        // 파일 입력 필드 삭제
        function removeFileField(button) {
            const fileField = button.parentElement;
            fileField.remove();
        }

        // 투표 항목 추가
        function addOption() {
            const optionList = document.getElementById("optionList");
            const newOption = document.createElement("div");
            newOption.className = "option-container";
            newOption.innerHTML = `
                <input type="text" name="options" placeholder="항목 입력" required>
                <button type="button" class="remove-option" onclick="removeOption(this)">삭제</button>
            `;
            optionList.appendChild(newOption);
        }

        // 투표 항목 삭제
        function removeOption(button) {
            const option = button.parentElement;
            option.remove();
        }
    </script>
</head>
<body>
	<%@ include file="header.jsp"%>
	<main class="create-poll-page">
		<section class="create-poll-container">
			<h1>투표 생성</h1>
			<form action="processCreatePoll.jsp" method="post"
				enctype="multipart/form-data">
				<!-- 투표 제목 -->
				<div class="poll-section">
					<label for="pollTitle">투표 제목</label> <input type="text"
						id="pollTitle" name="pollTitle" placeholder="투표 제목을 입력하세요"
						required>
				</div>

				<!-- 투표 설명 -->
				<div class="poll-section">
					<label for="pollDescription">투표 설명</label>
					<textarea id="pollDescription" name="pollDescription" rows="4"
						placeholder="투표에 대한 설명을 입력하세요"></textarea>
				</div>

				<!-- 첨부 파일 -->
                <div class="poll-section">
                    <label>첨부 파일</label>
                    <div id="fileContainer">
                        <div class="file-input-container">
                            <input type="file" name="file1" accept=".jpg,.jpeg,.png,.pdf">
                            <button type="button" class="remove-file-button" onclick="removeFileField(this)">삭제</button>
                        </div>
                    </div>
                    <button type="button" class="add-file-button" onclick="addFileField()">+ 파일 추가</button>
                </div>

                <!-- 투표 항목 -->
                <div class="poll-section">
                    <label>투표 항목</label>
                    <div id="optionList">
                        <div class="option-container">
                            <input type="text" name="options" placeholder="항목 입력" required>
                            <button type="button" class="remove-option" onclick="removeOption(this)">삭제</button>
                        </div>
                    </div>
                    <button type="button" class="add-option-button" onclick="addOption()">+ 항목 추가</button>
                </div>

				<!-- 투표 마감일 -->
				<div class="poll-section">
					<label for="pollDeadline">투표 마감일</label> <input
						type="datetime-local" id="pollDeadline" name="pollDeadline"
						required>
				</div>

				<!-- 제출 버튼 -->
				<div class="poll-section">
					<button type="submit" class="submit-btn">투표 생성</button>
				</div>
			</form>
		</section>
	</main>
	<%@ include file="footer.jsp"%>
</body>
</html>
