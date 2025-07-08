# LinkedIn Jobs Scraper API

A Django REST API application that scrapes job listings from LinkedIn and provides a paginated RESTful interface to access the data.

## Features

- **Job Scraping**: Scrape job listings from LinkedIn with customizable search parameters
- **RESTful API**: Clean REST API with pagination for job listings
- **Advanced Filtering**: Filter jobs by title, company, location, employment type, and keywords
- **Job Statistics**: Get insights about scraped jobs including top companies and locations
- **Admin Interface**: Django admin interface for managing scraped jobs
- **Pagination**: Built-in pagination for efficient data handling

## Technology Stack

- **Backend**: Django 5.0, Django REST Framework
- **Database**: SQLite (default, easily configurable for PostgreSQL/MySQL)
- **Scraping**: BeautifulSoup4, Requests, Selenium (for dynamic content)
- **Other**: CORS headers, django-filter for advanced filtering

## Installation and Setup

### 1. Prerequisites
- Python 3.8 or higher
- pip (Python package manager)

### 2. Clone and Setup
```bash
# The project is already set up in your workspace
cd /workspace

# Activate virtual environment
source django_env/bin/activate

# Install dependencies (already done)
pip install -r requirements.txt

# Run migrations (already done)
python manage.py migrate

# Create superuser (already done - username: admin, password: admin123)
python manage.py createsuperuser
```

### 3. Start the Server
```bash
# Start development server
python manage.py runserver 0.0.0.0:8000
```

The API will be available at `http://localhost:8000`

## API Endpoints

### 1. API Documentation
- **GET** `/` - API root with documentation

### 2. Job Listings
- **GET** `/api/jobs/` - List all jobs with pagination and filtering
- **GET** `/api/jobs/{id}/` - Get specific job details

### 3. Job Management
- **POST** `/api/jobs/scrape/` - Trigger job scraping
- **GET** `/api/jobs/stats/` - Get job statistics
- **GET** `/api/jobs/recent/` - Get recently scraped jobs (last 24 hours)

### 4. Admin Interface
- **GET** `/admin/` - Django admin interface

## API Usage Examples

### List Jobs with Pagination
```bash
# Basic listing
curl http://localhost:8000/api/jobs/

# With pagination
curl "http://localhost:8000/api/jobs/?page=2&page_size=10"

# Filter by company
curl "http://localhost:8000/api/jobs/?company=google"

# Filter by location
curl "http://localhost:8000/api/jobs/?location=remote"

# Search by keywords
curl "http://localhost:8000/api/jobs/?keywords=python"

# Multiple filters
curl "http://localhost:8000/api/jobs/?company=google&location=remote&keywords=python"
```

### Get Job Details
```bash
curl http://localhost:8000/api/jobs/1/
```

### Trigger Job Scraping
```bash
curl -X POST -H "Content-Type: application/json" \
  -d '{"keywords": "python developer", "location": "remote", "limit": 50}' \
  http://localhost:8000/api/jobs/scrape/
```

### Get Job Statistics
```bash
curl http://localhost:8000/api/jobs/stats/
```

### Get Recent Jobs
```bash
curl http://localhost:8000/api/jobs/recent/
```

## Query Parameters

### Job Listing Filters
- `page` - Page number for pagination
- `page_size` - Number of jobs per page (max 100)
- `title` - Filter by job title (case insensitive)
- `company` - Filter by company name (case insensitive)
- `location` - Filter by location (case insensitive)
- `employment_type` - Filter by employment type
- `experience_level` - Filter by experience level
- `keywords` - Search in title, company, and description

### Scraping Parameters
- `keywords` - Job search keywords (default: "python developer")
- `location` - Location filter (default: empty)
- `limit` - Maximum number of jobs to scrape (default: 50, max: 200)

## Response Format

### Job List Response
```json
{
  "count": 150,
  "next": "http://localhost:8000/api/jobs/?page=2",
  "previous": null,
  "results": [
    {
      "id": 1,
      "title": "Senior Python Developer",
      "company": "Tech Corp",
      "location": "Remote",
      "linkedin_url": "https://linkedin.com/jobs/view/123456",
      "employment_type": "Full-time",
      "experience_level": "Mid-Senior level",
      "posted_date": "2024-01-15T10:30:00Z",
      "salary_min": 80000.00,
      "salary_max": 120000.00,
      "salary_currency": "USD",
      "scraped_at": "2024-01-16T08:45:00Z"
    }
  ]
}
```

### Job Detail Response
```json
{
  "id": 1,
  "title": "Senior Python Developer",
  "company": "Tech Corp",
  "location": "Remote",
  "description": "We are looking for a Senior Python Developer...",
  "linkedin_url": "https://linkedin.com/jobs/view/123456",
  "linkedin_job_id": "123456",
  "employment_type": "Full-time",
  "experience_level": "Mid-Senior level",
  "posted_date": "2024-01-15T10:30:00Z",
  "application_deadline": null,
  "company_logo_url": "",
  "company_size": "201-500 employees",
  "industry": "Information Technology",
  "salary_min": 80000.00,
  "salary_max": 120000.00,
  "salary_currency": "USD",
  "salary_period": "yearly",
  "required_skills": "Python, Django, REST API, PostgreSQL",
  "scraped_at": "2024-01-16T08:45:00Z",
  "updated_at": "2024-01-16T08:45:00Z",
  "is_active": true
}
```

## Database Schema

### Job Model Fields
- `title` - Job title
- `company` - Company name
- `location` - Job location
- `description` - Job description
- `linkedin_url` - LinkedIn job URL
- `linkedin_job_id` - LinkedIn job ID
- `employment_type` - Employment type (Full-time, Part-time, etc.)
- `experience_level` - Experience level required
- `posted_date` - When the job was posted
- `application_deadline` - Application deadline
- `company_logo_url` - Company logo URL
- `company_size` - Company size
- `industry` - Company industry
- `salary_min` - Minimum salary
- `salary_max` - Maximum salary
- `salary_currency` - Salary currency
- `salary_period` - Salary period (yearly, monthly, hourly)
- `required_skills` - Required skills
- `scraped_at` - When the job was scraped
- `updated_at` - Last update timestamp
- `is_active` - Whether the job is active

## Admin Interface

Access the Django admin at `http://localhost:8000/admin/` with:
- Username: `admin`
- Password: `admin123`

The admin interface provides:
- Job listing with filters and search
- Bulk operations
- Detailed job editing
- Statistics and insights

## Important Notes

### LinkedIn Scraping Limitations
- LinkedIn has anti-bot measures that may block scraping attempts
- Consider using official LinkedIn APIs for production use
- Respect LinkedIn's robots.txt and terms of service
- Implement delays and user-agent rotation for better success rates

### Rate Limiting
- The scraper includes built-in delays to avoid being blocked
- Consider implementing Redis-based rate limiting for production

### Production Considerations
- Use PostgreSQL or MySQL for production databases
- Implement proper logging and monitoring
- Add authentication and authorization
- Use task queues (Celery) for background scraping
- Implement caching (Redis) for better performance

## Error Handling

The API returns appropriate HTTP status codes:
- `200 OK` - Successful requests
- `400 Bad Request` - Invalid parameters
- `404 Not Found` - Resource not found
- `500 Internal Server Error` - Server errors

Error responses include descriptive messages:
```json
{
  "error": "Error description here"
}
```

## Development

### Adding New Features
1. Create migrations: `python manage.py makemigrations`
2. Apply migrations: `python manage.py migrate`
3. Test endpoints: Use curl or Postman
4. Update documentation

### Testing
```bash
# Run Django tests
python manage.py test

# Test API endpoints
curl http://localhost:8000/api/jobs/
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## License

This project is for educational purposes. Please respect LinkedIn's terms of service and consider using official APIs for production applications.
