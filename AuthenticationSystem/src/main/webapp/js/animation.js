// animations.js
document.addEventListener('DOMContentLoaded', function() {
    // Input focus effects
    const inputs = document.querySelectorAll('.form-control');
    inputs.forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.classList.add('focused');
        });
        
        input.addEventListener('blur', function() {
            if (this.value === '') {
                this.parentElement.classList.remove('focused');
            }
        });
    });

    // Form submission loading animation
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            const btn = this.querySelector('.btn');
            if (btn && !btn.querySelector('.loading')) {
                const loadingSpan = document.createElement('span');
                loadingSpan.className = 'loading';
                btn.innerHTML += ' ';
                btn.appendChild(loadingSpan);
                btn.disabled = true;
            }
        });
    });

    // Password strength indicator
    const passwordInput = document.querySelector('input[type="password"]');
    if (passwordInput) {
        passwordInput.addEventListener('input', function() {
            const strength = checkPasswordStrength(this.value);
            updateStrengthIndicator(strength);
        });
    }
});

function checkPasswordStrength(password) {
    let strength = 0;
    if (password.length >= 8) strength++;
    if (/[A-Z]/.test(password)) strength++;
    if (/[0-9]/.test(password)) strength++;
    if (/[^A-Za-z0-9]/.test(password)) strength++;
    return strength;
}

function updateStrengthIndicator(strength) {
    let indicator = document.querySelector('.strength-indicator');
    if (!indicator) return;
    
    indicator.className = 'strength-indicator strength-' + strength;
}