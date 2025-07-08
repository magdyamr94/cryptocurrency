"""
URL configuration for linkedin_jobs project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.http import JsonResponse

def api_root(request):
    """API root endpoint with documentation"""
    return JsonResponse({
        'message': 'LinkedIn Jobs Scraper API',
        'version': '1.0',
        'endpoints': {
            'jobs': '/api/jobs/ - List all jobs with pagination and filtering',
            'job_detail': '/api/jobs/{id}/ - Get specific job details',
            'scrape': '/api/jobs/scrape/ - Trigger job scraping (POST)',
            'stats': '/api/jobs/stats/ - Get job statistics',
            'recent': '/api/jobs/recent/ - Get recently scraped jobs',
            'admin': '/admin/ - Django admin interface'
        },
        'query_parameters': {
            'page': 'Page number for pagination',
            'page_size': 'Number of jobs per page (max 100)',
            'title': 'Filter by job title (case insensitive)',
            'company': 'Filter by company name (case insensitive)',
            'location': 'Filter by location (case insensitive)',
            'employment_type': 'Filter by employment type',
            'experience_level': 'Filter by experience level',
            'keywords': 'Search in title, company, and description'
        }
    })

urlpatterns = [
    path('', api_root, name='api-root'),
    path('admin/', admin.site.urls),
    path('api/jobs/', include('jobs.urls')),
]
