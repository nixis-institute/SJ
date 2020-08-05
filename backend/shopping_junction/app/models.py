from django.db import models
from django.contrib.auth.models import User
from datetime import datetime
from PIL import Image
from io import BytesIO
from django.core.files.uploadedfile import InMemoryUploadedFile
import sys
from django.dispatch import receiver
import os
# Create your models here.

class Profile(models.Model):
    user = models.OneToOneField(User,on_delete=models.CASCADE)
    # phone_number = models.IntegerField(null=True,blank=True)
    phone_number = models.CharField(max_length = 12,null=True,blank=True)
    gender = models.CharField(max_length=10,null=True,blank=True)
    GST_number = models.CharField(max_length=20, null=True,blank=True)
    image = models.ImageField(upload_to="profile/",blank=True,null=True)
    google_image = models.CharField(max_length=200,blank=True,null=True)
    is_google_user = models.BooleanField(default=False)
    # accessToken = models.CharField(max_length=20, null=True,blank=True)

    def __str__(self):
        return self.user.username

    def save(self,force_insert=False,force_update=False, using=None):
        #super(Photos,self).save()

        if(self.image):
            p = Profile.objects.filter(id = self.id)
            if(p):
                if p[0].image != self.image:
                    p[0].image.delete(save=False)
            im = Image.open(self.image)
            output = BytesIO()
            #basewidth = 600
            if im.size[0]<=700:
                basewidth = im.size[0]
            else:
                basewidth = 600

            #img = Image.open('somepic.jpg')
            wpercent = (basewidth/float(im.size[0]))
            hsize = int((float(im.size[1])*float(wpercent)))
            im = im.resize((basewidth,hsize), Image.ANTIALIAS)
            im = im.convert("RGB")
            self.height = im.height
            self.width = im.width
            im.save(output, format='JPEG', quality=70)
            self.image = InMemoryUploadedFile(output,'ImageField', "%s.jpg" %self.image.name.split('.')[0], 'image/jpeg', sys.getsizeof(output), None)        
        super(Profile,self).save()




class Address(models.Model):
    user = models.ForeignKey(User,on_delete=models.CASCADE)
    house_no = models.TextField()
    colony = models.TextField()
    landmark = models.CharField(max_length=200, null=True,blank=True)
    pin_code = models.IntegerField(null=True,blank=True)
    city = models.CharField(max_length=100)
    state = models.CharField(max_length=100)
    person_name = models.CharField(max_length=50)
    phone_number = models.CharField(max_length=13)
    alternate_number = models.CharField(max_length=13,null=True,blank=True)
    def __str__(self):
        return self.house_no+" : "+self.colony

class OrdersAddres(models.Model):
    house_no = models.TextField()
    colony = models.TextField()
    landmark = models.CharField(max_length=200, null=True,blank=True)
    city = models.CharField(max_length=100)
    state = models.CharField(max_length=100)
    pin_code = models.IntegerField(null=True,blank=True)
    person_name = models.CharField(max_length=50)
    phone_number = models.CharField(max_length=13)
    alternate_number = models.CharField(max_length=13,null=True,blank=True)
    user_address_id = models.IntegerField(null=True,blank=True)
    # user_address = models.ForeignKey(Address,)
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


    # instock = models.BooleanField(default=0)


class Product(models.Model):
    name = models.CharField(max_length=200)
    brand = models.CharField(max_length=100,blank=True,null=True)
    published = models.BooleanField(default=True)
    isFeatured = models.BooleanField(default=True)
    shortDescription = models.TextField(null=True,blank=True)
    description = models.TextField(null=True,blank=True)
    mrp = models.FloatField(null=True,blank=True)
    list_price = models.FloatField(null=True,blank=True)
    discount = models.FloatField(null=True,blank=True)
    qty = models.IntegerField(null=True,blank=True)
    instock = models.BooleanField(default=0)
    isActive = models.BooleanField(default=0,null=True,blank=True)
    colors = models.TextField(null=True,blank=True)
    sizes = models.TextField(null=True,blank=True)
    features = models.TextField(null=True,blank=True)
    image_link = models.TextField(blank=True)
    seller = models.ForeignKey(User,on_delete=models.CASCADE,default=1)
    # parent = models.ForeignKey(Product)
    parent = models.IntegerField(null=True,blank=True)

    sublist = models.ForeignKey(SubList,on_delete=models.CASCADE)
    def __str__(self):
        return self.name

class SubProduct(models.Model):
    mrp = models.FloatField(null=True,blank=True)
    list_price = models.FloatField(null=True,blank=True)
    qty = models.IntegerField(null=True,blank=True)
    color = models.TextField(null=True,blank=True)
    size = models.TextField(null=True,blank=True)
    instock = models.BooleanField(default=0)
    parent = models.ForeignKey(Product,on_delete=Product)
    def __str__(self):
        return self.parent.name + " : "+str(self.list_price)
    def save(self, *args, **kwargs):
        super().save(*args, **kwargs)
        p = Product.objects.get(id = self.parent.id)
        if(not p.mrp):
            p.mrp = self.mrp
            p.list_price = self.list_price
        else:
            if(float(p.list_price)>float(self.list_price)):
                p.mrp = self.mrp
                p.list_price = self.list_price
        if(not p.sizes):
            p.sizes = self.size+","
        else:
            if(p.sizes.split(",").count(self.size) is 0):
                p.sizes+="{},".format(self.size)

        if(not p.colors):
            p.colors = self.color+","
        else:
            if(p.colors.split(",").count(self.color) is 0):
                p.colors+="{},".format(self.color)
        p.save()



class ProductSlider(models.Model):
    title = models.CharField(max_length=20,null=True,blank=True)
    image = models.ImageField(upload_to='slider/')
    product = models.ForeignKey(ProductCategory,on_delete=models.CASCADE)
    def __str__(self):
        return self.title+" : "+self.product.name

class ProductImages(models.Model):
    large_image = models.ImageField(upload_to='product/large',null=True,blank=True)
    normal_image = models.ImageField(upload_to='product/normal',null=True,blank=True)
    thumbnail_image = models.ImageField(upload_to='product/thumbnail',null=True,blank=True)
    product = models.ForeignKey(SubProduct,on_delete=models.CASCADE,null=True,blank=True)
    parent = models.ForeignKey(Product,on_delete=models.CASCADE,null=True,blank=True)
    # product_image = models.ForeignKey(Product,on_delete=models.CASCADE,null=True,blank=True)
    def __str__(self):
        # name = len(self.product.parent.name) if self.product.parent.name else self.parent.name
        if(self.product):
            # print("sdf")
            name =  self.product.parent.name
        else:
            # print(self.parent)
            name =  self.parent.name
        print(name)
        return name

    def save(self,force_insert=False,force_update=False, using=None):
        #super(Photos,self).save()
        im = Image.open(self.large_image)
        output = BytesIO()
        #basewidth = 600
        if im.size[0]<=700:
            basewidth = im.size[0]
        else:
            basewidth = 600

        #img = Image.open('somepic.jpg')
        wpercent = (basewidth/float(im.size[0]))
        hsize = int((float(im.size[1])*float(wpercent)))
        im = im.resize((basewidth,hsize), Image.ANTIALIAS)
        im = im.convert("RGB")
        self.height = im.height
        self.width = im.width
        im.save(output, format='JPEG', quality=70)

        self.normal_image = InMemoryUploadedFile(output,'ImageField', "%s.jpg" %self.large_image.name.split('.')[0], 'image/jpeg', sys.getsizeof(output), None)
        # weight,height=im.size
        # if weight > height:
        #     r=(weight-height)/2
        #     imc=im.crop((r,0,height+r,height))
        # else:
        #     r=(height-weight)/2
        #     imc=im.crop((0,r,weight,height-r))
        if im.size[0]<=100:
            basewidth = im.size[0]
        else:
            basewidth = 100
        wpercent = (basewidth/float(im.size[0]))
        hsize = int((float(im.size[1])*float(wpercent)))
        imc = im.resize((basewidth,hsize), Image.ANTIALIAS)


        imc = imc.convert("RGB")
        # imc=imc.resize((300,300),Image.ANTIALIAS)
        output = BytesIO()
        imc.save(output, format='JPEG', quality=70)
        output.seek(0)
        self.thumbnail_image = InMemoryUploadedFile(output,'ImageField', "%s.jpg" %self.large_image.name.split('.')[0], 'image/jpeg', sys.getsizeof(output), None)
        super(ProductImages,self).save()


# class ProductImages2(models.Model):
#     image = models.ImageField(upload_to='product/')
#     product = models.ForeignKey(Product,on_delete=models.CASCADE)
#     def __str__(self):
#         return self.product.name

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
    product = models.ForeignKey(Product,on_delete=models.CASCADE,blank=True,null=True)
    user = models.ForeignKey(User,on_delete=models.CASCADE,blank=True,null=True)
    def __str__(self):
        return self.product.name



class Cart(models.Model):
    size = models.CharField(max_length=5,null=True,blank=True)
    color = models.CharField(max_length=20,null=True,blank=True)
    qty = models.IntegerField(null=True,blank=True)
    cart_products = models.ForeignKey(SubProduct,on_delete=models.CASCADE,blank=True,null=True,related_name="cart_products")
    user = models.ForeignKey(User,on_delete=models.CASCADE,blank=True,null=True)
    def __str__(self):
        return self.cart_products.parent.name




class ProductOrders(models.Model):
    status = models.CharField(max_length=20,default = "Processing")
    product  = models.ForeignKey(SubProduct,on_delete=models.CASCADE,related_name='OrderProduct')
    seller = models.ForeignKey(User,on_delete=models.CASCADE,related_name='seller')
    buyer = models.ForeignKey(User,on_delete=models.CASCADE,related_name='buyer')
    mrp = models.FloatField(null=True,blank=True)
    price = models.FloatField(null=True,blank=True)
    size = models.CharField(max_length=10,null=True,blank=True)
    date = models.DateTimeField(default=datetime.now)
    qty = models.IntegerField()
    color = models.CharField(max_length=20,null=True,blank=True)
    address = models.ForeignKey(OrdersAddres,on_delete=models.CASCADE,null=True,blank=True)
    coupon = models.FloatField(null=True,blank=True)
    discount = models.FloatField(null=True,blank=True)
    payment_mode = models.CharField(max_length=200)
    def __str__(self):
        return self.product.parent.name

@receiver(models.signals.post_delete, sender=ProductImages)
def auto_delete(sender,instance,**kwargs):
    # if instance.large_image:
    #     if os.path.isfile(instance.large_image.path):

    if(instance.large_image and os.path.isfile(instance.large_image.path)):
        os.remove(instance.large_image.path)
    if(instance.normal_image and os.path.isfile(instance.large_image.path)):
        os.remove(instance.normal_image.path)
    if(instance.thumbnail_image and os.path.isfile(instance.large_image.path)):
        os.remove(instance.thumbnail_image.path)
