from rest_framework import serializers
from .models import *


class AccountSerializers(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = ['email', 'username']


class RegistrationSerializers(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = ['email', 'username', 'password']
        extra_kwargs = {
            'password': {'write_only': True}
        }

    def save(self):
        account = Account(
            email=self.validated_data['email'],
            username=self.validated_data['username']
        )

        password = self.validated_data['password']
        account.set_password(password)
        account.save()
        return account


class CustomerDetailsSerializers(serializers.ModelSerializer):
    class Meta:
        model = CustomerDetails
        fields = '__all__'


class ProductCategoriesSerializers(serializers.ModelSerializer):
    class Meta:
        model = ProductCategories
        fields = '__all__'


class ProductSerializers(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = '__all__'


class CartItemsSerializers(serializers.ModelSerializer):
    class Meta:
        model = CartItems
        fields = '__all__'


class OrderDetailsSerializers(serializers.ModelSerializer):
    class Meta:
        model = OrderDetails
        fields = '__all__'


class OrderSerializers(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = '__all__'


class OrderHistorySerializers(serializers.ModelSerializer):
    class Meta:
        model = OrderHistory
        fields = '__all__'
