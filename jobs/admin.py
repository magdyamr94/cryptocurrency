from django.contrib import admin
from .models import Job


@admin.register(Job)
class JobAdmin(admin.ModelAdmin):
    list_display = [
        'title', 
        'company', 
        'location', 
        'employment_type',
        'posted_date',
        'scraped_at',
        'is_active'
    ]
    
    list_filter = [
        'is_active',
        'employment_type',
        'experience_level',
        'company',
        'location',
        'scraped_at',
    ]
    
    search_fields = [
        'title',
        'company',
        'location',
        'description',
        'linkedin_job_id'
    ]
    
    readonly_fields = [
        'linkedin_job_id',
        'scraped_at',
        'updated_at'
    ]
    
    list_per_page = 25
    ordering = ['-scraped_at']
    
    fieldsets = (
        ('Basic Information', {
            'fields': ('title', 'company', 'location', 'description')
        }),
        ('Job Details', {
            'fields': ('employment_type', 'experience_level', 'posted_date', 'application_deadline')
        }),
        ('LinkedIn Information', {
            'fields': ('linkedin_url', 'linkedin_job_id')
        }),
        ('Company Information', {
            'fields': ('company_logo_url', 'company_size', 'industry')
        }),
        ('Salary Information', {
            'fields': ('salary_min', 'salary_max', 'salary_currency', 'salary_period')
        }),
        ('Additional Information', {
            'fields': ('required_skills', 'is_active')
        }),
        ('Metadata', {
            'fields': ('scraped_at', 'updated_at'),
            'classes': ('collapse',)
        }),
    )
