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
        'PHP Introduction', 'Installation', 'Syntax', 'Variables', 'Data Types',
        'Operators', 'Conditions', 'Loops', 'Functions', 'Arrays', 'Forms',
        'Sessions', 'Cookies', 'File Handling', 'OOP', 'MySQL Integration',
        'CRUD Operations', 'Authentication', 'API Development', 'ERP Project'
      ]
    },
    {
      'id': 'mysql',
      'title': 'MySQL Complete Masterclass',
      'category': 'Database',
      'desc': 'Relational databases and queries.',
      'modules': [
        'Database Basics', 'Installation', 'Database Creation', 'Tables',
        'Data Types', 'Insert', 'Update', 'Delete', 'Select', 'Where Clause',
        'Order By', 'Group By', 'Joins', 'Views', 'Stored Procedures',
        'Triggers', 'Indexing', 'Optimization', 'Backup', 'ERP Database Project'
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
