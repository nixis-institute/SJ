from django.contrib.auth.models import User,Group
import graphene
#import graphql_jwt
from django.db.models import Q
from app.models import *
# from .models import Comments,Photos,Profile,Profile_pic, IMG,Interest,ReplyComments,Connection as Follow
#from graphene import ObjectType,Node,Schema,List,Field,relay,AbstractType
from graphene_django.fields import DjangoConnectionField
from graphene_django.types import DjangoObjectType
from graphene_django.filter import DjangoFilterConnectionField
from graphene_django.debug import DjangoDebug
from graphql_relay.node.node import from_global_id
from django.utils.dateparse import parse_date
from graphene import relay

class ProductNode(DjangoObjectType):
    class Meta:
        model = Product
        filter_fields = ()
        interfaces = (relay.Node,)

class ProductCategoryNode(DjangoObjectType):
    class Meta:
        model = ProductCategory
        filter_fields = ()
        interfaces = (relay.Node,)

class SubCategoryNode(DjangoObjectType):
    class Meta:
        model = SubCategory
        filter_fields = ()
        interfaces = (relay.Node,)

class SubListNode(DjangoObjectType):
    class Meta:
        model = SubList
        filter_fields = ()
        interfaces = (relay.Node,)

class ImageNode(DjangoObjectType):
    class Meta:
        model = ProductImages
        filter_fields = ()
        interfaces = (relay.Node,)        

class Query(graphene.AbstractType):
    all_products = DjangoFilterConnectionField(ProductNode)
    all_category = DjangoFilterConnectionField(ProductCategoryNode)
    sub_category = DjangoFilterConnectionField(SubCategoryNode)

    # subcateogry_by_category_id = graphene.List(SubCategoryNode, main_category_id=graphene.ID())

    subcateogry_by_category_id = DjangoFilterConnectionField(SubCategoryNode,main_category_id = graphene.ID())
    sublist_by_subcategory_id = DjangoFilterConnectionField(SubListNode, sub_category_id=graphene.ID())
    product_by_sublist_id = DjangoFilterConnectionField(ProductNode, sublist_id=graphene.ID())



    def resolve_product_by_sublist_id(self,info,sublist_id):
        ids = from_global_id(sublist_id)[1]
        return Product.objects.filter(sublist_id = ids)


    def resolve_sublist_by_subcategory_id(self,info,sub_category_id):
        ids = from_global_id(sub_category_id)[1]
        return SubList.objects.filter(sub_category_id = ids)


    def resolve_subcateogry_by_category_id(self,info,main_category_id):
        ids = from_global_id(main_category_id)[1]
        return SubCategory.objects.filter(main_category_id = ids)



    def resolve_sub_category(self,info,**kwargs):
        return SubCategory.objects.all()

    def resolve_all_product(self,info,**kwargs):
        return Product.objects.all()

    def resolve_all_category(self,info,**kwargs):
        return ProductCategory.objects.all()