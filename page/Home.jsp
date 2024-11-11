
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Home.jsp</title>

<link rel="stylesheet" href="/YoonSeongBinProj2/template/HomeStyle.css">

</head>
<body>
	<div id="container" class="container">
	<div class="container-fluid">

		<!-- FORM SECTION -->
		<div class="row">
			<!-- SIGN UP -->
			<div class="col align-items-center flex-col sign-up">
				<div class="form-wrapper align-items-center">
					<div class="form sign-up">
						<div class="input-group">
							<i class='bx bxs-user'></i> <input type="text"
								placeholder="Username">
						</div>
						<div class="input-group">
							<i class='bx bx-mail-send'></i> <input type="email"
								placeholder="Email">
						</div>
						<div class="input-group">
							<i class='bx bxs-lock-alt'></i> <input type="password"
								placeholder="Password">
						</div>
						<div class="input-group">
							<i class='bx bxs-lock-alt'></i> <input type="password"
								placeholder="Confirm password">
						</div>
						<button>Sign up</button>
						<p>
							<span> Already have an account? </span> <b onclick="toggle()"
								class="pointer"> Sign in here </b>
						</p>
					</div>
				</div>
			</div>
			<!-- END SIGN UP -->

			<!-- SIGN IN -->
			<div class="col align-items-center flex-col sign-in">
				<div class="form-wrapper align-items-center">
					<div class="form sign-in">

						<%
						String username = (String) session.getAttribute("username");
						String token = (String) session.getAttribute("token");
						if (username != null && token != null) {
						%>
						<a href="${pageContext.request.contextPath}/bbspage/BbsList.jsp"
							class="button">
							<button>게시판 보기</button>
						</a> &nbsp; <a
							href="${pageContext.request.contextPath}/LogoutController"
							class="button">
							<button>로그아웃</button>
						</a>
						<%
						} else {
						%>
						<a href="${pageContext.request.contextPath}/page/Login.jsp"
							class="button">
							<button>로그인</button>
						</a> &nbsp; <a
							href="${pageContext.request.contextPath}/page/SignUp.jsp"
							class="button">
							<button>회원가입</button>
						</a>
						<%
						}
						%>



					</div>
				</div>
				<div class="form-wrapper"></div>
			</div>
			<!-- END SIGN IN -->
		</div>
		<!-- END FORM SECTION -->
		<!-- CONTENT SECTION -->
		<div class="row content-row">
			<!-- SIGN IN CONTENT -->
			<div class="col align-items-center flex-col">
				<div class="text sign-in">
					<h2>
					Home
					</h2>
				</div>
				<div class="img sign-in"></div>
			</div>
			<!-- END SIGN IN CONTENT -->

		</div>
		<!-- END CONTENT SECTION -->
		</div>
	</div>
	
	<script>
        let container = document.getElementById('container')

        toggle = () => {
            container.classList.toggle('sign-in')
            
        }

        setTimeout(() => {
            container.classList.add('sign-in')
        }, 200)
    </script>
</body>
</html>

