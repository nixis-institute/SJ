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
import django_filters
import json
import graphql_jwt

class InnerItem(graphene.ObjectType):
    List = graphene.List(graphene.String)


class Dictionary(graphene.ObjectType):
    key = graphene.String()
    value = graphene.List(graphene.String)
    # value = graphene.Field(InnerItem)

class FilterNode(DjangoObjectType):
    # data = graphene.List(Dictionary)
    # brand = graphene.List(graphene.String)
    # size = graphene.List(graphene.String)
    # dic = graphene.ObjectType()
    class Meta:
        model = Product
        filter_fields=()
        # description ="sdf"
        # model = Product
        
        interfaces = (graphene.Node,)

    # def resolve_data(self,info):
    #     # print(id)
    #     print(info.variable_values)
    #     print(info.context.GET)
    #     # print(dir(info.context.POST.values))
    #     br = [i.brand for i in Product.objects.all()]
    #     size = [i.size for i in SubProduct.objects.all()]
    #     color = [i.color for i in SubProduct.objects.all()]

    #     # inner = InnerItem(br)
    #     d = Dictionary("Brands",list(set(br)))
    #     s = Dictionary("Sizes",list(set(size)))
    #     c = Dictionary("Color",list(set(color)))

    #     return [d,s,c]
        # [i.brand for i in Product.objects.all()]

class ProductNode(DjangoObjectType):
    
    # class Arguments:
    #     kind_in = graphene.List(graphene.String)
    # sizes = django_filters.MultipleChoiceFilter(lookup_expr=["iexact"])
    # sizes = django_filters.LookupChoiceFilter(
    #     field_class=forms.CharField,
    #     lookup_choices=[(
    #         'exact',"Equals",
    #     )]
    # )
    productSize = graphene.Int()
    sizes = graphene.List(graphene.String)
    color = graphene.List(graphene.String)
    class Meta:
        model = Product
        # filter_fields = ("sizes","parent")
        filter_fields ={
            "parent":["lte","gte","exact","isnull"],
            "sizes":["in","icontains","exact","iexact"],
            "list_price":["lte","gte"],
            "brand":["in"]

        }
        # filter_fields = {
        #     size:
        #     # "sizes":["exact","icontains","in"],
        #     "name":["icontains"]
        # }


        interfaces = (relay.Node,)
    def resolve_productSize(self,info):
        return len([i for i in SubProduct.objects.filter(parent_id=self.id)])
    def resolve_sizes(self,info):
        return [i.size for i in SubProduct.objects.filter(parent_id=self.id)]
    def resolve_color(self,info):
        return [i.color for i in SubProduct.objects.filter(parent_id=self.id)]        

# class ProductList(DjangoObjectType):
#     # prd = graphene.ObjectType()
#     # cat = graphene.ObjectType(graphene.String)
#     # prd = graphene.ObjectType()
#     kind_in = graphene.List(graphene.String)
#     class Meta:
#         model = Product
#         # filter_fields = ("brand","colors","sizes","name")
#         filter_fields={
#             "sizes":["exact","icontains","in"],
#             "name":["icontains"],
#             # "brand":
#         }
#         interfaces = (relay.Node,)        
#     # class Meta:
#     #     model = Product
#     #     filter_fields = ()
#     #     interfaces = (relay.Node,)


#     # prd_list = graphene.List(graphene.String)
#     # catetory  =graphene.ObjectType()
#     # class Meta:
#     #     model = Product
#     # def resolve_product_list(self,info):
#     #     return [i.name for i in Product.objects.all()]
#     # appears_in = graphene.List(graphene.String)

class ProductSliderNode(DjangoObjectType):
    class Meta:
        model = ProductSlider
        filter_fields = ()
        interfaces = (graphene.Node,)

class SubProductNode(DjangoObjectType):
    class Meta:
        model = SubProduct
        filter_fields = {
        # "parent":["lte","gte","exact","isnull"],
        "size":["in","icontains","exact","iexact"],
        "list_price":["lte","gte"],
        # "brand":["in"]
        "color":["in","icontains","exact","iexact"],
        }
        interfaces = (relay.Node,)


class ProductCategoryNode(DjangoObjectType):
    productSize = graphene.Int()
    class Meta:
        model = ProductCategory
        filter_fields = ()
        interfaces = (relay.Node,)
    def resolve_productSize(self,info):
        return len(Product.objects.filter(sublist_id__in=[i.id for i in SubList.objects.filter(sub_category_id__in=[i.id for i in ProductCategory.objects.get(id=self.id).subcategory_set.all()])]))

class OrdersNode(DjangoObjectType):
    class Meta:
        model = ProductOrders
        filter_fields = ()
        interfaces = (relay.Node,)

class SubCategoryNode(DjangoObjectType):
    productSize = graphene.Int()
    class Meta:
        model = SubCategory
        filter_fields = ()
        interfaces = (relay.Node,)
    def resolve_productSize(self,info):
        return len(Product.objects.filter(sublist_id__in=[i.id for i in SubList.objects.filter(sub_category_id=self.id)]))

class SubListNode(DjangoObjectType):
    data = graphene.List(graphene.String)
    productSize = graphene.Int()
    class Meta:
        model = SubList
        filter_fields = ()
        interfaces = (relay.Node,)
    def resolve_data(self,info):
        return ["4","6","9"]
    def resolve_productSize(self,info):
        return len(Product.objects.filter(sublist_id = self.id))

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
# class GetFilter(DjangoObjectType):
#     data = graphene.ObjectType()
#     class Meta:
#         model = Product

    # def resolve_data(self,info):
    #     return [i.brand for i in Product.objects.all()]

class UserType(DjangoObjectType):
    class Meta:
        model = get_user_model()


class DeleteAddress(graphene.Mutation):
    class Arguments:
        id = graphene.ID(required=True)
    success = graphene.Boolean()
    def mutate(self,info,id):
        id = from_global_id(id)[1]
        Address.objects.get(id=id).delete()
        return DeleteAddress(success=True)


class UpdateAddress(graphene.Mutation):
    class Arguments:
        id = graphene.ID(required=True)
        # user = graphene.Int(required=True)
        house_no = graphene.String(required=True)
        colony = graphene.String(required=True)
        landmark = graphene.String(required=False)
        city = graphene.String(required=True)
        state = graphene.String(required=True)
        person_name = graphene.String(required=True)
        phone_number = graphene.String(required=True)
        alternate_number = graphene.String(required=False)    
    success = graphene.Boolean()
    address = graphene.Field(AddressNode)
    def mutate(self,info,id,house_no,colony,landmark,city,state,person_name,phone_number,alternate_number):
        id = from_global_id(id)[1]
        obj = Address.objects.get(id = id)
        obj.house_no = house_no
        obj.colony = colony
        obj.landmark = landmark
        obj.city = city
        obj.state = state
        obj.person_name = person_name
        obj.phone_number = phone_number
        obj.alternate_number = alternate_number


        obj.save()
        return UpdateAddress(success=True,address=obj)

class AddAddress(graphene.Mutation):
    class Arguments:
        user = graphene.Int(required=True)
        house_no = graphene.String(required=True)
        colony = graphene.String(required=True)
        landmark = graphene.String(required=False)
        city = graphene.String(required=True)
        state = graphene.String(required=True)
        person_name = graphene.String(required=True)
        phone_number = graphene.String(required=True)
        alternate_number = graphene.String(required=False)
    address = graphene.Field(AddressNode)
    success = graphene.Boolean()
    def mutate(self,info,user,house_no,colony,landmark,city,state,person_name,phone_number,alternate_number):
        add = Address.objects.create(
            user_id = user,
            house_no = house_no,
            colony = colony,
            landmark = landmark,
            city = city,
            state = state,
            person_name = person_name,
            phone_number = phone_number,
            alternate_number = alternate_number
        )
        return AddAddress(success = True,address = add)

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

class UploadImages(graphene.Mutation):
    class Arguments:
        id = graphene.Int()
        # fl = graphene.
    success = graphene.Boolean()
    def mutate(self,info,id):
        print(dir(info.context))
        print(info)
        return UploadImages(success=True)



class UpdateOrders(graphene.Mutation):
    class Arguments:
        id = graphene.Int()
        paymentMode = graphene.String()
    success = graphene.Boolean()
    def mutate(self,info,id,paymentMode):
        cart = Cart.objects.filter(user_id=id)
        for i in cart:
            ProductOrders.objects.create(
                product_id = i.cart_products.id,
                seller_id = id,
                buyer_id = id,
                qty = i.qty,
                coupon = 0,
                discount = 0,
                payment_mode=paymentMode,
                price = i.cart_products.list_price,
                size = i.size
            )

        Cart.objects.filter(user_id=id).delete()
        return UpdateOrders(success=True)



class UpdateCart(graphene.Mutation):
    class Arguments:
        size = graphene.String(required=False)
        qty = graphene.Int(required=False)
        # prd_id = graphene.ID(required=True)
        user = graphene.Int(required=True)
        prd_id = graphene.ID(required=True)
        is_new = graphene.Boolean(required=True)
    success = graphene.Boolean()
    def mutate(self,info,size,qty,prd_id,user,is_new):
        prd_id = from_global_id(prd_id)[1]
        if(is_new):
            Cart.objects.create(size = size,qty = qty,cart_products_id = prd_id,user_id = user)
        else:
            # c = Cart.objects.get(cart_products_id=prd_id)
            Cart.objects.get(cart_products_id=prd_id).delete()

        return UpdateCart(success = True)


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

class UpdateSubProduct(graphene.Mutation):
    class Arguments:
        id = graphene.ID(required=True)
        mrp = graphene.String(required=True)
        list_price = graphene.String(required=True)
        qty = graphene.String(required=True)
    prd = graphene.Field(lambda  :SubProductNode)
    
    def mutate(self,info,id,mrp,list_price,qty):
        print(id)
        id = from_global_id(id)[1]
        prd = SubProduct.objects.get(id=id)
        prd.mrp = mrp
        prd.list_price = list_price
        prd.qty = qty
        prd.save()
        return UpdateSubProduct(prd = prd)


class CreateParentProduct(graphene.Mutation):
    class Arguments:
        type_id = graphene.ID(required=True)
        prd_name = graphene.String(required=True)
        brand = graphene.String(required=True)
        short_desc = graphene.String(required=False)
        long_desc = graphene.String(required=False)
    prd_id = graphene.Int()
    prd = graphene.Field(lambda:ProductNode)
    # prd = graphene.

    def mutate(self,info,type_id,prd_name,brand,short_desc,long_desc):
        type_id = from_global_id(type_id)[1]

        prd = Product.objects.create(
            name=prd_name,
            brand=brand,
            shortDescription=short_desc,
            description=long_desc,
            sublist_id=type_id
            )
        return CreateParentProduct(prd_id=prd.id,prd=prd)

class CreateSubProduct(graphene.Mutation):
    class Arguments:
        id = graphene.ID(required=True)
        size = graphene.String(required=True)
        color = graphene.String(required=True)
        qty = graphene.String(required=True)
        mrp = graphene.String(required=True)
        list_price = graphene.String(required=True)
    sub_product = graphene.Field(SubProductNode)

    def mutate(self,info,id,size,color,qty,mrp,list_price):
        id = from_global_id(id)[1]
        prd = SubProduct.objects.create(
            mrp = mrp,
            list_price = list_price,
            qty = qty,
            color = color,
            size = size,
            parent_id = id
            )
        return CreateSubProduct(sub_product = prd)


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
        
        
#eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6ImFkbWluIiwiZXhwIjoxNTg2MDg4MTY0LCJvcmlnSWF0IjoxNTg2MDg3ODY0fQ.5g0iEgS8EFi294JNXHm5TlcXLqr2qGmeRMMedr3pJBI

class Mutation(graphene.ObjectType):
    
    # buyer
    token_auth = graphql_jwt.ObtainJSONWebToken.Field()
    verify_token = graphql_jwt.Verify.Field()
    refresh_token = graphql_jwt.Refresh.Field()    
    create_user = CreateUser.Field()
    change_password = ChangePassword.Field()
    update_user = UpdateUser.Field()
    update_cart = UpdateCart.Field()
    add_address = AddAddress.Field()
    update_address = UpdateAddress.Field()
    delete_address = DeleteAddress.Field()
    update_orders = UpdateOrders.Field()
    upload_images = UploadImages.Field()
    update_sub_product = UpdateSubProduct.Field()
    create_sub_product = CreateSubProduct.Field()

    # seller

    create_parent_product = CreateParentProduct.Field()




class Query(graphene.AbstractType):
    all_products = DjangoFilterConnectionField(ProductNode)
    all_category = DjangoFilterConnectionField(ProductCategoryNode)
    sub_category = DjangoFilterConnectionField(SubCategoryNode)
    cart_products = DjangoFilterConnectionField(CartNode)
    # filtering = graphene.List(FilterNode)
    filter_by_id = graphene.List(FilterNode,id=graphene.ID())
    cart_product = graphene.Field(CartNode,id = graphene.ID())

    # subcateogry_by_category_id = graphene.List(SubCategoryNode, main_category_id=graphene.ID())

    subcateogry_by_category_id = DjangoFilterConnectionField(SubCategoryNode,main_category_id = graphene.ID())
    sublist_by_subcategory_id = DjangoFilterConnectionField(SubListNode, sub_category_id=graphene.ID())
    product_by_sublist_id = DjangoFilterConnectionField(ProductNode, sublist_id=graphene.ID())
    user = graphene.Field(UserNode,user_id = graphene.Int())

    product_by_id = graphene.Field(ProductNode,id = graphene.ID())
    
    orders = DjangoFilterConnectionField(OrdersNode, user_id=graphene.Int())
    

    is_user_existed = graphene.Field(UserNode,username = graphene.String())

    sublist_by_id = graphene.Field(SubListSingleNode,id=graphene.ID())

    search_result = graphene.List(ProductNode,match = graphene.String())
    search_category = graphene.List(SubListNode,match = graphene.String())
    # s = graphene.ObjectType()
    product_by_parent_id = DjangoFilterConnectionField(SubProductNode,id=graphene.ID())
    
    # all_filter = graphene.List(GetFilter)``
    # data = DjangoFilterConnectionField(GetFilter)

    # def resolve_data(self,info):
    #     return ["sdf","sdf"]
    def resolve_filter_by_id(self,info,id):
        id = from_global_id(id)[1]
        print(id)
        # s = SubList.objects.filter(sub_category_id=id)
        # print(s)
        data = Product.objects.filter(sublist_id__in=[i.id for i in SubList.objects.filter(sub_category_id=id)])
        # data = Product.objects.filter(sub_category_id=id)

        # print(data)
        return data


    # def resolve_filtering(self,info,**kwargs):
    #     # return [1]
    #     # print()
    #     # return {"sdf":["sdf","SDf"]}
    #     return [i.brand for i in Product.objects.all()]

    def resolve_product_by_parent_id(self,info,id):
        id = from_global_id(id)[1]
        return SubProduct.objects.filter(parent_id=id)

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
        
        # cart = Cart.objects.all().order_by('-id')

        cart  = Cart.objects.filter(user_id=info.context.user.id)
        # print(info.context.user.id)
        # print(dir(info.context.user))
        return cart

    def resolve_orders(self,info,user_id):
        return ProductOrders.objects.filter(buyer_id = user_id).order_by("-date")


    def resolve_search_category(self,info, match):
        cat = SubList.objects.filter(name__icontains=match)
        return cat

    def resolve_search_result(self,info,match):
        prd = Product.objects.filter(name__icontains=match).order_by('-id')
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

    # def resolve_sublist_by_id

    def resolve_sublist_by_subcategory_id(self,info,sub_category_id):
        ids = from_global_id(sub_category_id)[1]
        return SubList.objects.filter(sub_category_id = ids)


    def resolve_subcateogry_by_category_id(self,info,main_category_id):
        ids = from_global_id(main_category_id)[1]
        return SubCategory.objects.filter(main_category_id = ids)



    def resolve_sub_category(self,info,**kwargs):
        return SubCategory.objects.all()

    def resolve_all_products(self,info,**kwargs):
        # return Product.objects.exclude(parent=1)
        user = info.context.user
        print(user.is_authenticated)
        return Product.objects.all()

    def resolve_all_category(self,info,**kwargs):
        return ProductCategory.objects.all()