from django.db import models
from django.contrib.auth.models import User
from datetime import datetime

# Create your models here.

class Profile(models.Model):
    user = models.OneToOneField(User,on_delete=models.CASCADE)
    # phone_number = models.IntegerField(null=True,blank=True)
    phone_number = models.CharField(max_length = 12,null=True,blank=True)
    gender = models.CharField(max_length=10,null=True,blank=True)
    GST_number = models.CharField(max_length=20, null=True,blank=True)
    # image = models.ImageField(upload_to="profile/",blank=True,null=True)
    def __str__(self):
        return self.user.username
    




class Address(models.Model):
    user = models.ForeignKey(User,on_delete=models.CASCADE)
    house_no = models.TextField()
    colony = models.TextField()
    landmark = models.CharField(max_length=200, null=True,blank=True)
    city = models.CharField(max_length=100)
    state = models.CharField(max_length=100)
    person_name = models.CharField(max_length=50)
    phone_number = models.IntegerField()
    alternate_number = models.IntegerField(null=True,blank=True)
    def __str__(self):
        return self.house_no+" : "+self.colony
    




class ProductCategory(models.Model):
    name = models.CharField(max_length=100)
    image = models.ImageField(upload_to='category/',blank=True)
    def __str__(self):
        return self.name
    

class SubCategory(models.Model):
    name = models.CharField(max_length=100)
    main_category = models.ForeignKey(ProductCategory,on_delete=models.CASCADE)
    def __str__(self):
        return self.name +" : "+ self.main_category.name

class SubList(models.Model):
    name = models.CharField(max_length=100)
    sub_category = models.ForeignKey(SubCategory,on_delete=models.CASCADE)
    def __str__(self):
        return self.name+" : "+ self.sub_category.name +" : " +self.sub_category.main_category.name

class Product(models.Model):
    name = models.CharField(max_length=200)
    brand = models.CharField(max_length=100,blank=True)
    published = models.BooleanField(default=True)
    isFeatured = models.BooleanField(default=True)
    shortDescription = models.TextField(null=True,blank=True)
    description = models.TextField(null=True,blank=True)
    mrp = models.FloatField()
    list_price = models.FloatField()
    discount = models.FloatField(null=True,blank=True)
    qty = models.IntegerField()
    instock = models.BooleanField(default=0)
    colors = models.TextField(null=True,blank=True)
    sizes = models.TextField(null=True,blank=True)
    features = models.TextField(null=True,blank=True)
    image_link = models.TextField(blank=True)
    sublist = models.ForeignKey(SubList,on_delete=models.CASCADE)
    def __str__(self):
        return self.name

class ProductImages(models.Model):
    image = models.ImageField(upload_to='product/')
    product = models.ForeignKey(Product,on_delete=models.CASCADE)
    def __str__(self):
        return self.product.name

# class ProductReview(models.Model):
#     rating = models.FloatField(null=True,blank=True)
#     description = models.TextField(null=True,blank=True)
#     product = models.ForeignKey(Product,on_delete=models.CASCADE)
#     user = models.ForeignKey(User,on_delete = models.CASCADE)
#     def __str__(self):
#         return self.product.name

class WishList(models.Model):
    size = models.IntegerField(null=True,blank=True)
    qty = models.IntegerField(null=True,blank=True)
    product = models.ForeignKey(Product,on_delete=models.CASCADE)
    user = models.ForeignKey(User,on_delete=models.CASCADE)
    def __str__(self):
        return self.product.name
    

class Cart(models.Model):
    size = models.IntegerField(null=True,blank=True)
    qty = models.IntegerField(null=True,blank=True)
    product = models.ForeignKey(Product,on_delete=models.CASCADE)
    user = models.ForeignKey(User,on_delete=models.CASCADE)
    def __str__(self):
        return self.product.name    




class ProductOrders(models.Model):
    product  = models.ForeignKey(Product,on_delete=models.CASCADE,related_name='product')
    seller = models.ForeignKey(User,on_delete=models.CASCADE,related_name='seller')
    buyer = models.ForeignKey(User,on_delete=models.CASCADE,related_name='buyer')
    date = models.DateTimeField(default=datetime.now)
    qty = models.IntegerField()
    coupon = models.FloatField(null=True,blank=True)
    discount = models.FloatField(null=True,blank=True)
    payment_mode = models.CharField(max_length=200)
    def __str__(self):
        return self.product.name
    
