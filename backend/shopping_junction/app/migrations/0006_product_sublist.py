# Generated by Django 2.1.4 on 2020-01-20 10:30

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0005_auto_20200120_1313'),
    ]

    operations = [
        migrations.AddField(
            model_name='product',
            name='sublist',
            field=models.ForeignKey(default=0, on_delete=django.db.models.deletion.CASCADE, to='app.SubList'),
            preserve_default=False,
        ),
    ]