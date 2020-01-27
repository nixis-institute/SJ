from django.contrib import admin
from app.models import *
# Register your models here.

admin.site.register(Product)
admin.site.register(ProductCategory)
admin.site.register(SubCategory)
admin.site.register(SubList)
admin.site.register(ProductReview)
admin.site.register(ProductImages)
admin.site.register(WishList)
admin.site.register(Cart)
admin.site.register(ProductOrders)
admin.site.register(Profile)
admin.site.register(Address)

