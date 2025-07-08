import requests
from bs4 import BeautifulSoup
import time
import random
from fake_useragent import UserAgent
from datetime import datetime, timedelta
import re
import logging
from .models import Job

logger = logging.getLogger(__name__)


class LinkedInJobScraper:
    def __init__(self):
        self.session = requests.Session()
        self.ua = UserAgent()
        self.base_url = "https://www.linkedin.com/jobs/search"
        
    def get_headers(self):
        """Generate random headers to avoid detection"""
        return {
            'User-Agent': self.ua.random,
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
            'Accept-Language': 'en-US,en;q=0.5',
            'Accept-Encoding': 'gzip, deflate',
            'DNT': '1',
            'Connection': 'keep-alive',
            'Upgrade-Insecure-Requests': '1',
            'Sec-Fetch-Dest': 'document',
            'Sec-Fetch-Mode': 'navigate',
            'Sec-Fetch-Site': 'none',
            'Cache-Control': 'max-age=0'
        }
    
    def search_jobs(self, keywords="python developer", location="", limit=50):
        """
        Search for jobs on LinkedIn
        
        Args:
            keywords (str): Job search keywords
            location (str): Location filter
            limit (int): Maximum number of jobs to scrape
            
        Returns:
            list: List of job dictionaries
        """
        jobs = []
        start = 0
        
        while len(jobs) < limit:
            params = {
                'keywords': keywords,
                'location': location,
                'start': start,
                'refresh': 'true'
            }
            
            try:
                response = self.session.get(
                    self.base_url,
                    params=params,
                    headers=self.get_headers(),
                    timeout=10
                )
                response.raise_for_status()
                
                soup = BeautifulSoup(response.content, 'html.parser')
                job_cards = soup.find_all('div', class_='result-card')
                
                if not job_cards:
                    logger.warning("No job cards found, trying alternative selectors")
                    # Try alternative selectors
                    job_cards = soup.find_all('div', {'data-entity-urn': True})
                
                if not job_cards:
                    logger.warning("No jobs found on this page")
                    break
                
                for card in job_cards:
                    if len(jobs) >= limit:
                        break
                        
                    job_data = self.extract_job_data(card)
                    if job_data:
                        jobs.append(job_data)
                
                start += 25  # LinkedIn typically shows 25 jobs per page
                
                # Add delay to avoid being blocked
                time.sleep(random.uniform(2, 5))
                
            except requests.RequestException as e:
                logger.error(f"Error fetching jobs: {e}")
                break
            except Exception as e:
                logger.error(f"Unexpected error: {e}")
                break
        
        return jobs[:limit]
    
    def extract_job_data(self, job_card):
        """Extract job data from a job card element"""
        try:
            job_data = {}
            
            # Job title
            title_elem = job_card.find('h3', class_='result-card__title')
            if title_elem:
                job_data['title'] = title_elem.get_text(strip=True)
            
            # Company name
            company_elem = job_card.find('h4', class_='result-card__subtitle')
            if company_elem:
                job_data['company'] = company_elem.get_text(strip=True)
            
            # Location
            location_elem = job_card.find('span', class_='job-result-card__location')
            if location_elem:
                job_data['location'] = location_elem.get_text(strip=True)
            
            # LinkedIn URL
            link_elem = job_card.find('a', {'data-tracking-control-name': 'public_jobs_jserp-result_search-card'})
            if not link_elem:
                link_elem = job_card.find('a')
            
            if link_elem and link_elem.get('href'):
                job_data['linkedin_url'] = self._clean_linkedin_url(link_elem['href'])
                job_data['linkedin_job_id'] = self._extract_job_id(job_data['linkedin_url'])
            
            # Posted date (try to extract from various possible elements)
            posted_elem = job_card.find('time')
            if posted_elem:
                job_data['posted_date'] = self._parse_posted_date(posted_elem.get_text(strip=True))
            
            # Employment type (if available)
            employment_elem = job_card.find('span', class_='job-result-card__employment-status')
            if employment_elem:
                job_data['employment_type'] = employment_elem.get_text(strip=True)
            
            return job_data if job_data.get('title') and job_data.get('company') else None
            
        except Exception as e:
            logger.error(f"Error extracting job data: {e}")
            return None
    
    def _clean_linkedin_url(self, url):
        """Clean and normalize LinkedIn job URL"""
        if not url.startswith('http'):
            url = 'https://www.linkedin.com' + url
        
        # Remove tracking parameters
        url = url.split('?')[0]
        return url
    
    def _extract_job_id(self, url):
        """Extract job ID from LinkedIn URL"""
        match = re.search(r'/jobs/view/(\d+)', url)
        return match.group(1) if match else None
    
    def _parse_posted_date(self, date_string):
        """Parse relative date strings like '2 days ago' to datetime"""
        try:
            now = datetime.now()
            
            if 'ago' in date_string.lower():
                if 'day' in date_string:
                    match = re.search(r'(\d+)', date_string)
                    if match:
                        days = int(match.group(1))
                        return now - timedelta(days=days)
                elif 'hour' in date_string:
                    match = re.search(r'(\d+)', date_string)
                    if match:
                        hours = int(match.group(1))
                        return now - timedelta(hours=hours)
                elif 'week' in date_string:
                    match = re.search(r'(\d+)', date_string)
                    if match:
                        weeks = int(match.group(1))
                        return now - timedelta(weeks=weeks)
                elif 'month' in date_string:
                    match = re.search(r'(\d+)', date_string)
                    if match:
                        months = int(match.group(1))
                        return now - timedelta(days=months * 30)
            
            return now
        except:
            return datetime.now()
    
    def scrape_and_save_jobs(self, keywords="python developer", location="", limit=50):
        """
        Scrape jobs and save them to database
        
        Args:
            keywords (str): Job search keywords
            location (str): Location filter
            limit (int): Maximum number of jobs to scrape
            
        Returns:
            dict: Summary of scraping results
        """
        jobs_data = self.search_jobs(keywords, location, limit)
        
        saved_count = 0
        updated_count = 0
        errors = []
        
        for job_data in jobs_data:
            try:
                # Check if job already exists
                existing_job = None
                if job_data.get('linkedin_job_id'):
                    existing_job = Job.objects.filter(
                        linkedin_job_id=job_data['linkedin_job_id']
                    ).first()
                
                if not existing_job and job_data.get('linkedin_url'):
                    existing_job = Job.objects.filter(
                        linkedin_url=job_data['linkedin_url']
                    ).first()
                
                if existing_job:
                    # Update existing job
                    for field, value in job_data.items():
                        if value:
                            setattr(existing_job, field, value)
                    existing_job.save()
                    updated_count += 1
                else:
                    # Create new job
                    Job.objects.create(**job_data)
                    saved_count += 1
                    
            except Exception as e:
                errors.append(f"Error saving job '{job_data.get('title', 'Unknown')}': {e}")
                logger.error(f"Error saving job: {e}")
        
        return {
            'total_found': len(jobs_data),
            'saved': saved_count,
            'updated': updated_count,
            'errors': errors
        }


def scrape_linkedin_jobs(keywords="python developer", location="", limit=50):
    """
    Convenience function to scrape LinkedIn jobs
    
    Args:
        keywords (str): Job search keywords
        location (str): Location filter  
        limit (int): Maximum number of jobs to scrape
        
    Returns:
        dict: Summary of scraping results
    """
    scraper = LinkedInJobScraper()
    return scraper.scrape_and_save_jobs(keywords, location, limit)