# Generated by Django 3.0.3 on 2020-03-10 07:20

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0004_auto_20200303_1651'),
    ]

    operations = [
        migrations.AlterField(
            model_name='address',
            name='alternate_number',
            field=models.CharField(blank=True, max_length=13, null=True),
        ),
        migrations.AlterField(
            model_name='address',
            name='phone_number',
            field=models.CharField(max_length=13),
        ),
    ]
