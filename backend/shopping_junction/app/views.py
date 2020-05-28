from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status,viewsets
from rest_framework.viewsets import ModelViewSet
from app.serializers import *
from app.models import *
from graphql_relay.node.node import from_global_id
# Create your views here.
def home(request):
    return render(request,"home.amp.html")


class UploadParentImages(viewsets.ModelViewSet):
    queryset = ProductImages.objects.all()
    serializer_class = UploadParentImageSerializer
    def perform_create(self,serializer):
        print(self.request.data["parent_id"])
        serializer.save(parent_id = from_global_id(self.request.data["parent_id"])[1])

class ProfileSer(viewsets.ModelViewSet):
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
    def perform_create(self,serializer):
        # print(self.request.user)
        # print(self.request.data)
        serializer.save(user_id=self.request.user.id)
    
    def perform_update(self,serializer):
        print(self.request.data)
        print(self.request.data["image"])
        serializer.save(image = self.request.data["image"])

class UploadSubProductImages(viewsets.ModelViewSet):
    queryset = ProductImages.objects.all()
    serializer_class = UploadSubProductImageSerializer
    def perform_create(self,serializer):
        # product_id = 45
        if self.request.data["product_id"].isdigit():
            product_id = self.request.data["product_id"]
        else:
            product_id = from_global_id(self.request.data["product_id"])[1]
        serializer.save(product_id = product_id)



def UploadParentImages2(APIView):
    def get(self,request,format=None):
        photos = ProductImages.objects.all()
        serializer_context = {
            'request': request,
        }        
        serializer = UploadParentImageSerializer(photos,context=serializer_context)
        return Response(serializer.data)


    def post(self,request,format=None):
        serializer = UploadParentImageSerializer (data = request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


