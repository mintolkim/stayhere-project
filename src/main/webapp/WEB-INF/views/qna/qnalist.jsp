<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>STAYHERE</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${path }/resources/css/styles.css" rel="stylesheet" />
<style type="text/css">
input[type=text] {
  width: 130px;
  -webkit-transition: width 0.4s ease-in-out;
  transition: width 0.4s ease-in-out;
}

/* When the input field gets focus, change its width to 100% */
input[type=text]:focus {
  width: 100%;
}
</style>
</head>
<body class="d-flex flex-column h-100">
 <main class="flex-shrink-0">
  <!-- nav -->
	<%@ include file="../include/navbar.jsp" %>
		<!-- 본문영역-->
		<section class="py-5" id="features">
			<div class="container px-5 my-5">
				<!--글작성하기  -->
				<button type="button" class="btn btn-warning">작성하기</button>
				<!--검색하기 -->
				<input type="text" name="search" placeholder="Search..">
				<!-- 카테고리 선택 -->
				<div class="btn-group justify-content-center" role="group" aria-label="Basic radio toggle button group">
					<input type="radio" class="btn-check" name="btnradio"
						id="btnradio1" autocomplete="off" checked> <label
						class="btn btn-outline-primary" for="btnradio1">Radio 1</label> <input
						type="radio" class="btn-check" name="btnradio" id="btnradio2"
						autocomplete="off"> <label class="btn btn-outline-primary"
						for="btnradio2">Radio 2</label> <input type="radio"
						class="btn-check" name="btnradio" id="btnradio3"
						autocomplete="off"> <label class="btn btn-outline-primary"
						for="btnradio3">Radio 3</label>
				</div>
				<!--글 정렬 선택  -->
				<div class="dropdown" align="right">
					<button class="btn btn-secondary dropdown-toggle" type="button"
						data-bs-toggle="dropdown" aria-expanded="false">Dropdown
						button</button>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">최신순</a></li>
						<li><a class="dropdown-item" href="#">추천순</a></li>
						<li><a class="dropdown-item" href="#">댓글순</a></li>
						<li><a class="dropdown-item" href="#">조회순</a></li>
					</ul>
				</div>
				<!-- 카드 -->
				<div class="row gx-5">
					<div class="col-lg-6 mb-4">
						<div class="card h-100 shadow border-0">
							<div class="card-body p-4">
								<div class="badge bg-primary bg-gradient rounded-pill mb-2">News</div>
								<a class="text-decoration-none link-dark stretched-link"
									href="#!"><h5 class="card-title mb-3">Blog post title</h5></a>
								<p class="card-text mb-0">Some quick example text to build
									on the card title and make up the bulk of the card's content.</p>
							</div>
							<div class="card-footer p-4 pt-0 bg-transparent border-top-0">
								<div class="d-flex align-items-end justify-content-between">
									<div class="d-flex align-items-center">
										<img class="rounded-circle me-3"
											src="https://dummyimage.com/40x40/ced4da/6c757d" alt="..." />
										<div class="small">
											<div class="fw-bold">Kelly Rowan</div>
											<div class="text-muted">March 12, 2022 &middot; 6 min
												read</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-6 mb-4">
						<div class="card h-100 shadow border-0">
							<div class="card-body p-4">
								<div class="badge bg-primary bg-gradient rounded-pill mb-2">Media</div>
								<a class="text-decoration-none link-dark stretched-link"
									href="#!"><h5 class="card-title mb-3">Another blog
										post title</h5></a>
								<p class="card-text mb-0">This text is a bit longer to
									illustrate the adaptive height of each card. Some quick example
									text to build on the card title and make up the bulk of the
									card's content.</p>
							</div>
							<div class="card-footer p-4 pt-0 bg-transparent border-top-0">
								<div class="d-flex align-items-end justify-content-between">
									<div class="d-flex align-items-center">
										<img class="rounded-circle me-3"
											src="https://dummyimage.com/40x40/ced4da/6c757d" alt="..." />
										<div class="small">
											<div class="fw-bold">Josiah Barclay</div>
											<div class="text-muted">March 23, 2022 &middot; 4 min
												read</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-6 mb-4">
						<div class="card h-100 shadow border-0">
							<div class="card-body p-4">
								<div class="badge bg-primary bg-gradient rounded-pill mb-2">News</div>
								<a class="text-decoration-none link-dark stretched-link"
									href="#!"><h5 class="card-title mb-3">The last blog
										post title is a little bit longer than the others</h5></a>
								<p class="card-text mb-0">Some more quick example text to
									build on the card title and make up the bulk of the card's
									content.</p>
							</div>
							<div class="card-footer p-4 pt-0 bg-transparent border-top-0">
								<div class="d-flex align-items-end justify-content-between">
									<div class="d-flex align-items-center">
										<img class="rounded-circle me-3"
											src="https://dummyimage.com/40x40/ced4da/6c757d" alt="..." />
										<div class="small">
											<div class="fw-bold">Evelyn Martinez</div>
											<div class="text-muted">April 2, 2022 &middot; 10 min
												read</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-6 mb-4">
						<div class="card h-100 shadow border-0">
							<div class="card-body p-4">
								<div class="badge bg-primary bg-gradient rounded-pill mb-2">News</div>
								<a class="text-decoration-none link-dark stretched-link"
									href="#!"><h5 class="card-title mb-3">The last blog
										post title is a little bit longer than the others</h5></a>
								<p class="card-text mb-0">Some more quick example text to
									build on the card title and make up the bulk of the card's
									content.</p>
							</div>
							<div class="card-footer p-4 pt-0 bg-transparent border-top-0">
								<div class="d-flex align-items-end justify-content-between">
									<div class="d-flex align-items-center">
										<img class="rounded-circle me-3"
											src="https://dummyimage.com/40x40/ced4da/6c757d" alt="..." />
										<div class="small">
											<div class="fw-bold">Evelyn Martinez</div>
											<div class="text-muted">April 2, 2022 &middot; 10 min
												read</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</section>
	</main>
 <!--footer -->
 <%@ include file="../include/footer.jsp" %>
</body>
</html>