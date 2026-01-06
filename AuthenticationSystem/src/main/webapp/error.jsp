<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error - Auth System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="logo">
                <h1 style="color: #f44336;"><i class="fas fa-exclamation-triangle"></i> Oops!</h1>
            </div>
            
            <div style="text-align: center; padding: 20px;">
                <h2>Something went wrong</h2>
                <p>${pageContext.exception.message}</p>
                <p>Error Code: ${pageContext.errorData.statusCode}</p>
                
                <div style="margin-top: 30px;">
                    <a href="login.jsp" class="btn">Return to Login</a>
                    <a href="register.jsp" class="btn" style="background: #6c757d;">Go to Register</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>