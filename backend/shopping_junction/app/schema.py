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
from django.contrib.auth import get_user_model
from django.contrib.auth.models import User

class ProductNode(DjangoObjectType):
    class Meta:
        model = Product
        filter_fields = ()
        interfaces = (relay.Node,)

class ProductList(DjangoObjectType):
    # prd = graphene.ObjectType()
    # cat = graphene.ObjectType(graphene.String)
    # prd = graphene.ObjectType()
    class Meta:
        model = Product
        filter_fields = ()
        interfaces = (relay.Node,)        
    # class Meta:
    #     model = Product
    #     filter_fields = ()
    #     interfaces = (relay.Node,)


    # prd_list = graphene.List(graphene.String)
    # catetory  =graphene.ObjectType()
    # class Meta:
    #     model = Product
    # def resolve_product_list(self,info):
    #     return [i.name for i in Product.objects.all()]
    # appears_in = graphene.List(graphene.String)


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

class AddressNode(DjangoObjectType):
    class Meta:
        model = Address
        filter_fields = ()
        interfaces = (relay.Node,)


class ImageNode(DjangoObjectType):
    class Meta:
        model = ProductImages
        filter_fields = ()
        interfaces = (relay.Node,)

class SubListSingleNode(DjangoObjectType):
    class Meta:
        model = SubList
        filter_fields = ()
        interfaces = (graphene.Node,)

class UserNode(DjangoObjectType):
    class Meta:
        model = User
        filter_fields = ()
        interfaces = (graphene.Node,)
class ProfileNode(DjangoObjectType):
    class Meta:
        model = Profile
        filter_fields = ()
        interfaces = (graphene.Node,)

class CartNode(DjangoObjectType):
    class Meta:
        model = Cart
        filter_fields = ()
        interfaces = (relay.Node,)


# class AddressNode(DjangoObjectType):
#     class Meta:
#         model = Address
#         filter_fields = ()
#         interfaces = (relay.Node)

class UserType(DjangoObjectType):
    class Meta:
        model = get_user_model()

class CreateUser(graphene.Mutation):
    # user = graphene.Field(UserNode)
    class Arguments:
        username = graphene.String(required=True)
        password = graphene.String(required=True)
        email = graphene.String(required=True)
    user = graphene.Field(UserNode)
    def mutate(self,info,username,password,email):
        user = get_user_model()(username = username,email = email)
        user.set_password(password)
        user.save()
        return CreateUser(user=user)



class UpdateUser(graphene.Mutation):
    class Arguments:
        id = graphene.ID(required=True)
        firstName = graphene.String(required = True)
        lastName = graphene.String(required=True)
        email = graphene.String(required=True)
        phone = graphene.String(required=True)
        gender = graphene.String(required=True)
    user = graphene.Field(UserNode)
    def mutate(self,info,id,firstName,lastName,email,phone,gender):
        user = Profile.objects.filter(user_id=from_global_id(id)[1])
        u = User.objects.get(id = from_global_id(id)[1])
        u.first_name = firstName
        u.last_name = lastName
        u.email = email
        u.save()
        if(user):
            # user = User.objects.get(id = from_global_id(id)[1])
            print(phone)
            user[0].phone_number = phone
            user[0].gender = gender
            user[0].save()
        else:
            Profile.objects.create(user_id=u.id,phone_number=phone,gender=gender)
        return UpdateUser(user = u)




class ChangePassword(graphene.Mutation):
    class Arguments:
        # username = graphene.String(required = True)
        id = graphene.ID(required = True)
        old_password = graphene.String(required = True)
        new_password = graphene.String(required = True)
    success = graphene.Boolean()
    user = graphene.Field(UserNode)


    def mutate(self,info,id,old_password,new_password):
        # user = get_user_model()(username = username,email = email)
        user = User.objects.get(id = from_global_id(id)[1])

        # user.set_password(password)

        print(old_password)
        if(user.check_password(old_password)):
            user.set_password(new_password)
            user.save()
            return ChangePassword(user=user,success=True)
        else:
            print("not match...........")
            return ChangePassword(success=False)
        
        


class Mutation(graphene.ObjectType):
    create_user = CreateUser.Field()
    change_password = ChangePassword.Field()
    update_user = UpdateUser.Field()

class Query(graphene.AbstractType):
    all_products = DjangoFilterConnectionField(ProductNode)
    all_category = DjangoFilterConnectionField(ProductCategoryNode)
    sub_category = DjangoFilterConnectionField(SubCategoryNode)
    cart_products = DjangoFilterConnectionField(CartNode)

    cart_product = graphene.Field(CartNode,id = graphene.ID())
    
    # subcateogry_by_category_id = graphene.List(SubCategoryNode, main_category_id=graphene.ID())

    subcateogry_by_category_id = DjangoFilterConnectionField(SubCategoryNode,main_category_id = graphene.ID())
    sublist_by_subcategory_id = DjangoFilterConnectionField(SubListNode, sub_category_id=graphene.ID())
    product_by_sublist_id = DjangoFilterConnectionField(ProductNode, sublist_id=graphene.ID())
    user = graphene.Field(UserNode,user_id = graphene.Int())

    product_by_id = graphene.Field(ProductNode,id = graphene.ID())

    

    is_user_existed = graphene.Field(UserNode,username = graphene.String())

    sublist_by_id = graphene.Field(SubListSingleNode,id=graphene.ID())

    search_result = graphene.List(ProductNode,match = graphene.String())
    search_category = graphene.List(SubListNode,match = graphene.String())
    # s = graphene.ObjectType()


    def resolve_cart_product(self,info,id):
        id_ = from_global_id(id)[1]
        # print(id_)
        c = Cart.objects.filter(cart_products_id=id_)
        print(id_)
        if(c):
            return c[0]
        
        # if(Cart.objects.filter(cart_products_id=id_)):

        # return Cart.objects.filter()


    def resolve_product_by_id(self,info,id):
        id = from_global_id(id)[1]
        return Product.objects.get(id = id)

    def resolve_cart_products(self,info):
        cart = Cart.objects.all()
        print(info.context.user)
        # print(dir(info.context.user))
        return cart


    def resolve_search_category(self,info, match):
        cat = SubList.objects.filter(name__icontains=match)
        return cat

    def resolve_search_result(self,info,match):
        prd = Product.objects.filter(name__icontains=match)
        # cat = SubList.objects.filter(name__icontains=match)
        # prd =["45345","435"]
        # cat=["sdf","pdk"]

        return prd
        # return ProductList(
        #     prd = prd,
        #     # cat = cat
        #     # prd = [i.name for i in prd],
        #     # cat = [i.name for i in cat]
        # )


        # print(prd)
        # return prd
        # return prd




    def resolve_is_user_existed(self,info,username):
        d = User.objects.filter(username = username)
        # return d
        if d:
            return d[0]
        # else:
        #     return False

    def resolve_user(self,info,user_id):
        return User.objects.get(id = user_id)

    def resolve_sublist_by_id(self,info,id):
        ids = from_global_id(id)[1]
        return SubList.objects.get(id=ids)

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