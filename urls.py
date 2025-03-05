from django.urls import path
from .views import *
from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [
    # status
    path('', GetStatusView.as_view()),

    # Authentication
    path('api/v1/auth/register/', RegistrationView.as_view()),
    path('api/v1/auth/login/', obtain_auth_token),

    # customer details
    path('api/v1/customer/details/', CustomerDetails.as_view()),
    path('api/v1/customer/details/<str:pk>/', CustomerDetails.as_view()),

    # Product Category
    path('api/v1/product/category/', ProductCategoriesView.as_view()),
    path('api/v1/product/category/update/<str:pk>/', ProductCategoriesView.as_view()),

    # product
    path('api/v1/product/', ProductView.as_view()),
    path('api/v1/product/update/<str:pk>/', ProductView.as_view()),
    path('api/v1/product/<str:pk>/', SingleProductView.as_view()),

    # cart
    path('api/v1/cart/details/', CartItemsView.as_view()),
    path('api/v1/cart/details/<str:pk>/', CartItemsView.as_view()),

    # Order Details
    path('api/v1/order/details/', OrderDetailsView.as_view()),
    path('api/v1/order/details/<str:pk>/', OrderDetailsView.as_view()),

    # order
    path('api/v1/order/', OrderView.as_view()),
    path('api/v1/order/history/', OrderHistoryView.as_view()),
]
