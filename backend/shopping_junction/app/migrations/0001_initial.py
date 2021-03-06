# Generated by Django 3.0.3 on 2020-03-28 14:03

import app.models
import datetime
from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Product',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=200)),
                ('brand', models.CharField(blank=True, max_length=100, null=True)),
                ('published', models.BooleanField(default=True)),
                ('isFeatured', models.BooleanField(default=True)),
                ('shortDescription', models.TextField(blank=True, null=True)),
                ('description', models.TextField(blank=True, null=True)),
                ('mrp', models.FloatField(blank=True, null=True)),
                ('list_price', models.FloatField(blank=True, null=True)),
                ('discount', models.FloatField(blank=True, null=True)),
                ('qty', models.IntegerField(blank=True, null=True)),
                ('instock', models.BooleanField(default=0)),
                ('colors', models.TextField(blank=True, null=True)),
                ('sizes', models.TextField(blank=True, null=True)),
                ('features', models.TextField(blank=True, null=True)),
                ('image_link', models.TextField(blank=True)),
                ('parent', models.IntegerField(blank=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='ProductCategory',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('image', models.ImageField(blank=True, upload_to='category/')),
            ],
        ),
        migrations.CreateModel(
            name='SubCategory',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('main_category', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.ProductCategory')),
            ],
        ),
        migrations.CreateModel(
            name='WishList',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('size', models.IntegerField(blank=True, null=True)),
                ('qty', models.IntegerField(blank=True, null=True)),
                ('product', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='app.Product')),
                ('user', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='SubProduct',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('mrp', models.FloatField(blank=True, null=True)),
                ('list_price', models.FloatField(blank=True, null=True)),
                ('qty', models.IntegerField(blank=True, null=True)),
                ('color', models.TextField(blank=True, null=True)),
                ('size', models.TextField(blank=True, null=True)),
                ('instock', models.BooleanField(default=0)),
                ('parent', models.ForeignKey(on_delete=app.models.Product, to='app.Product')),
            ],
        ),
        migrations.CreateModel(
            name='SubList',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('sub_category', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.SubCategory')),
            ],
        ),
        migrations.CreateModel(
            name='Profile',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('phone_number', models.CharField(blank=True, max_length=12, null=True)),
                ('gender', models.CharField(blank=True, max_length=10, null=True)),
                ('GST_number', models.CharField(blank=True, max_length=20, null=True)),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='ProductSlider',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(blank=True, max_length=20, null=True)),
                ('image', models.ImageField(upload_to='slider/')),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.ProductCategory')),
            ],
        ),
        migrations.CreateModel(
            name='ProductOrders',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('status', models.CharField(blank=True, max_length=20, null=True)),
                ('price', models.FloatField(blank=True, null=True)),
                ('size', models.CharField(blank=True, max_length=10, null=True)),
                ('date', models.DateTimeField(default=datetime.datetime.now)),
                ('qty', models.IntegerField()),
                ('coupon', models.FloatField(blank=True, null=True)),
                ('discount', models.FloatField(blank=True, null=True)),
                ('payment_mode', models.CharField(max_length=200)),
                ('buyer', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='buyer', to=settings.AUTH_USER_MODEL)),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='OrderProduct', to='app.SubProduct')),
                ('seller', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='seller', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='ProductImages2',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(upload_to='product/')),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.Product')),
            ],
        ),
        migrations.CreateModel(
            name='ProductImages',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('large_image', models.ImageField(blank=True, null=True, upload_to='product/large')),
                ('normal_image', models.ImageField(blank=True, null=True, upload_to='product/normal')),
                ('thumbnail_image', models.ImageField(blank=True, null=True, upload_to='product/thumbnail')),
                ('product', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='app.SubProduct')),
                ('product_image', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='app.Product')),
            ],
        ),
        migrations.AddField(
            model_name='product',
            name='sublist',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.SubList'),
        ),
        migrations.CreateModel(
            name='Cart',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('size', models.CharField(blank=True, max_length=5, null=True)),
                ('qty', models.IntegerField(blank=True, null=True)),
                ('cart_products', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='cart_products', to='app.SubProduct')),
                ('user', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Address',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('house_no', models.TextField()),
                ('colony', models.TextField()),
                ('landmark', models.CharField(blank=True, max_length=200, null=True)),
                ('city', models.CharField(max_length=100)),
                ('state', models.CharField(max_length=100)),
                ('person_name', models.CharField(max_length=50)),
                ('phone_number', models.CharField(max_length=13)),
                ('alternate_number', models.CharField(blank=True, max_length=13, null=True)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
