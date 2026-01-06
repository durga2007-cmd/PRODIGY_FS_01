<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | SecureAuth</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .password-container {
            position: relative;
        }
        
        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #667eea;
            transition: color 0.3s;
        }
        
        .password-toggle:hover {
            color: #764ba2;
        }
        
        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .remember-me {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .remember-me input[type="checkbox"] {
            width: 18px;
            height: 18px;
            accent-color: #667eea;
        }
        
        .forgot-password {
            color: #667eea;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s;
        }
        
        .forgot-password:hover {
            color: #764ba2;
            text-decoration: underline;
        }
        
        .social-login {
            margin-top: 25px;
            text-align: center;
        }
        
        .social-login p {
            color: #666;
            margin-bottom: 15px;
            position: relative;
        }
        
        .social-login p::before,
        .social-login p::after {
            content: "";
            position: absolute;
            top: 50%;
            width: 30%;
            height: 1px;
            background: #e1e1e1;
        }
        
        .social-login p::before {
            left: 0;
        }
        
        .social-login p::after {
            right: 0;
        }
        
        .social-icons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 15px;
        }
        
        .social-icon {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 18px;
            transition: all 0.3s;
            cursor: pointer;
        }
        
        .social-icon.google {
            background: #DB4437;
        }
        
        .social-icon.facebook {
            background: #4267B2;
        }
        
        .social-icon.twitter {
            background: #1DA1F2;
        }
        
        .social-icon:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .demo-credentials {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            margin-top: 20px;
            font-size: 13px;
            color: #666;
        }
        
        .demo-credentials h4 {
            color: #667eea;
            margin-bottom: 8px;
            font-size: 14px;
        }
        
        .demo-credentials ul {
            margin: 0;
            padding-left: 20px;
        }
        
        .demo-credentials li {
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <!-- Animated Logo -->
            <div class="logo">
                <div class="logo-icon" style="font-size: 48px; color: #667eea; margin-bottom: 10px;">
                    <i class="fas fa-lock"></i>
                </div>
                <h1>Welcome Back</h1>
                <p class="subtitle">Sign in to your account to continue</p>
            </div>
            
            <!-- Display Messages -->
            <%
                String message = (String) request.getAttribute("message");
                String messageType = (String) request.getAttribute("messageType");
                
                if (message != null && !message.isEmpty()) {
                    String alertClass = "error";
                    String icon = "fas fa-exclamation-circle";
                    
                    if ("success".equals(messageType)) {
                        alertClass = "success";
                        icon = "fas fa-check-circle";
                    }
            %>
                <div class="message <%= alertClass %> fade-in">
                    <i class="<%= icon %>"></i> <%= message %>
                </div>
            <% } %>
            
            <!-- Login Form -->
            <form id="loginForm" action="auth" method="post" autocomplete="off">
                <input type="hidden" name="action" value="login">
                
                <div class="form-group">
                    <label for="username">
                        <i class="fas fa-user"></i> Username
                    </label>
                    <input type="text" 
                           id="username" 
                           name="username" 
                           class="form-control" 
                           placeholder="Enter your username" 
                           required
                           autofocus
                           value="<%= request.getParameter("username") != null ? 
                                   request.getParameter("username") : "" %>">
                    <div class="input-hint">Enter your registered username</div>
                </div>
                
                <div class="form-group">
                    <label for="password">
                        <i class="fas fa-key"></i> Password
                    </label>
                    <div class="password-container">
                        <input type="password" 
                               id="password" 
                               name="password" 
                               class="form-control" 
                               placeholder="Enter your password" 
                               required
                               minlength="6">
                        <span class="password-toggle" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </span>
                    </div>
                    <div class="input-hint">Minimum 6 characters</div>
                </div>
                
                <div class="remember-forgot">
                    <div class="remember-me">
                        <input type="checkbox" id="remember" name="remember">
                        <label for="remember">Remember me</label>
                    </div>
                    <a href="#" class="forgot-password" id="forgotPassword">
                        Forgot Password?
                    </a>
                </div>
                
                <button type="submit" class="btn login-btn" id="loginBtn">
                    <i class="fas fa-sign-in-alt"></i> 
                    <span>Sign In</span>
                    <div class="spinner hidden" id="loginSpinner"></div>
                </button>
            </form>
            
            <!-- Social Login (Optional) -->
            <div class="social-login">
                <p>Or continue with</p>
                <div class="social-icons">
                    <div class="social-icon google" title="Google">
                        <i class="fab fa-google"></i>
                    </div>
                    <div class="social-icon facebook" title="Facebook">
                        <i class="fab fa-facebook-f"></i>
                    </div>
                    <div class="social-icon twitter" title="Twitter">
                        <i class="fab fa-twitter"></i>
                    </div>
                </div>
            </div>
            
            <!-- Demo Credentials (Remove in production) -->
            <div class="demo-credentials">
                <h4><i class="fas fa-info-circle"></i> Demo Credentials</h4>
                <ul>
                    <li>Username: <strong>admin</strong> | Password: <strong>admin123</strong></li>
                    <li>Username: <strong>user1</strong> | Password: <strong>password123</strong></li>
                </ul>
                <p style="margin-top: 8px; font-style: italic; color: #888;">
                    Register new users for testing
                </p>
            </div>
            
            <!-- Registration Link -->
            <div class="link-group">
                <p>Don't have an account? 
                    <a href="register.jsp" class="register-link">
                        <i class="fas fa-user-plus"></i> Create Account
                    </a>
                </p>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script>
        // Password visibility toggle
        const togglePassword = document.getElementById('togglePassword');
        const password = document.getElementById('password');
        
        if (togglePassword) {
            togglePassword.addEventListener('click', function() {
                const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                password.setAttribute('type', type);
                
                const icon = this.querySelector('i');
                if (type === 'password') {
                    icon.classList.remove('fa-eye-slash');
                    icon.classList.add('fa-eye');
                } else {
                    icon.classList.remove('fa-eye');
                    icon.classList.add('fa-eye-slash');
                }
            });
        }
        
        // Form submission with loading animation
        const loginForm = document.getElementById('loginForm');
        const loginBtn = document.getElementById('loginBtn');
        const loginSpinner = document.getElementById('loginSpinner');
        
        if (loginForm) {
            loginForm.addEventListener('submit', function(e) {
                // Basic validation
                const username = document.getElementById('username').value.trim();
                const password = document.getElementById('password').value.trim();
                
                if (!username || !password) {
                    e.preventDefault();
                    showError('Please fill in all fields');
                    return false;
                }
                
                if (password.length < 6) {
                    e.preventDefault();
                    showError('Password must be at least 6 characters');
                    return false;
                }
                
                // Show loading animation
                if (loginBtn && loginSpinner) {
                    loginBtn.disabled = true;
                    loginSpinner.classList.remove('hidden');
                    loginBtn.querySelector('span').textContent = 'Signing in...';
                }
                
                return true;
            });
        }
        
        // Forgot password modal
        const forgotPassword = document.getElementById('forgotPassword');
        if (forgotPassword) {
            forgotPassword.addEventListener('click', function(e) {
                e.preventDefault();
                alert('Password reset feature coming soon!');
            });
        }
        
        // Social login buttons
        document.querySelectorAll('.social-icon').forEach(icon => {
            icon.addEventListener('click', function() {
                const platform = this.title.toLowerCase();
                alert(`${platform.charAt(0).toUpperCase() + platform.slice(1)} login integration coming soon!`);
            });
        });
        
        // Error display function
        function showError(message) {
            // Remove existing error messages
            const existingErrors = document.querySelectorAll('.message.error');
            existingErrors.forEach(error => error.remove());
            
            // Create new error message
            const errorDiv = document.createElement('div');
            errorDiv.className = 'message error fade-in';
            errorDiv.innerHTML = `<i class="fas fa-exclamation-circle"></i> ${message}`;
            
            // Insert after logo
            const logo = document.querySelector('.logo');
            if (logo) {
                logo.parentNode.insertBefore(errorDiv, logo.nextSibling);
            }
            
            // Auto remove after 5 seconds
            setTimeout(() => {
                if (errorDiv.parentNode) {
                    errorDiv.classList.add('fade-out');
                    setTimeout(() => errorDiv.remove(), 500);
                }
            }, 5000);
        }
        
        // Auto-focus username field
        window.addEventListener('load', function() {
            const usernameField = document.getElementById('username');
            if (usernameField && !usernameField.value) {
                usernameField.focus();
            }
        });
    </script>
    
    <!-- Add to style.css or here -->
    <style>
        .fade-in {
            animation: fadeIn 0.5s ease-out;
        }
        
        .fade-out {
            animation: fadeOut 0.5s ease-out forwards;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        @keyframes fadeOut {
            from { opacity: 1; transform: translateY(0); }
            to { opacity: 0; transform: translateY(-10px); }
        }
        
        .hidden {
            display: none !important;
        }
        
        .spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,.3);
            border-radius: 50%;
            border-top-color: #fff;
            animation: spin 1s linear infinite;
            margin-left: 10px;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        .input-hint {
            font-size: 12px;
            color: #888;
            margin-top: 5px;
            margin-left: 5px;
        }
        
        .subtitle {
            color: #666;
            margin-top: 5px;
            font-size: 14px;
        }
        
        .register-link {
            font-weight: 600;
            color: #667eea;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .register-link:hover {
            color: #764ba2;
            text-decoration: underline;
        }
    </style>
</body>
</html>