from django.shortcuts import render
from rest_framework import generics, status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.pagination import PageNumberPagination
from django_filters import rest_framework as filters
from django.db.models import Q, Count
from .models import Job
from .serializers import JobSerializer, JobListSerializer
from .scraper import scrape_linkedin_jobs


class JobPagination(PageNumberPagination):
    page_size = 20
    page_size_query_param = 'page_size'
    max_page_size = 100


class JobFilter(filters.FilterSet):
    title = filters.CharFilter(field_name='title', lookup_expr='icontains')
    company = filters.CharFilter(field_name='company', lookup_expr='icontains')
    location = filters.CharFilter(field_name='location', lookup_expr='icontains')
    employment_type = filters.CharFilter(field_name='employment_type', lookup_expr='icontains')
    experience_level = filters.CharFilter(field_name='experience_level', lookup_expr='icontains')
    keywords = filters.CharFilter(method='filter_keywords')
    
    def filter_keywords(self, queryset, name, value):
        """Filter by keywords in title, company, or description"""
        return queryset.filter(
            Q(title__icontains=value) | 
            Q(company__icontains=value) | 
            Q(description__icontains=value)
        )
    
    class Meta:
        model = Job
        fields = ['title', 'company', 'location', 'employment_type', 'experience_level', 'keywords']


class JobListAPIView(generics.ListAPIView):
    """
    List all jobs with pagination and filtering
    
    Query parameters:
    - page: Page number
    - page_size: Number of jobs per page (max 100)
    - title: Filter by job title (case insensitive)
    - company: Filter by company name (case insensitive)
    - location: Filter by location (case insensitive)
    - employment_type: Filter by employment type
    - experience_level: Filter by experience level
    - keywords: Search in title, company, and description
    """
    queryset = Job.objects.filter(is_active=True)
    serializer_class = JobListSerializer
    pagination_class = JobPagination
    filterset_class = JobFilter
    ordering = ['-scraped_at']


class JobDetailAPIView(generics.RetrieveAPIView):
    """
    Get detailed information about a specific job
    """
    queryset = Job.objects.filter(is_active=True)
    serializer_class = JobSerializer


@api_view(['POST'])
def scrape_jobs_api(request):
    """
    Trigger job scraping
    
    POST parameters:
    - keywords: Job search keywords (default: "python developer")
    - location: Location filter (default: empty)
    - limit: Maximum number of jobs to scrape (default: 50, max: 200)
    """
    try:
        keywords = request.data.get('keywords', 'python developer')
        location = request.data.get('location', '')
        limit = min(int(request.data.get('limit', 50)), 200)  # Cap at 200
        
        # Start scraping
        results = scrape_linkedin_jobs(keywords, location, limit)
        
        return Response({
            'success': True,
            'message': 'Job scraping completed',
            'results': results
        }, status=status.HTTP_200_OK)
        
    except Exception as e:
        return Response({
            'success': False,
            'message': f'Error during scraping: {str(e)}',
            'results': None
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
def job_stats_api(request):
    """
    Get statistics about scraped jobs
    """
    try:
        total_jobs = Job.objects.filter(is_active=True).count()
        
        # Top companies
        top_companies = Job.objects.filter(is_active=True).values('company').annotate(
            job_count=Count('id')
        ).order_by('-job_count')[:10]
        
        # Top locations
        top_locations = Job.objects.filter(is_active=True).exclude(
            location__exact=''
        ).values('location').annotate(
            job_count=Count('id')
        ).order_by('-job_count')[:10]
        
        # Employment types
        employment_types = Job.objects.filter(is_active=True).exclude(
            employment_type__exact=''
        ).values('employment_type').annotate(
            job_count=Count('id')
        ).order_by('-job_count')
        
        return Response({
            'total_jobs': total_jobs,
            'top_companies': list(top_companies),
            'top_locations': list(top_locations),
            'employment_types': list(employment_types)
        }, status=status.HTTP_200_OK)
        
    except Exception as e:
        return Response({
            'error': f'Error fetching statistics: {str(e)}'
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
def recent_jobs_api(request):
    """
    Get recently scraped jobs (last 24 hours)
    """
    try:
        from datetime import datetime, timedelta
        
        yesterday = datetime.now() - timedelta(days=1)
        recent_jobs = Job.objects.filter(
            is_active=True,
            scraped_at__gte=yesterday
        ).order_by('-scraped_at')
        
        serializer = JobListSerializer(recent_jobs, many=True)
        
        return Response({
            'count': recent_jobs.count(),
            'jobs': serializer.data
        }, status=status.HTTP_200_OK)
        
    except Exception as e:
        return Response({
            'error': f'Error fetching recent jobs: {str(e)}'
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
