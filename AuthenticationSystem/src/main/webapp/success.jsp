<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Success - Auth System</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="logo">
                <div class="success-icon" style="font-size: 80px; color: #4CAF50; margin-bottom: 20px;">
                    <i class="fas fa-check-circle"></i>
                </div>
                <h1>Welcome, ${username}!</h1>
                <p>You have successfully logged in</p>
            </div>
            
            <div class="user-info" style="text-align: center; margin: 30px 0;">
                <p><i class="fas fa-user"></i> Username: ${username}</p>
                <p><i class="fas fa-envelope"></i> Email: ${email}</p>
                <p><i class="fas fa-calendar-alt"></i> Member since: ${joinDate}</p>
            </div>
            
            <div class="actions" style="display: flex; gap: 10px;">
                <a href="login.jsp" class="btn" style="background: #6c757d;">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
                <a href="#" class="btn" style="background: #2196F3;">
                    <i class="fas fa-cog"></i> Settings
                </a>
            </div>
        </div>
    </div>
</body>
</html>