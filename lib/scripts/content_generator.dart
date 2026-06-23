class ContentGenerator {
  static String generateContent(String courseId, String moduleTitle) {
    switch (courseId) {
      case 'html':
        return _generateHtmlContent(moduleTitle);
      case 'css':
        return _generateCssContent(moduleTitle);
      case 'javascript':
        return _generateJsContent(moduleTitle);
      case 'php':
        return _generatePhpContent(moduleTitle);
      case 'mysql':
        return _generateMysqlContent(moduleTitle);
      case 'java':
        return _generateJavaContent(moduleTitle);
      case 'git':
        return _generateGitContent(moduleTitle);
      case 'wordpress':
        return _generateWordpressContent(moduleTitle);
      case 'uiux':
        return _generateUiUxContent(moduleTitle);
      case 'hr_interview':
        return _generateHrContent(moduleTitle);
      default:
        return _generateGenericContent(moduleTitle);
    }
  }

  static String _generateHtmlContent(String title) {
    return '''
# \$title

Welcome to this comprehensive guide on **\$title** in HTML.

## Overview
HTML (HyperText Markup Language) is the standard markup language for documents designed to be displayed in a web browser. Understanding **\$title** is crucial for building semantic, accessible, and structured web pages.

### Key Concepts
*   **Structure**: HTML provides the skeletal framework of the webpage.
*   **Semantics**: Using the correct tags helps search engines and screen readers understand your content.
*   **Accessibility (A11Y)**: Writing proper HTML ensures all users can navigate your site.

### Practical Example
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>HTML Example: \$title</title>
</head>
<body>
    <header>
        <h1>Mastering \$title</h1>
    </header>
    <main>
        <p>This is a practical implementation of \$title.</p>
    </main>
</body>
</html>
```

## Interview Questions
1. **What is \$title and why is it important in HTML5?**
   *Answer: It is essential for defining document structure, improving SEO, and maintaining semantic correctness across modern browsers.*
2. **What are the common mistakes developers make regarding \$title?**
   *Answer: Using non-semantic tags (like generic `<div>` wrappers) instead of specific semantic elements.*

## Summary
You have now completed the reading for **\$title**. Make sure to practice writing raw HTML files to reinforce this knowledge!
''';
  }

  static String _generateCssContent(String title) {
    return '''
# \$title

Welcome to this comprehensive guide on **\$title** in CSS.

## Overview
CSS (Cascading Style Sheets) is the language we use to style an HTML document. **\$title** is one of the most powerful styling tools in a developer's arsenal.

### Key Concepts
*   **Cascading**: Styles fall (or cascade) from one rule to another.
*   **Specificity**: Understanding which rules override others.
*   **Responsiveness**: Ensuring layouts look great on mobile and desktop.

### Practical Example
```css
/* Styling for \$title */
.container {
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: #0F172A;
    color: #FFFFFF;
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.title-element {
    font-size: 24px;
    font-weight: bold;
    transition: all 0.3s ease;
}

.title-element:hover {
    color: #38BDF8;
}
```

## Interview Questions
1. **Explain the Box Model and how it relates to \$title.**
   *Answer: The Box Model dictates how margins, borders, padding, and content interact. Understanding it is critical for pixel-perfect layouts.*
2. **How does specificity affect \$title?**
   *Answer: ID selectors outweigh classes, which outweigh element selectors. Inline styles usually trump all.*

## Summary
You have now completed the reading for **\$title**. Try styling a codepen block to test these properties visually!
''';
  }

  static String _generateJsContent(String title) {
    return '''
# \$title

Welcome to this comprehensive guide on **\$title** in JavaScript.

## Overview
JavaScript is a high-level, interpreted programming language primarily used to add interactivity to web pages. **\$title** plays a massive role in modern web development frameworks like React, Angular, and Vue.

### Key Concepts
*   **Asynchronous Nature**: Handling events and API calls without blocking the thread.
*   **Functional Programming**: Utilizing callbacks, higher-order functions, and closures.
*   **DOM Manipulation**: Interacting dynamically with the browser.

### Practical Example
```javascript
// Implementation of \$title
class JSModule {
    constructor(name) {
        this.name = name;
    }

    initialize() {
        console.log(`Initializing module: \${this.name}`);
        this.processLogic();
    }

    processLogic() {
        // Core logic for \$title
        const data = [1, 2, 3, 4, 5];
        const processed = data.map(num => num * 2).filter(num => num > 5);
        console.log('Processed Data:', processed);
    }
}

const moduleInstance = new JSModule('\$title');
moduleInstance.initialize();
```

## Interview Questions
1. **What is hoisting, and how does it affect \$title?**
   *Answer: Hoisting is JS's default behavior of moving declarations to the top of the current scope.*
2. **Explain closures in the context of \$title.**
   *Answer: A closure gives you access to an outer function's scope from an inner function.*

## Summary
You have now completed the reading for **\$title**. Execute this code in your browser's console or a Node.js environment.
''';
  }

  static String _generatePhpContent(String title) {
    return '''
# \$title

Welcome to this comprehensive guide on **\$title** in PHP.

## Overview
PHP is a popular general-purpose scripting language that is especially suited to web development. **\$title** is crucial for server-side logic, interacting with databases, and generating dynamic page content.

### Key Concepts
*   **Server-Side Execution**: Code is run on the server before sending HTML to the client.
*   **State Management**: Handling sessions and cookies securely.
*   **Security**: Preventing SQL Injection, XSS, and CSRF attacks.

### Practical Example
```php
<?php
// PHP Script demonstrating \$title

namespace App\\Modules;

class PhpModule {
    private \$title;

    public function __construct(\$title) {
        \$this->title = \$title;
    }

    public function execute() {
        try {
            // Simulated Logic for \$title
            echo "Successfully executed logic for " . htmlspecialchars(\$this->title);
        } catch (\\Exception \$e) {
            error_log(\$e->getMessage());
            echo "An error occurred.";
        }
    }
}

\$module = new PhpModule('\$title');
\$module->execute();
?>
```

## Summary
You have now completed the reading for **\$title**. Practice running this on a local XAMPP/MAMP stack!
''';
  }

  static String _generateMysqlContent(String title) {
    return '''
# \$title

Welcome to this comprehensive guide on **\$title** in MySQL.

## Overview
MySQL is an open-source relational database management system. Mastering **\$title** is essential for optimizing data retrieval, maintaining data integrity, and scaling large applications.

### Key Concepts
*   **Relational Model**: Data is stored in tables linked by common keys.
*   **ACID Properties**: Ensuring reliable transactions (Atomicity, Consistency, Isolation, Durability).
*   **Normalization**: Reducing data redundancy.

### Practical Example
```sql
-- SQL Query demonstrating \$title
CREATE TABLE IF NOT EXISTS module_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Utilizing \$title logic
INSERT INTO module_data (title, description) 
VALUES ('\$title', 'Learning about advanced MySQL concepts');

SELECT * FROM module_data 
WHERE title LIKE '%\$title%' 
ORDER BY created_at DESC;
```

## Summary
You have now completed the reading for **\$title**. Practice these queries in a local database GUI like DBeaver or phpMyAdmin.
''';
  }

  static String _generateJavaContent(String title) {
    return '''
# \$title

Welcome to this comprehensive guide on **\$title** in Java.

## Overview
Java is a high-level, class-based, object-oriented programming language designed to have as few implementation dependencies as possible. **\$title** represents core architectural foundations used in enterprise applications.

### Key Concepts
*   **Object-Oriented Programming (OOP)**: Encapsulation, Inheritance, Polymorphism, Abstraction.
*   **Strong Typing**: Catching errors at compile time.
*   **JVM**: Write once, run anywhere.

### Practical Example
```java
// Java Class demonstrating \$title
package com.codemaster.modules;

import java.util.logging.Logger;

public class JavaModule {
    private static final Logger LOGGER = Logger.getLogger(JavaModule.class.getName());
    private final String title;

    public JavaModule(String title) {
        this.title = title;
    }

    public void processLogic() {
        LOGGER.info("Starting processing for: " + this.title);
        
        // Implementing \$title
        try {
            System.out.println("Executing enterprise logic for " + this.title);
        } catch (Exception e) {
            LOGGER.severe("Exception occurred: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        JavaModule module = new JavaModule("\$title");
        module.processLogic();
    }
}
```

## Summary
You have now completed the reading for **\$title**. Try compiling this in IntelliJ IDEA or Eclipse.
''';
  }

  static String _generateGitContent(String title) {
    return '''
# \$title

Welcome to this comprehensive guide on **\$title** using Git & GitHub.

## Overview
Git is a distributed version control system that tracks changes in any set of computer files. Understanding **\$title** ensures you can safely collaborate with large teams and reverse breaking changes.

### Key Concepts
*   **Distributed Control**: Every developer has a full backup of the repository.
*   **Branching**: Creating isolated environments for new features.
*   **Remote Repositories**: Collaborating via GitHub.

### Practical Example
```bash
# Terminal commands demonstrating \$title

# Step 1: Initialize and track changes
git init
git add .

# Step 2: Commit related to \$title
git commit -m "feat: implementing \$title"

# Step 3: Branching strategy
git checkout -b feature/advanced-module
git push -u origin feature/advanced-module

# Step 4: Reviewing status
git status
git log --oneline
```

## Summary
You have now completed the reading for **\$title**. Practice these commands in your local terminal before pushing to a live repository.
''';
  }

  static String _generateWordpressContent(String title) {
    return '''
# \$title

Welcome to this comprehensive guide on **\$title** in WordPress.

## Overview
WordPress is the world's most popular Content Management System. **\$title** is a fundamental piece of WP architecture, whether you are building themes, writing plugins, or managing WooCommerce stores.

### Key Concepts
*   **The Loop**: How WordPress retrieves and displays posts.
*   **Hooks (Actions & Filters)**: Injecting custom logic without modifying core files.
*   **Custom Post Types**: Expanding WP beyond just blogs.

### Practical Example
```php
<?php
/**
 * Plugin Name: Codemaster Pro WP Module
 * Description: Demonstrating \$title functionality
 */

// Hooking into WordPress to implement \$title
add_action('init', 'custom_wp_module_init');

function custom_wp_module_init() {
    // Example logic for \$title
    error_log("WordPress \$title module initialized successfully.");
    
    // Registering a custom post type as an example
    register_post_type('custom_module', array(
        'public' => true,
        'label'  => '\$title',
        'supports' => array('title', 'editor', 'thumbnail')
    ));
}
?>
```

## Summary
You have now completed the reading for **\$title**. Install LocalWP on your computer and test this code in the `wp-content/plugins` folder!
''';
  }

  static String _generateUiUxContent(String title) {
    return '''
# \$title

Welcome to this comprehensive guide on **\$title** in UI/UX Design.

## Overview
User Interface (UI) and User Experience (UX) design focus on the visual appearance and functionality of a digital product. Mastering **\$title** will elevate your products from 'functional' to 'delightful'.

### Key Concepts
*   **User Research**: Understanding your target audience's pain points.
*   **Visual Hierarchy**: Guiding the user's eye using size, color, and contrast.
*   **Prototyping**: Testing flows before writing a single line of code.

### Practical Implementation of \$title
When designing for **\$title**, always consider:
1. **Accessibility (WCAG)**: Ensure contrast ratios are at least 4.5:1.
2. **Consistency**: Use a defined Design System or UI Kit.
3. **Feedback**: Always provide visual feedback (hover states, loaders) when a user interacts.

### Figma Workflow
1. Press `A` to create an Artboard.
2. Define Layout Grids (usually a 12-column grid for web).
3. Implement **\$title** principles using Auto Layout (`Shift + A`).
4. Connect components in Prototype mode to simulate real user interactions.

## Summary
You have now completed the reading for **\$title**. Open Figma and try recreating these concepts in your own wireframes!
''';
  }

  static String _generateHrContent(String title) {
    return '''
# \$title

Welcome to this comprehensive guide on **\$title** for HR Interview Preparation.

## Overview
Technical skills get you the interview, but behavioral and soft skills secure the job offer. Mastering **\$title** guarantees you will leave a lasting, professional impression on recruiters and engineering managers.

### The STAR Method
When addressing **\$title**, always use the STAR method:
*   **S**ituation: Set the scene and give necessary details of your example.
*   **T**ask: Describe what your responsibility was in that situation.
*   **A**ction: Explain exactly what steps you took to address it.
*   **R**esult: Share what outcomes your actions achieved (use metrics!).

### Practical Interview Response: \$title
**Interviewer:** "Can you tell me about a time you had to deal with \$title?"

**Your Blueprint Answer:**
"Absolutely. In my previous role, we encountered a situation where **[Situation]**. My responsibility was to ensure **[Task]**. 

To resolve this, I implemented **[Action related to \$title]**, making sure to communicate transparently with my team throughout the process. 

As a result, we successfully **[Result]**, which increased our team's efficiency by 20%."

## Summary
You have now completed the reading for **\$title**. Practice answering this aloud in front of a mirror to build confidence!
''';
  }

  static String _generateGenericContent(String title) {
    return '''
# \$title

Welcome to this comprehensive guide on **\$title**.

## Overview
Understanding **\$title** is crucial for modern development. It forms the backbone of many professional architectures and workflows.

### Key Concepts
*   **Fundamentals**: Grasp the core syntax and basic principles.
*   **Best Practices**: Learn how the industry utilizes these patterns.
*   **Common Pitfalls**: What to avoid when writing production code.

## Summary
You have now completed the reading for **\$title**. Make sure to practice the concepts and test your knowledge!
''';
  }
}
