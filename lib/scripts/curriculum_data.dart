class CurriculumData {
  static final List<Map<String, dynamic>> masterCourses = [
    {
      'id': 'html',
      'title': 'HTML Complete Masterclass',
      'category': 'Frontend',
      'desc': 'From basics to advanced HTML5 features.',
      'modules': [
        'Introduction to HTML', 'HTML Structure', 'Headings', 'Paragraphs',
        'Formatting Tags', 'Links', 'Images', 'Lists', 'Tables', 'Forms',
        'Input Types', 'Semantic Elements', 'Audio & Video', 'Iframes',
        'Meta Tags', 'HTML5 Features', 'Accessibility', 'SEO Basics',
        'Responsive HTML', 'Portfolio Project'
      ]
    },
    {
      'id': 'css',
      'title': 'CSS Complete Masterclass',
      'category': 'Frontend',
      'desc': 'Style the web from scratch.',
      'modules': [
        'Introduction to CSS', 'Selectors', 'Colors', 'Backgrounds', 'Borders',
        'Margin', 'Padding', 'Box Model', 'Typography', 'Display', 'Position',
        'Flexbox', 'Grid', 'Responsive Design', 'Media Queries', 'Animations',
        'Transitions', 'Variables', 'Modern CSS', 'Dashboard Project'
      ]
    },
    {
      'id': 'javascript',
      'title': 'JavaScript Complete Masterclass',
      'category': 'Frontend',
      'desc': 'Interactive programming for the web.',
      'modules': [
        'Introduction', 'Variables', 'Data Types', 'Operators', 'Conditions',
        'Loops', 'Functions', 'Arrays', 'Objects', 'DOM', 'Events', 'ES6',
        'Classes', 'Async JavaScript', 'Promises', 'Fetch API', 'Local Storage',
        'Error Handling', 'Modules', 'Weather App Project'
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
        'Version Control', 'Git Installation', 'Repository', 'Commit', 'Push',
        'Pull', 'Branching', 'Merge', 'Conflict Resolution', 'GitHub Workflow',
        'Pull Requests', 'Open Source Contribution', 'GitHub Actions', 'CI/CD',
        'Team Collaboration'
      ]
    },
    {
      'id': 'wordpress',
      'title': 'WordPress Complete Masterclass',
      'category': 'CMS',
      'desc': 'World\'s most popular CMS.',
      'modules': [
        'WordPress Introduction', 'Installation', 'Dashboard', 'Themes', 'Plugins',
        'Pages', 'Posts', 'Menus', 'Widgets', 'Elementor', 'WooCommerce',
        'Product Management', 'SEO', 'Security', 'Speed Optimization', 'Backups',
        'Custom Post Types', 'Theme Development', 'Plugin Development', 'Ecommerce Store Project'
      ]
    },
    {
      'id': 'uiux',
      'title': 'UI/UX Design Masterclass',
      'category': 'Design',
      'desc': 'Design principles and prototyping.',
      'modules': [
        'Introduction', 'UX Principles', 'Design Thinking', 'User Research',
        'Personas', 'User Journey', 'Information Architecture', 'Wireframing',
        'Low Fidelity Design', 'High Fidelity Design', 'Design Systems',
        'Typography', 'Color Theory', 'Accessibility', 'Mobile Design',
        'Web Design', 'Prototyping', 'Usability Testing', 'Portfolio Building',
        'Complete App Design Project'
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
    }
  ];
}
