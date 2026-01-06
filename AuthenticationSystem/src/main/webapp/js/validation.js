// validation.js
function validateForm() {
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const username = document.getElementById('username').value;
    const email = document.getElementById('email').value;
    
    // Check password match
    if (password !== confirmPassword) {
        showError('Passwords do not match!');
        return false;
    }
    
    // Check password strength
    if (password.length < 8) {
        showError('Password must be at least 8 characters long!');
        return false;
    }
    
    // Check username
    if (username.length < 3) {
        showError('Username must be at least 3 characters long!');
        return false;
    }
    
    // Check email format
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        showError('Please enter a valid email address!');
        return false;
    }
    
    return true;
}

function showError(message) {
    // Create error message element
    let errorDiv = document.createElement('div');
    errorDiv.className = 'message error';
    errorDiv.textContent = message;
    errorDiv.style.animation = 'shake 0.5s';
    
    // Add shake animation
    const style = document.createElement('style');
    style.textContent = `
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }
    `;
    document.head.appendChild(style);
    
    // Insert error message
    const form = document.querySelector('form');
    form.insertBefore(errorDiv, form.firstChild);
    
    // Remove error after 5 seconds
    setTimeout(() => {
        errorDiv.remove();
    }, 5000);
}

// Real-time validation
document.addEventListener('DOMContentLoaded', function() {
    const passwordInput = document.getElementById('password');
    const confirmInput = document.getElementById('confirmPassword');
    const usernameInput = document.getElementById('username');
    const emailInput = document.getElementById('email');
    
    if (passwordInput && confirmInput) {
        confirmInput.addEventListener('input', function() {
            const matchIcon = document.getElementById('password-match');
            if (matchIcon) {
                if (passwordInput.value === this.value && this.value !== '') {
                    matchIcon.style.color = '#4CAF50';
                    matchIcon.className = 'fas fa-check-circle';
                } else {
                    matchIcon.style.color = '#f44336';
                    matchIcon.className = 'fas fa-times-circle';
                }
            }
        });
    }
});