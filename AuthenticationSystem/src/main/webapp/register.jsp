<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Auth System</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="logo">
                <h1><i class="fas fa-user-plus"></i> Register</h1>
                <p>Create your account</p>
            </div>
            
            <% if(request.getAttribute("message") != null) { %>
                <div class="message ${messageType}">
                    ${message}
                </div>
            <% } %>
            
            <form action="auth" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="action" value="register">
                
                <div class="form-group">
                    <label for="username"><i class="fas fa-user"></i> Username</label>
                    <input type="text" 
                           id="username" 
                           name="username" 
                           class="form-control" 
                           placeholder="Enter username" 
                           required
                           minlength="3"
                           maxlength="50">
                    <div class="input-icon">
                        <i class="fas fa-check-circle" id="username-check"></i>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="email"><i class="fas fa-envelope"></i> Email</label>
                    <input type="email" 
                           id="email" 
                           name="email" 
                           class="form-control" 
                           placeholder="Enter email" 
                           required>
                    <div class="input-icon">
                        <i class="fas fa-check-circle" id="email-check"></i>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password"><i class="fas fa-lock"></i> Password</label>
                    <input type="password" 
                           id="password" 
                           name="password" 
                           class="form-control" 
                           placeholder="Enter password" 
                           required
                           minlength="8">
                    <div class="strength-indicator"></div>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword"><i class="fas fa-lock"></i> Confirm Password</label>
                    <input type="password" 
                           id="confirmPassword" 
                           name="confirmPassword" 
                           class="form-control" 
                           placeholder="Confirm password" 
                           required>
                    <div class="input-icon">
                        <i class="fas fa-check-circle" id="password-match"></i>
                    </div>
                </div>
                
                <button type="submit" class="btn">
                    <i class="fas fa-user-plus"></i> Create Account
                </button>
            </form>
            
            <div class="link-group">
                <p>Already have an account? <a href="login.jsp">Login here</a></p>
            </div>
        </div>
    </div>
    
    <script src="js/animations.js"></script>
    <script src="js/validation.js"></script>
</body>
</html>