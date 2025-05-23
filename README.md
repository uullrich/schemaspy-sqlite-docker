# SchemaSpy SQLite Docker

## Purpose

This repository provides a Docker-based solution for generating comprehensive database documentation using SchemaSpy with SQLite databases. SchemaSpy is a powerful database documentation tool that analyzes database metadata to create detailed HTML documentation including:

- **Visual Database Schema**: Entity Relationship Diagrams (ERD) showing table relationships
- **Table Documentation**: Detailed information about columns, constraints, and indexes  
- **Relationship Analysis**: Foreign key relationships and data dependencies
- **Anomaly Detection**: Identifies potential schema issues and orphaned tables
- **Interactive Web Interface**: Browse-able HTML documentation with search capabilities

Key features of this Docker setup:
- Pre-configured SQLite JDBC driver (xerial sqlite-jdbc)
- SchemaSpy 6.2.4 with Graphviz for diagram generation
- Sample Northwind database for testing and demonstration
- Optimized for high-quality diagram output
- No local Java or SchemaSpy installation required

## Getting Started

### Prerequisites

- Docker installed on your system
- A SQLite database file to analyze (or use the provided sample)

### Quick Start

1. **Clone the repository:**
   ```bash
   git clone <repository-url> schemaspy
   cd schemaspy
   ```

2. **Build the Docker image:**

   execute the build.sh script

3. **Run with sample database:**

    ```bash
   cd sample
   ./run.sh
   ```

4. **View the documentation:**
   Open `output/index.html` in your web browser to explore the generated documentation.

### Using Your Own Database

1. **Prepare your database:**
   Place your SQLite database file in a directory (e.g., `./mydata/`)

2. **Create a configuration file:**
   ```properties
   # mydata/schemaspy.properties
   schemaspy.t=sqlite-xerial
   schemaspy.db=/data/your-database.db
   schemaspy.u=root
   schemaspy.p=
   schemaspy.desc=Your Database Documentation
   schemaspy.hq=true
   ```

3. **Run SchemaSpy:**
   ```bash
   docker run --rm \
     -v $(pwd)/mydata:/data \
     -v $(pwd)/output:/output \
     schemaspy-sqlite \
     -configFile /data/schemaspy.properties
   ```

### Configuration Options

The `schemaspy.properties` file supports various options:

- `schemaspy.t`: Database type (use `sqlite-xerial`)
- `schemaspy.db`: Path to database file (inside container: `/data/filename.db`)
- `schemaspy.desc`: Title for the documentation
- `schemaspy.hq`: High-quality diagrams (true/false)
- `schemaspy.norows`: Skip row count analysis (true/false)
- `schemaspy.noimplied`: Skip implied relationship detection (true/false)

### Advanced Usage

**Custom output directory:**
```bash
docker run --rm \
  -v $(pwd)/sample:/data \
  -v /path/to/custom/output:/output \
  schemaspy-sqlite \
  -configFile /data/schemaspy.properties
```

**Direct command line options:**
```bash
docker run --rm \
  -v $(pwd)/sample:/data \
  -v $(pwd)/output:/output \
  schemaspy-sqlite \
  -t sqlite-xerial \
  -db /data/northwind.db \
  -u root \
  -desc "My Database Documentation"
```

### Sample Database

This repository includes a sample Northwind SQLite database with pre-configured documentation. The sample demonstrates:
- Complete table relationships
- Various column types and constraints
- Views and their dependencies
- Real-world database schema patterns

### Output Structure

The generated documentation includes:
```
output/
├── index.html              # Main documentation page
├── tables/                 # Individual table documentation
├── relationships.html      # Relationship diagrams
├── constraints.html        # Constraint information
├── anomalies.html         # Schema anomalies
├── routines.html          # Database routines/procedures
└── diagrams/              # ERD images and interactive diagrams
```

### Troubleshooting

**Permission Issues:**
```bash
# Fix output directory permissions
chmod 755 output/
```

**Large Databases:**
For large databases, increase memory allocation:
```bash
docker run --rm -m 2g \
  -v $(pwd)/data:/data \
  -v $(pwd)/output:/output \
  schemaspy-sqlite \
  -configFile /data/schemaspy.properties
```

### Resources

- [SchemaSpy Official Documentation](http://schemaspy.org/)
- [SQLite Documentation](https://sqlite.org/docs.html)
- [Docker Documentation](https://docs.docker.com/)
