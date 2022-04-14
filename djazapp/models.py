from django.db import models


class Blog(models.Model):
    name = models.CharField(max_length=64, null=False, blank=False)


class BlogPost(models.Model):
    blog = models.ForeignKey(Blog, on_delete=models.CASCADE)
    author = models.CharField(max_length=64, null=False, blank=False)
    text = models.CharField(max_length=2000, null=False, blank=True)
