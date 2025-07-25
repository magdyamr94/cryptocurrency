# Generated by Django 5.0.14 on 2025-07-08 19:53

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Job',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=255)),
                ('company', models.CharField(max_length=255)),
                ('location', models.CharField(blank=True, max_length=255)),
                ('description', models.TextField(blank=True)),
                ('linkedin_url', models.URLField(unique=True)),
                ('linkedin_job_id', models.CharField(blank=True, max_length=100, null=True, unique=True)),
                ('employment_type', models.CharField(blank=True, max_length=50)),
                ('experience_level', models.CharField(blank=True, max_length=50)),
                ('posted_date', models.DateTimeField(blank=True, null=True)),
                ('application_deadline', models.DateTimeField(blank=True, null=True)),
                ('company_logo_url', models.URLField(blank=True)),
                ('company_size', models.CharField(blank=True, max_length=100)),
                ('industry', models.CharField(blank=True, max_length=100)),
                ('salary_min', models.DecimalField(blank=True, decimal_places=2, max_digits=10, null=True)),
                ('salary_max', models.DecimalField(blank=True, decimal_places=2, max_digits=10, null=True)),
                ('salary_currency', models.CharField(default='USD', max_length=3)),
                ('salary_period', models.CharField(blank=True, max_length=20)),
                ('required_skills', models.TextField(blank=True)),
                ('scraped_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('is_active', models.BooleanField(default=True)),
            ],
            options={
                'ordering': ['-scraped_at'],
                'indexes': [models.Index(fields=['company'], name='jobs_job_company_73ae7f_idx'), models.Index(fields=['location'], name='jobs_job_locatio_8b2f8c_idx'), models.Index(fields=['posted_date'], name='jobs_job_posted__0a7770_idx'), models.Index(fields=['scraped_at'], name='jobs_job_scraped_6ce3ef_idx')],
            },
        ),
    ]
