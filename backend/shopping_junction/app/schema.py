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
from django_filters import FilterSet, OrderingFilter
import json
from graphene.utils.str_converters import to_snake_case
import graphql_jwt
from rest_framework_jwt.settings import api_settings
from django.contrib.auth import authenticate
from django.contrib import auth

class OrderedDjangoFilterConnectionField(DjangoFilterConnectionField):
    @classmethod
    def resolve_queryset(
        cls, connection, iterable, info, args, filtering_args, filterset_class
    ):
        qs = super(DjangoFilterConnectionField, cls).resolve_queryset(
            connection, iterable, info, args
        )
        filter_kwargs = {k: v for k, v in args.items() if k in filtering_args}
        qs = filterset_class(data=filter_kwargs, queryset=qs, request=info.context).qs

        order = args.get('orderBy', None)
        if order:
            if type(order) is str:
                snake_order = to_snake_case(order)
            else:
                snake_order = [to_snake_case(o) for o in order]
            qs = qs.order_by(*snake_order)
        return qs


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

from django.forms import *
from django.db.models import Q
from functools import reduce
import operator


class ListFilter(django_filters.CharFilter):

    def sanitize(self, value_list):
        """
        remove empty items in case of ?number=1,,2
        """
        return [v for v in value_list if v != u'']

    def customize(self, value):
        return value

    def filter(self, qs, value):
        
        multiple_vals = value.split(u",")
        multiple_vals = self.sanitize(multiple_vals)
        # multiple_vals = map(self.customize, multiple_vals)
        # actual_filter = django_filters.fields.Lookup(multiple_vals, lookup_expr = "in")
        # actual_filter = django_filters.fields.Lookup(multiple_vals,lookup_expr="exact")
        return super(ListFilter, self).filter(qs, multiple_vals)

class SizeFilter(django_filters.CharFilter):
    def filter(self, qs, value):
        # print(value)
        if value:
            value = value.split(',')
            # print(value)
            # actual_filter = django_filters.fields.Lookup(value, lookup_expr = "in")
            f = self.field_name+"__contains"
            query = reduce(operator.or_ , (Q(sizes__contains = item+",") for item in value))
            # print(len(qs))
            qs = qs.filter(query)
            # print(len(qs))
            # print(qs)
        return super(SizeFilter, self).filter(qs,"")

class ColorsFilter(django_filters.CharFilter):
    def filter(self, qs, value):
        # print(value)
        if value:
            value = value.split(',')
            # print(value)
            # actual_filter = django_filters.fields.Lookup(value, lookup_expr = "in")
            f = self.field_name+"__contains"
            query = reduce(operator.or_ , (Q(colors__contains = item+",") for item in value))
            # print(len(qs))
            qs = qs.filter(query)
            # print(len(qs))
            # print(qs)
        return super(ColorsFilter, self).filter(qs,"")        

class ProductFilter(FilterSet):
    # brand_in = django_filters.CharFilter(field_name="brand", lookup_expr="iexact")
    brand__in = django_filters.BaseInFilter(field_name="brand",lookup_expr="in")
    list_price__gt = django_filters.BaseRangeFilter(field_name="list_price",lookup_expr="range")
    # sizes__in = django_filters.BaseCSVFilter(field_name="sizes",lookup_expr="in")
    sizes__in = SizeFilter(field_name="sizes",lookup_expr="contains")
    colors__in = ColorsFilter(field_name="colors",lookup_expr="contains")
    # def sizes__in(self,queryset,value,**args,**kwargs):
    #     return queryset

    # sizes__in = ListFilter(field_name="sizes")

    # sizes__in = django_filters.(
    #     field_name="sizes",
    #     lookup_expr='in',
    #     # lookup_expr='icontains',
    #     # conjoined=False,
    #     # choices=["S,M,L"],

    # )

    # colors__in = django_filters.BaseInFilter(field_name="color",lookup_expr="in")
    
    # sizes = graphene.List(graphene.String)

    # size__in = django_filters.MultipleChoiceFilter(field_name="sizes",lookup_expr="in")
    # sizes__in = django_filters.BaseInFilter(field_name="brand",lookup_expr="in")
    class Meta:
        model = Product
        fields = '__all__'
        filter_fields = {
            "isActive":["exact"],
            "parent":["lte","gte","exact","isnull"],
            "sizes":["in","icontains","exact","iexact"],
            "list_price":["lte","gte"],
            "brand":["in"]

        }

    
    # brands = django_filters.MultipleChoiceFilter(
    #     # field_class = CharField,
    #     # lookup_choices=("in",)
    #     lookup_expr="in"
    # )
    order_by = OrderingFilter(
        fields=(
            ('id','brand','name','list_price','mrp')
        ),
        # lookup_expr="iexect"
        # filter_fields = {
        #     "isActive":["exact"],
        #     "parent":["lte","gte","exact","isnull"],
        #     "sizes":["in","icontains","exact","iexact"],
        #     "list_price":["lte","gte"],
        #     "brand":["in"]

        # }
    )


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
    instockProduct = graphene.Int()
    outstockProduct = graphene.Int()
    inactiveProduct = graphene.Int()

    sizes = graphene.List(graphene.String)
    color = graphene.List(graphene.String)
    class Meta:
        model = Product
        # filter_fields = ("sizes","parent")
        filter_fields ={
            "isActive":["exact"],
            "parent":["lte","gte","exact","isnull"],
            "sizes":["in","icontains","exact","iexact"],
            "list_price":["lte","gte"],
            "brand":["in"]

        }
        order_by = OrderingFilter(
            fields=(
                ('id','name'),
            )
        )
        
        # filter_fields = {
        #     size:
        #     # "sizes":["exact","icontains","in"],
        #     "name":["icontains"]
        # }


        interfaces = (relay.Node,)
    def resolve_inactiveProduct(self,info):
        return len([i for i in Product.objects.filter(isActive=False)])

    def resolve_instockProduct(self,info):
        return len([i for i in Product.objects.filter(instock=True)])

    def resolve_outstockProduct(self,info):
        return len([i for i in Product.objects.filter(instock=False)])

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
    is_in_cart = graphene.Boolean()
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
    def resolve_is_in_cart(self,info):
        if(Cart.objects.filter(cart_products_id=self.id).filter(user_id=info.context.user.id)):
            return True
        else:
            return False

        print(self.id)



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

class OrdersAddresNode(DjangoObjectType):
    class Meta:
        model = OrdersAddres
        filter_fields = ()
        interfaces = (graphene.Node,)

class SubCategoryNode(DjangoObjectType):
    productSize = graphene.Int()
    class Meta:
        model = SubCategory
        filter_fields = {
            # "product_size":["lte","gte"]
        }
        interfaces = (relay.Node,)
    def resolve_productSize(self,info):
        return len(Product.objects.filter(sublist_id__in=[i.id for i in SubList.objects.filter(sub_category_id=self.id)]))

class SubListNode(DjangoObjectType):
    data = graphene.List(graphene.String)
    productSize = graphene.Int()
    product_set = DjangoFilterConnectionField(ProductNode,filterset_class=ProductFilter)
    class Meta:
        model = SubList
        filter_fields = ()
        interfaces = (relay.Node,)
    def resolve_data(self,info):
        return ["4","6","9"]
    def resolve_productSize(self,info):
        return len(Product.objects.filter(sublist_id = self.id))
    
    # def resolve_products(self,info,**kwargs):
    #     return ProductFilter(kwargs).qs
    # def resolve_product_set(self, info):
    #     return Product.objects.all()
        # return ProductFilter(data=args,queryset=self.products).qs

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
    product_set = DjangoFilterConnectionField(ProductNode,filterset_class=ProductFilter)
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
        # filter_fields = ()
        # interfaces = (graphene.Node,)

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
        # user = graphene.Int(required=True)
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
    def mutate(self,info,house_no,colony,landmark,city,state,person_name,phone_number,alternate_number):
        add = Address.objects.create(
            user_id = info.context.user.id,
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

class CreateGoogleUser(graphene.Mutation):
    class Arguments:
        username = graphene.String(required=True)
        displayName = graphene.String(required=True)
        photoUrl = graphene.String(required=True)
        phone = graphene.String(required=True)

    user = graphene.Field(UserNode)
    token = graphene.String() 
    password = graphene.String()
    def mutate(self,info,username,displayName,phone,photoUrl):
        firstname = displayName.split()[0]
        lastname = displayName.split()[1]
        if(User.objects.filter(username=username)):
            user = User.objects.get(username=username)
            user.first_name = firstname
            user.last_name = lastname
            # user.save()
            p = Profile.objects.get(user_id = user.id)
            p.google_image = photoUrl
            p.phone_number = phone
            p.save()
        else:
            user = get_user_model()(username = username,email = username,first_name = firstname,last_name=lastname)
            user.save()
            Profile.objects.create(user_id = user.id,google_image=photoUrl,is_google_user=True,phone_number=phone)
        
        password = User.objects.make_random_password()
        user.set_password(password)
        user.save()

        jwt_payload_handler = api_settings.JWT_PAYLOAD_HANDLER
        jwt_encode_handler = api_settings.JWT_ENCODE_HANDLER
        # graphql_jwt.ObtainJSONWebToken.mutate()
        token = jwt_encode_handler(jwt_payload_handler(user))
        user = authenticate(username=username,password = password)
        auth.login(info.context,user)
        return CreateGoogleUser(user=user,token=token,password = password)

class CreateUser(graphene.Mutation):
    # user = graphene.Field(UserNode)
    class Arguments:
        username = graphene.String(required=True)
        password = graphene.String(required=True)
        email = graphene.String(required=True)
        firstname = graphene.String(required=True)
        lastname = graphene.String(required=True)

    user = graphene.Field(UserNode)
    def mutate(self,info,username,password,email,firstname,lastname):
        user = get_user_model()(username = username,email = email,first_name = firstname,last_name=lastname)
        user.set_password(password)
        user.save()
        Profile.objects.create(user_id = user.id)
        return CreateUser(user=user)

class UploadImages(graphene.Mutation):
    class Arguments:
        id = graphene.Int()
        # fl = graphene.
    success = graphene.Boolean()
    def mutate(self,info,id):
        # print(dir(info.context))
        # print(info)
        return UploadImages(success=True)



class UpdateOrders(graphene.Mutation):
    class Arguments:
        address_id = graphene.ID()
        paymentMode = graphene.String()
    success = graphene.Boolean()
    def mutate(self,info,address_id,paymentMode):
        cart = Cart.objects.filter(user_id=info.context.user.id)
        oAddress = Address.objects.get(id = from_global_id(address_id)[1])
        
        new_address = OrdersAddres.objects.filter(user_address_id = oAddress.id)

        if(new_address):
            new_address = new_address[0]
        else:
            new_address = OrdersAddres.objects.create(
            house_no = oAddress.house_no,
            colony = oAddress.colony,
            landmark = oAddress.landmark,
            city = oAddress.city,
            state = oAddress.state,
            person_name = oAddress.person_name,
            phone_number = oAddress.phone_number,
            pin_code = oAddress.pin_code,
            user_address_id = oAddress.id,
            alternate_number = oAddress.alternate_number
        )

        print(new_address.id)
        print(id)
        for i in cart:
            ProductOrders.objects.create(
                product_id = i.cart_products.id,
                seller_id = i.cart_products.parent.seller.id,
                buyer_id = info.context.user.id,
                qty = i.qty,
                coupon = 0,
                discount = 0,
                payment_mode = paymentMode,
                mrp = i.cart_products.mrp,
                price = i.cart_products.list_price,
                size = i.size,
                color = i.color,
                address_id = new_address.id
            )
            temp = SubProduct.objects.get(id=i.cart_products.id)
            temp.qty = temp.qty - i.qty

        temp.save()
        Cart.objects.filter(user_id=info.context.user.id).delete()
        return UpdateOrders(success=True)



class UpdateCart(graphene.Mutation):
    class Arguments:
        size = graphene.String(required=False)
        qty = graphene.Int(required=False)
        color = graphene.String(required=False)
        # prd_id = graphene.ID(required=True)
        # user = graphene.Int(required=True)
        prd_id = graphene.ID(required=True)
        is_new = graphene.Boolean(required=True)
    success = graphene.Boolean()
    def mutate(self,info,size,qty,prd_id,is_new,color):
        prd_id = from_global_id(prd_id)[1]
        if(is_new):
            print(info.context.user.id)
            Cart.objects.create(color = color,size = size,qty = qty,cart_products_id = prd_id,user_id = info.context.user.id)
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
class UpdateProduct(graphene.Mutation):
    class Arguments:
        id = graphene.ID(required=True)
        name = graphene.String(required = True)
        brand = graphene.String(required = True)
        sortD = graphene.String(required = True)
        longD = graphene.String(required = True)
    success = graphene.Boolean()
    def mutate(self,info,id,name,sortD,longD,brand):
        prd = Product.objects.get(id = from_global_id(id)[1])
        prd.brand = brand
        prd.name = name
        prd.shortDescription = sortD
        prd.description = longD
        prd.save()
        return UpdateProduct(success = True)

class DeleteSubProduct(graphene.Mutation):
    class Arguments:
        id = graphene.ID(required = True)
    success = graphene.Boolean()
    def mutate(self,info,id):
        SubProduct.objects.get(id = from_global_id(id)[1]).delete()
        return DeleteSubProduct(success = True)
class DeleteProduct(graphene.Mutation):
    class Arguments:
        id = graphene.ID(required = True)
    success = graphene.Boolean()
    def mutate(self,info,id):
        Product.objects.get(id = from_global_id(id)[1]).delete()
        return DeleteProduct(success = True)


class UpdateSubProduct(graphene.Mutation):
    class Arguments:
        id = graphene.ID(required=True)
        mrp = graphene.String(required=True)
        list_price = graphene.String(required=True)
        qty = graphene.String(required=True)
        color = graphene.String(required=True)
    prd = graphene.Field(lambda  :SubProductNode)

    def mutate(self,info,id,mrp,list_price,qty,color):
        print(id)
        id = from_global_id(id)[1]
        prd = SubProduct.objects.get(id=id)
        prd.mrp = mrp
        prd.list_price = list_price
        prd.qty = qty
        prd.color = color
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

class StockStatusProduct(graphene.Mutation):
    class Arguments:
        id = graphene.ID(required = True)
        instock = graphene.Int(required = True) # 1 for instock and 0 for outof stock
    success = graphene.Boolean()
    def mutate(self,info,id,instock):
        id = from_global_id(id)[1]
        p = Product.objects.get(id = id)
        # p.inStock =
        p.instock = instock
        p.isActive = True
        p.save()
        return StockStatusProduct(success = True)

class CancelOrder(graphene.Mutation):
    class Arguments:
        id = graphene.ID(required=True)
    success = graphene.Boolean()
    def mutate(self,info,id):
        order = ProductOrders.objects.get(id = from_global_id(id)[1])
        order.status = "Cancelled"
        order.save()
        return CancelOrder(success = True)


class ActiveProduct(graphene.Mutation):
    class Arguments:
        id = graphene.ID(required = True)
        activate = graphene.Int(required = True) # 1 for activated and 0 for inactivate
    success = graphene.Boolean()
    def mutate(self,info,id,activate):
        id = from_global_id(id)[1]
        p = Product.objects.get(id = id)
        # p.inStock =
        p.isActive = activate
        p.save()
        return ActiveProduct(success = True)


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
    # graphql_jwt.backends.JSONWebTokenBackend.

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
    activate_product = ActiveProduct.Field()
    stock_status_product = StockStatusProduct.Field()
    update_product = UpdateProduct.Field()
    delete_product = DeleteProduct.Field()
    delete_sub_product = DeleteSubProduct.Field()
    cancel_order = CancelOrder.Field()
    create_google_user = CreateGoogleUser.Field()
    # out_of_stock_product = OutOfStockProduct.Field()

    # seller

    create_parent_product = CreateParentProduct.Field()




class Query(graphene.AbstractType):
    all_products = OrderedDjangoFilterConnectionField(ProductNode,orderBy=graphene.List(of_type=graphene.String))
    all_category = DjangoFilterConnectionField(ProductCategoryNode)
    sub_category = OrderedDjangoFilterConnectionField(SubCategoryNode,orderBy=graphene.List(of_type=graphene.String))
    cart_products = DjangoFilterConnectionField(CartNode)
    # filtering = graphene.List(FilterNode)
    filter_by_id = graphene.List(FilterNode,id=graphene.ID())
    cart_product = graphene.Field(CartNode,id = graphene.ID())

    # subcateogry_by_category_id = graphene.List(SubCategoryNode, main_category_id=graphene.ID())

    subcateogry_by_category_id = DjangoFilterConnectionField(SubCategoryNode,main_category_id = graphene.ID())
    sublist_by_subcategory_id = OrderedDjangoFilterConnectionField(SubListNode, sub_category_id=graphene.ID(),filterset_class=ProductFilter)
    product_by_sublist_id = DjangoFilterConnectionField(ProductNode, sublist_id=graphene.ID())
    user = graphene.Field(UserNode)

    product_by_id = graphene.Field(ProductNode,id = graphene.ID())

    orders = DjangoFilterConnectionField(OrdersNode)
    get_order = graphene.Field(OrdersNode,id=graphene.ID())


    is_user_existed = graphene.Field(UserNode,username = graphene.String())

    sublist_by_id = graphene.Field(SubListSingleNode,id=graphene.ID())

    search_result = graphene.List(ProductNode,match = graphene.String())
    search_result_seller = graphene.List(ProductNode,match = graphene.String())
    search_by_brand = graphene.List(ProductNode,match = graphene.String())
    search_category = graphene.List(SubListNode,match = graphene.String())
    # s = graphene.ObjectType()
    product_by_parent_id = DjangoFilterConnectionField(SubProductNode,id=graphene.ID())

    # all_filter = graphene.List(GetFilter)``
    # data = DjangoFilterConnectionField(GetFilter)

    # def resolve_data(self,info):
    #     return ["sdf","sdf"]
    def resolve_get_order(self,info,id):
        return ProductOrders.objects.get(id = from_global_id(id)[1])
    def resolve_filter_by_id(self,info,id):
        print(id)
        id = from_global_id(id)[1]
        print(id)
        # s = SubList.objects.filter(sub_category_id=id)
        # print(s)
        data = Product.objects.filter(sublist_id__in=[i.id for i in SubList.objects.filter(sub_category_id=id)]).filter(isActive=1)
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
        # return None

        # cart = Cart.objects.all().order_by('-id')
        # return cart
        # if(info.context.user.is_authenticated):
        cart = Cart.objects.filter(user_id=info.context.user.id).order_by("-id")
        return cart
        #     return cart
        # else:
            
        # cart  = Cart.objects.filter(user_id=info.context.user.id).order_by("-id")
        # print(info.context.user.id)
        # print(dir(info.context.user))
        

    def resolve_orders(self,info):
        user_id = info.context.user.id
        return ProductOrders.objects.filter(buyer_id = user_id).order_by("-date")


    def resolve_search_category(self,info, match):
        cat = SubList.objects.filter(name__icontains=match)
        return cat

    def resolve_search_by_brand(self,info,match):
        prd = Product.objects.filter(brand__icontains=match).order_by('-id')
        return prd

    def resolve_search_result_seller(self,info,match):
        prd = Product.objects.filter(name__icontains = match).order_by('-id')
        return prd

    def resolve_search_result(self,info,match):
        prd = Product.objects.filter(name__icontains = match).filter(isActive=1).order_by('-id')
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

    def resolve_user(self,info):
        print(info.context)
        # print(dir(info))
        # print(dir(info.schema))
        user_id = info.context.user.id
        return User.objects.get(id = user_id)

    def resolve_sublist_by_id(self,info,id):
        ids = from_global_id(id)[1]
        return SubList.objects.get(id=ids)

    def resolve_product_by_sublist_id(self,info,sublist_id):
        ids = from_global_id(sublist_id)[1]
        return Product.objects.filter(sublist_id = ids)

    # def resolve_sublist_by_id

    def resolve_sublist_by_subcategory_id(self,info,sub_category_id):
        print(info.context.user)
        ids = from_global_id(sub_category_id)[1]
        return SubList.objects.filter(sub_category_id = ids)


    def resolve_subcateogry_by_category_id(self,info,main_category_id):
        ids = from_global_id(main_category_id)[1]
        return SubCategory.objects.filter(main_category_id = ids)



    def resolve_sub_category(self,info,**kwargs):
        return SubCategory.objects.all()

    def resolve_all_products(self, info,**kwargs):
        # return Product.objects.exclude(parent=1)
        user = info.context.user
        print(user.id)
        print(user.is_authenticated)
        # return ProductFilter(queryset=self.all_products).qs

        return Product.objects.all().order_by("-id")

    def resolve_all_category(self,info,**kwargs):
        # print(info.context.user)
        return ProductCategory.objects.all()
