-- 1. Create and select the database
CREATE DATABASE IF NOT EXISTS anonymous_feedback;
USE anonymous_feedback;

-- 2. Create Users Table (Admin Accounts)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Create Feedback Forms Table (Linked to User)
CREATE TABLE feedback_forms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    unique_code VARCHAR(12) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 4. Create Feedback Table (Linked ONLY to Form — NO user/identity columns)
CREATE TABLE feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    form_id INT NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (form_id) REFERENCES feedback_forms(id) ON DELETE CASCADE
);



-- Create an admin user
INSERT INTO users (username, email, password) 
VALUES ('Malatesh', 'admin@gmail.com', 'hashed_pass_123');

-- Create a form for Malatesh (user_id = 1)
INSERT INTO feedback_forms (user_id, title, description, unique_code) 
VALUES (1, 'Placement Training Feedback', 'Share honest feedback about aptitude and mock tests.', 'A8K29X');

-- Submit anonymous feedback for Form #1
INSERT INTO feedback (form_id, message) 
VALUES (1, 'The mock interviews were very helpful, but we need more coding sessions.');

-- Verify data output
SELECT f.id, ff.title, f.message, f.created_at 
FROM feedback f
JOIN feedback_forms ff ON f.form_id = ff.id
WHERE ff.unique_code = 'A8K29X';