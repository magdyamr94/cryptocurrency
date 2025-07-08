from django.db import models


class Job(models.Model):
    # Basic job information
    title = models.CharField(max_length=255)
    company = models.CharField(max_length=255)
    location = models.CharField(max_length=255, blank=True)
    description = models.TextField(blank=True)
    
    # Job links and external IDs
    linkedin_url = models.URLField(unique=True)
    linkedin_job_id = models.CharField(max_length=100, unique=True, null=True, blank=True)
    
    # Job details
    employment_type = models.CharField(max_length=50, blank=True)  # Full-time, Part-time, etc.
    experience_level = models.CharField(max_length=50, blank=True)  # Entry level, Mid level, etc.
    posted_date = models.DateTimeField(null=True, blank=True)
    application_deadline = models.DateTimeField(null=True, blank=True)
    
    # Company information
    company_logo_url = models.URLField(blank=True)
    company_size = models.CharField(max_length=100, blank=True)
    industry = models.CharField(max_length=100, blank=True)
    
    # Salary information
    salary_min = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    salary_max = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    salary_currency = models.CharField(max_length=3, default='USD')
    salary_period = models.CharField(max_length=20, blank=True)  # yearly, monthly, hourly
    
    # Skills and requirements
    required_skills = models.TextField(blank=True)  # JSON or comma-separated
    
    # Meta information
    scraped_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    is_active = models.BooleanField(default=True)
    
    class Meta:
        ordering = ['-scraped_at']
        indexes = [
            models.Index(fields=['company']),
            models.Index(fields=['location']),
            models.Index(fields=['posted_date']),
            models.Index(fields=['scraped_at']),
        ]
    
    def __str__(self):
        return f"{self.title} at {self.company}"
