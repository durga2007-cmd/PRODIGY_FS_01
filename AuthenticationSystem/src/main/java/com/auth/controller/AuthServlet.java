package com.auth.controller;

import com.auth.dao.UserDAO;
import com.auth.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String path = request.getServletPath();
        
        // Debug logging
        System.out.println("GET Request - Action: " + action + ", Path: " + path);
        
        // If action is logout, handle logout
        if ("logout".equals(action)) {
            handleLogout(request, response);
        } else {
            // Otherwise redirect to login page
            response.sendRedirect("login.jsp");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        // Debug logging
        System.out.println("POST Request - Action: " + action);
        
        if ("register".equals(action)) {
            handleRegister(request, response);
        } else if ("login".equals(action)) {
            handleLogin(request, response);
        } else {
            // Default: redirect to login
            response.sendRedirect("login.jsp");
        }
    }
    
    private void handleRegister(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Debug logging
        System.out.println("Register attempt - Username: " + username + ", Email: " + email);
        
        // Basic validation
        if (username == null || username.trim().isEmpty()) {
            setErrorMessage(request, "Username is required!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        if (password == null || password.trim().isEmpty()) {
            setErrorMessage(request, "Password is required!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        if (email == null || email.trim().isEmpty()) {
            setErrorMessage(request, "Email is required!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Check password confirmation
        if (!password.equals(confirmPassword)) {
            setErrorMessage(request, "Passwords do not match!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Check password length
        if (password.length() < 6) {
            setErrorMessage(request, "Password must be at least 6 characters long!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Check if username already exists
        if (userDAO.usernameExists(username)) {
            setErrorMessage(request, "Username already exists! Please choose a different username.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Check if email already exists
        if (userDAO.emailExists(email)) {
            setErrorMessage(request, "Email already registered! Please use a different email.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // Create user object
        User user = new User(username, password, email);
        
        // Attempt registration
        boolean isRegistered = userDAO.registerUser(user);
        
        if (isRegistered) {
            System.out.println("Registration successful for user: " + username);
            
            // Set success message
            request.setAttribute("message", "Registration successful! You can now login.");
            request.setAttribute("messageType", "success");
            
            // Forward to login page
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            setErrorMessage(request, "Registration failed! Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
    
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Debug logging
        System.out.println("Login attempt - Username: " + username);
        
        // Basic validation
        if (username == null || username.trim().isEmpty()) {
            setErrorMessage(request, "Username is required!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        if (password == null || password.trim().isEmpty()) {
            setErrorMessage(request, "Password is required!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        // Attempt login
        User user = userDAO.loginUser(username, password);
        
        if (user != null) {
            System.out.println("Login successful for user: " + username);
            
            // Create session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("email", user.getEmail());
            
            // Set session timeout (30 minutes)
            session.setMaxInactiveInterval(30 * 60);
            
            // Set success message
            request.setAttribute("message", "Login successful!");
            request.setAttribute("messageType", "success");
            request.setAttribute("username", user.getUsername());
            request.setAttribute("email", user.getEmail());
            
            // Forward to success page
            request.getRequestDispatcher("success.jsp").forward(request, response);
        } else {
            setErrorMessage(request, "Invalid username or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    private void handleLogout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Invalidate session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        // Set logout message
        request.setAttribute("message", "You have been logged out successfully.");
        request.setAttribute("messageType", "success");
        
        // Redirect to login page
        response.sendRedirect("login.jsp");
    }
    
    // Helper method to set error messages
    private void setErrorMessage(HttpServletRequest request, String message) {
        request.setAttribute("message", message);
        request.setAttribute("messageType", "error");
    }
}