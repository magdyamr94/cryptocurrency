from django.urls import path
from . import views

app_name = 'jobs'

urlpatterns = [
    # Job listing and detail endpoints
    path('', views.JobListAPIView.as_view(), name='job-list'),
    path('<int:pk>/', views.JobDetailAPIView.as_view(), name='job-detail'),
    
    # Scraping and utility endpoints
    path('scrape/', views.scrape_jobs_api, name='scrape-jobs'),
    path('stats/', views.job_stats_api, name='job-stats'),
    path('recent/', views.recent_jobs_api, name='recent-jobs'),
]