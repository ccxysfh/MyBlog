from django.shortcuts import render
from django.http import HttpResponse,HttpResponseRedirect,StreamingHttpResponse
from django.contrib.auth.models import User
from django.contrib import auth

from . import models


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
	cur=models.BaseManage().get_db()
	query = '''
		SELECT id, type, front, back, known
		FROM cards
		ORDER BY id DESC
	'''
	cur.execute(query)
	cards = cur.fetchall()
	print(type(cards))
	print(type(cards[0]))
	return render(request,'computer_science_flash_cards/cards.html', {'cards':cards, 'filter_name':"all"})


def filter_cards(request,filter_name):
	if not request.user.is_authenticated():
		return HttpResponseRedirect("/flash/login")

	filters = {
	    "all":      "where 1 = 1",
	    "general":  "where type = 1",
	    "code":     "where type = 2",
	    "known":    "where known = 1",
	    "unknown":  "where known = 0",
	}

	query = filters.get(filter_name)

	if not query:
	    return HttpResponseRedirect("/flash/cards")

	cur=models.BaseManage().get_db()
	fullquery = "SELECT id, type, front, back, known FROM cards " + query + " ORDER BY id DESC"
	cur.execute(query)
	cards = cur.fetchall()
	return render(request,'computer_science_flash_cards/cards.html',{'cards':cards[:10], 'filter_name':filter_name})

def edit(card_id):
	if not request.user.is_authenticated():
		return HttpResponseRedirect("/flash/login")
	print(card_id)
	cur=models.BaseManage().get_db()
	query = '''
	    SELECT id, type, front, back, known
	    FROM cards
	    WHERE id = ?
	'''
	cur.execute(query,card_id)
	cards = cur.fetchall()
	return render(request,'computer_science_flash_cards/edit.html')

def edit_card():
	if not request.user.is_authenticated():
		return HttpResponseRedirect("/flash/login")

	selected = request.form.getlist('known')
	known = bool(selected)
	cur=models.BaseManage().get_db()
	command = '''
	    UPDATE cards
	    SET
	      type = ?,
	      front = ?,
	      back = ?,
	      known = ?
	    WHERE id = ?
	'''
	cur.execute(command,
	           [request.form['type'],
	            request.form['front'],
	            request.form['back'],
	            known,
	            request.form['card_id']
	            ])
	cur.commit()
	return HttpResponseRedirect("/flash/cards")