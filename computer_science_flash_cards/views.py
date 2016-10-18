from django.shortcuts import render
from django.http import HttpResponse,HttpResponseRedirect,StreamingHttpResponse
from django.contrib.auth.models import User
from django.contrib import auth


def login(request):
	print('用户登录')
	contentVO={
		'title':'用户登录',
		'state':None
	}
	username = request.POST.get('username', '')
	password = request.POST.get('password', '')
	print("username:{0},password:{1}".format(username,password))
	user = auth.authenticate(username=username, password=password)
	if user is not None and user.is_active:
		print(user.__dict__)
		print(user.is_active)
		# Correct password, and the user is marked "active"
		auth.login(request, user)
		# Redirect to a success page.
		contentVO['state']='success'
		return HttpResponseRedirect('/flash/cards')
	return render(request,'computer_science_flash_cards/login.html')

def cards(request):
	if not request.user.is_authenticated():
		return HttpResponseRedirect("/flash/login")
	return render(request,'computer_science_flash_cards/cards.html')