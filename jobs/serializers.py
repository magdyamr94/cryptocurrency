from rest_framework import serializers
from .models import Job


class JobSerializer(serializers.ModelSerializer):
    class Meta:
        model = Job
        fields = [
            'id',
            'title',
            'company',
            'location',
            'description',
            'linkedin_url',
            'linkedin_job_id',
            'employment_type',
            'experience_level',
            'posted_date',
            'application_deadline',
            'company_logo_url',
            'company_size',
            'industry',
            'salary_min',
            'salary_max',
            'salary_currency',
            'salary_period',
            'required_skills',
            'scraped_at',
            'updated_at',
            'is_active',
        ]
        read_only_fields = ['id', 'scraped_at', 'updated_at']


class JobListSerializer(serializers.ModelSerializer):
    """Simplified serializer for list views"""
    class Meta:
        model = Job
        fields = [
            'id',
            'title',
            'company',
            'location',
            'linkedin_url',
            'employment_type',
            'experience_level',
            'posted_date',
            'salary_min',
            'salary_max',
            'salary_currency',
            'scraped_at',
        ]