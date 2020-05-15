from rest_framework import serializers
from app.models import *

class ProductSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Product
        fields = ('id','name','brand','instock')


class UploadParentImageSerializer(serializers.HyperlinkedModelSerializer):
    # parent = 
    # parent = ProductSerializer(required=False,read_only=True)
    class Meta:
        model = ProductImages
        fields = ('id','large_image','parent_id')
        read_only_fields = ('normal_image','thumbnail_image','product')
        
class UploadSubProductImageSerializer(serializers.HyperlinkedModelSerializer):
    # parent = 
    # parent = ProductSerializer(required=False,read_only=True)
    class Meta:
        model = ProductImages
        fields = ('id','large_image','product_id',"")
        read_only_fields = ('normal_image','thumbnail_image','product')