from django.contrib import admin
from djazapp.models import Blog, BlogPost

# Register your models here.
admin.site.register([Blog, BlogPost])
