class CurriculumData {
  static final List<Map<String, dynamic>> masterCourses = [
    {
      'id': 'html',
      'title': 'HTML Complete Masterclass',
      'category': 'Frontend',
      'desc': 'From basics to advanced HTML5 features.',
      'modules': [
        'Introduction to HTML', 'HTML Document Structure', 'HTML Elements', 'Headings', 'Paragraphs',
        'Text Formatting', 'Comments', 'Links', 'Images', 'Lists',
        'Tables', 'Forms Introduction', 'Input Elements', 'Advanced Inputs', 'Radio Buttons & Checkboxes',
        'Select Dropdown', 'Textarea', 'Buttons', 'Form Validation', 'Complete Registration Form Project',
        'Semantic HTML', 'Audio Elements', 'Video Elements', 'Iframes', 'Meta Tags',
        'HTML Entities', 'SVG Basics', 'Canvas Basics', 'Accessibility (A11Y)', 'SEO Friendly HTML',
        'Responsive HTML Structure', 'HTML for WordPress Development', 'HTML Email Templates', 'Schema Markup', 'Open Graph Tags',
        'Microdata', 'Performance Optimization', 'Security Best Practices', 'HTML Architecture for Large Projects', 'Enterprise Website Structure',
        'HTML5 APIs Overview', 'Drag and Drop API', 'Geolocation API', 'Web Storage API', 'Offline Applications',
        'Progressive Web App Foundations', 'Browser Rendering Concepts', 'Advanced Accessibility', 'HTML Standards & Specifications', 'Future of HTML'
      ]
    },
    {
      'id': 'css',
      'title': 'CSS Complete Masterclass',
      'category': 'Frontend',
      'desc': 'Style the web from scratch.',
      'modules': [
        'Introduction to CSS', 'CSS Syntax', 'Ways to Apply CSS', 'Selectors', 'Colors',
        'Backgrounds', 'Borders', 'Width and Height', 'Margin', 'Padding',
        'Box Model', 'Typography', 'Text Styling', 'Display Property', 'Positioning',
        'Float & Clear', 'Overflow', 'Z-Index', 'Pseudo Classes', 'Pseudo Elements',
        'Flexbox Introduction', 'Flexbox Alignment', 'CSS Grid Introduction', 'Advanced Grid Layouts', 'Media Queries',
        'CSS Variables', 'Transitions', 'Animations', 'Transformations', 'Modern Layout Systems',
        'Responsive Design Systems', 'Mobile First Development', 'CSS Architecture', 'CSS Performance Optimization', 'CSS Accessibility',
        'Dark Mode Implementation', 'Glassmorphism Design', 'Neumorphism Design', 'CSS for WordPress Themes', 'Enterprise UI Systems',
        'Advanced Animations', 'CSS Design Systems', 'Utility First CSS Concepts', 'Tailwind CSS Fundamentals', 'CSS Framework Architecture',
        'Cross Browser Compatibility', 'Advanced Responsive Strategies', 'CSS Debugging Techniques', 'Future of CSS', 'Enterprise Frontend Styling'
      ]
    },
    {
      'id': 'javascript',
      'title': 'JavaScript Complete Masterclass',
      'category': 'Frontend',
      'desc': 'Interactive programming for the web.',
      'modules': [
        'Introduction to JavaScript', 'Setting Up Environment', 'Variables', 'Data Types', 'Operators',
        'User Input & Output', 'Conditional Statements', 'Loops', 'Functions', 'Arrays',
        'Objects', 'DOM Manipulation', 'Events', 'Forms Validation', 'Local Storage',
        'Session Storage', 'JSON', 'Error Handling', 'Modules', 'Debugging Techniques',
        'ES6 Features', 'Classes & OOP', 'Inheritance', 'Closures', 'Scope & Hoisting',
        'Callbacks', 'Promises', 'Async / Await', 'Fetch API', 'REST API Consumption',
        'Advanced Array Methods', 'Functional Programming', 'Event Loop', 'Call Stack', 'Memory Management',
        'Browser Rendering', 'Performance Optimization', 'Security Best Practices', 'Authentication Concepts', 'Real-Time Applications',
        'Design Patterns', 'Dependency Injection', 'WebSockets', 'Service Workers', 'Progressive Web Apps',
        'Advanced Security', 'Micro Frontend Concepts', 'Testing', 'Architecture Patterns', 'Enterprise JavaScript'
      ]
    },
    {
      'id': 'php',
      'title': 'PHP Complete Masterclass',
      'category': 'Backend',
      'desc': 'Server-side logic and database connectivity.',
      'modules': [
        'Introduction to PHP', 'PHP Installation & Setup', 'PHP Syntax', 'Variables', 'Data Types',
        'Constants', 'Operators', 'Input & Output', 'Conditional Statements', 'Loops',
        'Functions', 'Arrays', 'String Functions', 'Date & Time', 'Forms Handling',
        'Sessions', 'Cookies', 'File Handling', 'File Upload', 'Error Handling',
        'Object Oriented Programming', 'Constructors & Destructors', 'Inheritance', 'Encapsulation', 'Polymorphism',
        'Abstraction', 'Interfaces', 'Traits', 'Namespaces', 'Exception Handling',
        'MySQL Introduction', 'Database Connection', 'CRUD Operations', 'Prepared Statements', 'Transactions',
        'Authentication System', 'Authorization', 'REST API Development', 'JWT Authentication', 'Email Integration',
        'MVC Architecture', 'Composer', 'Laravel Introduction', 'Laravel Eloquent', 'Middleware',
        'Authentication in Laravel', 'REST API with Laravel', 'Testing', 'Security Best Practices', 'Deployment'
      ]
    },
    {
      'id': 'mysql',
      'title': 'MySQL Complete Masterclass',
      'category': 'Database',
      'desc': 'Relational databases and queries.',
      'modules': [
        'Introduction to Databases', 'Installing MySQL', 'Creating Databases', 'Tables', 'MySQL Data Types',
        'Insert Data', 'Select Data', 'Filtering Records', 'Sorting Data', 'Update Records',
        'Delete Records', 'Aggregate Functions', 'GROUP BY', 'HAVING Clause', 'Joins Introduction',
        'INNER JOIN', 'LEFT JOIN', 'RIGHT JOIN', 'SELF JOIN', 'UNION',
        'Primary Keys', 'Foreign Keys', 'One-to-One Relationships', 'One-to-Many Relationships', 'Many-to-Many Relationships',
        'Normalization', 'Indexes', 'Views', 'Stored Procedures', 'Triggers',
        'Transactions', 'ACID Properties', 'Database Security', 'Backup & Restore', 'Query Optimization',
        'Database Design', 'MySQL with PHP', 'MySQL with Laravel', 'MySQL with WordPress', 'MySQL for Large Applications',
        'Database Replication', 'Database Partitioning', 'Sharding Concepts', 'High Availability', 'Performance Monitoring',
        'Data Warehousing Concepts', 'ETL Concepts', 'MySQL Architecture', 'MySQL Internals', 'Enterprise Database Design'
      ]
    },
    {
      'id': 'java',
      'title': 'Java Complete Masterclass',
      'category': 'Programming',
      'desc': 'Robust OOP language for enterprise.',
      'modules': [
        'Introduction', 'JVM', 'Variables', 'Data Types', 'Operators',
        'Conditions', 'Loops', 'Methods', 'Arrays', 'OOP', 'Inheritance',
        'Polymorphism', 'Abstraction', 'Encapsulation', 'Exception Handling',
        'Collections', 'Multithreading', 'JDBC', 'Spring Boot Basics', 'Banking Project'
      ]
    },
    {
      'id': 'git',
      'title': 'Git & GitHub Masterclass',
      'category': 'Version Control',
      'desc': 'Industry standard version control.',
      'modules': [
        'Introduction to Version Control', 'Installing Git', 'Git Configuration', 'Creating a Repository', 'Git Status',
        'Staging Files', 'Committing Changes', 'Viewing History', 'Ignoring Files', 'Undo Changes',
        'Git Branching', 'Creating Branches', 'Merging Branches', 'Merge Conflicts', 'Git Stash',
        'Tags', 'Git Rebase', 'Cherry Pick', 'Git Aliases', 'Git Workflow',
        'GitHub Introduction', 'Creating GitHub Repository', 'Connecting Git to GitHub', 'Pushing Code', 'Pulling Changes',
        'Forking Repositories', 'Pull Requests', 'Issues', 'GitHub Discussions', 'GitHub Projects',
        'GitHub Actions', 'GitHub Pages', 'Secrets Management', 'Branch Protection Rules', 'Code Reviews',
        'Advanced Pull Requests', 'Monorepo Concepts', 'Open Source Contribution Workflow', 'Release Management', 'GitHub Enterprise Concepts',
        'Advanced Git Internals', 'Git Object Model', 'Git Hooks', 'Advanced Rebase Strategies', 'Git Bisect',
        'Repository Optimization', 'Enterprise Workflows', 'DevOps Integration', 'Large Team Collaboration', 'Git Best Practices at Scale'
      ]
    },
    {
      'id': 'wordpress',
      'title': 'WordPress Complete Masterclass',
      'category': 'CMS',
      'desc': 'World\'s most popular CMS.',
      'modules': [
        'Introduction to WordPress', 'Domain & Hosting Basics', 'WordPress Installation', 'WordPress Dashboard', 'Pages and Posts',
        'Media Library', 'Menus', 'Widgets', 'Users & Roles', 'Theme Installation',
        'Elementor Introduction', 'Advanced Elementor', 'Theme Customization', 'Essential Plugins', 'Forms',
        'SEO Fundamentals', 'Security Basics', 'Website Backup', 'Performance Optimization', 'Responsive Design',
        'WooCommerce Introduction', 'Product Management', 'Payment Gateways', 'Shipping Configuration', 'Coupon Systems',
        'WooCommerce Customization', 'Custom Post Types', 'Custom Taxonomies', 'Membership Websites', 'LMS Websites',
        'WordPress Database Structure', 'Theme Development', 'Child Themes', 'Plugin Development', 'Actions & Filters',
        'REST API', 'Custom Gutenberg Blocks', 'Headless WordPress', 'Multisite', 'Enterprise WordPress',
        'Advanced Security', 'Server Optimization', 'Advanced WooCommerce Development', 'Custom API Integrations', 'Webhooks',
        'Performance Tuning', 'WordPress Architecture', 'Enterprise Deployments', 'DevOps for WordPress', 'Large Scale WordPress Systems'
      ]
    },
    {
      'id': 'uiux',
      'title': 'UI/UX Design Masterclass',
      'category': 'Design',
      'desc': 'Design principles and prototyping.',
      'modules': [
        'Introduction to UI/UX', 'Design Fundamentals', 'Design Thinking', 'User-Centered Design', 'User Research',
        'Personas', 'User Journey Mapping', 'Information Architecture', 'User Flows', 'UX Writing',
        'Wireframing Basics', 'Digital Wireframing', 'Figma Introduction', 'Figma Components', 'Auto Layout',
        'Typography', 'Color Theory', 'Iconography', 'Visual Hierarchy', 'Responsive Design',
        'Design Systems', 'UI Kits', 'Advanced Prototyping', 'Mobile App Design', 'Web Application Design',
        'Ecommerce UX', 'Accessibility Design', 'Interaction Design', 'Usability Testing', 'UX Metrics',
        'Product Design Process', 'Design Audits', 'Heuristic Evaluation', 'A/B Testing', 'UX Strategy',
        'Business Goals & UX', 'Stakeholder Communication', 'Design Documentation', 'Team Collaboration', 'Agile UX Design',
        'Enterprise Design Systems', 'SaaS Product Design', 'Dashboard UX', 'AI Product UX', 'UX for ERP Systems',
        'UX for CRM Platforms', 'Advanced Research Methods', 'Product Thinking', 'Design Leadership', 'Future of UX Design'
      ]
    },
    {
      'id': 'reactjs',
      'title': 'React JS Complete Masterclass',
      'category': 'Frontend',
      'desc': 'Modern declarative UI library.',
      'modules': List.generate(20, (index) => 'React Module ${index + 1}')
    },
    {
      'id': 'nodejs',
      'title': 'Node JS Complete Masterclass',
      'category': 'Backend',
      'desc': 'Server-side JavaScript environment.',
      'modules': List.generate(20, (index) => 'Node JS Module ${index + 1}')
    },
    {
      'id': 'python',
      'title': 'Python Complete Masterclass',
      'category': 'Programming',
      'desc': 'Versatile data and web programming language.',
      'modules': List.generate(25, (index) => 'Python Module ${index + 1}')
    },
    {
      'id': 'c',
      'title': 'C Programming Masterclass',
      'category': 'Programming',
      'desc': 'Foundation of modern computing.',
      'modules': List.generate(20, (index) => 'C Module ${index + 1}')
    },
    {
      'id': 'cpp',
      'title': 'C++ Programming Masterclass',
      'category': 'Programming',
      'desc': 'High-performance system language.',
      'modules': List.generate(20, (index) => 'C++ Module ${index + 1}')
    },
    {
      'id': 'flutter',
      'title': 'Flutter Complete Masterclass',
      'category': 'Mobile',
      'desc': 'Cross-platform app development.',
      'modules': List.generate(25, (index) => 'Flutter Module ${index + 1}')
    },
    {
      'id': 'hr_interview',
      'title': 'HR & General Interview Preparation',
      'category': 'Interview Prep',
      'desc': 'Master the general HR and behavioral interview questions.',
      'modules': [
        'Introduction to HR Interviews', 'Tell Me About Yourself', 'Strengths and Weaknesses',
        'Why Should We Hire You?', 'Career Goals', 'Handling Pressure & Stress',
        'Teamwork & Collaboration', 'Behavioral Questions', 'Salary Expectations',
        'Questions to Ask the Interviewer', 'Mock Interview Practice'
      ]
    }
  ];
}
