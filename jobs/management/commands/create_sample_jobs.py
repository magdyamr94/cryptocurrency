from django.core.management.base import BaseCommand
from django.utils import timezone
from datetime import timedelta
from jobs.models import Job


class Command(BaseCommand):
    help = 'Create sample job data for testing the API'

    def add_arguments(self, parser):
        parser.add_argument(
            '--count',
            type=int,
            default=25,
            help='Number of sample jobs to create (default: 25)'
        )

    def handle(self, *args, **options):
        count = options['count']
        
        sample_jobs = [
            {
                'title': 'Senior Python Developer',
                'company': 'Tech Corp',
                'location': 'Remote',
                'description': 'We are looking for a Senior Python Developer with 5+ years of experience in Django, Flask, and REST APIs.',
                'linkedin_url': 'https://linkedin.com/jobs/view/123456',
                'linkedin_job_id': '123456',
                'employment_type': 'Full-time',
                'experience_level': 'Mid-Senior level',
                'posted_date': timezone.now() - timedelta(days=2),
                'company_size': '201-500 employees',
                'industry': 'Information Technology',
                'salary_min': 80000.00,
                'salary_max': 120000.00,
                'salary_currency': 'USD',
                'salary_period': 'yearly',
                'required_skills': 'Python, Django, REST API, PostgreSQL',
            },
            {
                'title': 'Full Stack Developer',
                'company': 'Startup Inc',
                'location': 'San Francisco, CA',
                'description': 'Join our growing startup as a Full Stack Developer. Work with React, Node.js, and Python.',
                'linkedin_url': 'https://linkedin.com/jobs/view/234567',
                'linkedin_job_id': '234567',
                'employment_type': 'Full-time',
                'experience_level': 'Mid level',
                'posted_date': timezone.now() - timedelta(days=1),
                'company_size': '11-50 employees',
                'industry': 'Computer Software',
                'salary_min': 70000.00,
                'salary_max': 100000.00,
                'salary_currency': 'USD',
                'salary_period': 'yearly',
                'required_skills': 'React, Node.js, Python, MongoDB',
            },
            {
                'title': 'Data Scientist',
                'company': 'Data Analytics Co',
                'location': 'New York, NY',
                'description': 'Looking for a Data Scientist to work on machine learning projects and data analysis.',
                'linkedin_url': 'https://linkedin.com/jobs/view/345678',
                'linkedin_job_id': '345678',
                'employment_type': 'Full-time',
                'experience_level': 'Mid level',
                'posted_date': timezone.now() - timedelta(days=3),
                'company_size': '501-1000 employees',
                'industry': 'Financial Services',
                'salary_min': 90000.00,
                'salary_max': 130000.00,
                'salary_currency': 'USD',
                'salary_period': 'yearly',
                'required_skills': 'Python, Machine Learning, Pandas, TensorFlow',
            },
            {
                'title': 'DevOps Engineer',
                'company': 'Cloud Solutions Ltd',
                'location': 'Austin, TX',
                'description': 'DevOps Engineer position working with AWS, Docker, and Kubernetes.',
                'linkedin_url': 'https://linkedin.com/jobs/view/456789',
                'linkedin_job_id': '456789',
                'employment_type': 'Full-time',
                'experience_level': 'Senior level',
                'posted_date': timezone.now() - timedelta(days=4),
                'company_size': '201-500 employees',
                'industry': 'Information Technology',
                'salary_min': 85000.00,
                'salary_max': 125000.00,
                'salary_currency': 'USD',
                'salary_period': 'yearly',
                'required_skills': 'AWS, Docker, Kubernetes, Python, Terraform',
            },
            {
                'title': 'Machine Learning Engineer',
                'company': 'AI Innovations',
                'location': 'Seattle, WA',
                'description': 'ML Engineer to build and deploy machine learning models at scale.',
                'linkedin_url': 'https://linkedin.com/jobs/view/567890',
                'linkedin_job_id': '567890',
                'employment_type': 'Full-time',
                'experience_level': 'Mid-Senior level',
                'posted_date': timezone.now() - timedelta(days=5),
                'company_size': '1001-5000 employees',
                'industry': 'Computer Software',
                'salary_min': 95000.00,
                'salary_max': 140000.00,
                'salary_currency': 'USD',
                'salary_period': 'yearly',
                'required_skills': 'Python, TensorFlow, PyTorch, MLOps, AWS',
            },
            {
                'title': 'Frontend Developer',
                'company': 'Design Agency',
                'location': 'Remote',
                'description': 'Frontend Developer with expertise in React and modern JavaScript.',
                'linkedin_url': 'https://linkedin.com/jobs/view/678901',
                'linkedin_job_id': '678901',
                'employment_type': 'Contract',
                'experience_level': 'Mid level',
                'posted_date': timezone.now() - timedelta(days=1),
                'company_size': '51-200 employees',
                'industry': 'Design',
                'salary_min': 60000.00,
                'salary_max': 85000.00,
                'salary_currency': 'USD',
                'salary_period': 'yearly',
                'required_skills': 'React, JavaScript, CSS, HTML, TypeScript',
            },
            {
                'title': 'Backend Developer',
                'company': 'Enterprise Solutions',
                'location': 'Chicago, IL',
                'description': 'Backend Developer to work on enterprise-level applications using Java and Python.',
                'linkedin_url': 'https://linkedin.com/jobs/view/789012',
                'linkedin_job_id': '789012',
                'employment_type': 'Full-time',
                'experience_level': 'Entry level',
                'posted_date': timezone.now() - timedelta(days=6),
                'company_size': '5001-10000 employees',
                'industry': 'Information Technology',
                'salary_min': 65000.00,
                'salary_max': 90000.00,
                'salary_currency': 'USD',
                'salary_period': 'yearly',
                'required_skills': 'Java, Python, Spring Boot, REST APIs',
            },
        ]
        
        created_count = 0
        
        # Create jobs based on sample data, repeating to reach the desired count
        for i in range(count):
            sample_job = sample_jobs[i % len(sample_jobs)]
            
            # Modify some fields to make each job unique
            unique_job = sample_job.copy()
            unique_job['linkedin_job_id'] = f"{sample_job['linkedin_job_id']}_{i}"
            unique_job['linkedin_url'] = f"{sample_job['linkedin_url']}_{i}"
            
            # Vary the posted date
            unique_job['posted_date'] = timezone.now() - timedelta(days=(i % 7) + 1)
            
            # Create the job if it doesn't exist
            job, created = Job.objects.get_or_create(
                linkedin_job_id=unique_job['linkedin_job_id'],
                defaults=unique_job
            )
            
            if created:
                created_count += 1
                self.stdout.write(
                    self.style.SUCCESS(f'Created job: {job.title} at {job.company}')
                )
            else:
                self.stdout.write(
                    self.style.WARNING(f'Job already exists: {job.title} at {job.company}')
                )
        
        self.stdout.write(
            self.style.SUCCESS(f'\nCompleted! Created {created_count} new jobs out of {count} requested.')
        )