# Generated by Django 2.1.7 on 2020-01-06 15:32

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog_api', '0002_blogpost_remote_source'),
    ]

    operations = [
        migrations.AddField(
            model_name='blogpost',
            name='show',
            field=models.IntegerField(blank=True, default=0),
        ),
        migrations.AlterField(
            model_name='blogpost',
            name='category',
            field=models.CharField(choices=[('ml', 'Machine Learning'), ('programming', 'Programming'), ('su', 'Summary'), ('ani', 'Animation'), ('acg', 'animation & summary & machine learning'), ('nc', 'No Category'), ('oth', 'Others')], max_length=30),
        ),
    ]