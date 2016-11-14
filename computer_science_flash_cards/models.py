from django.db import models,connection,connections


	
# Create your models here.
class Cards(object):
	"""docstring for Cards"""
	id=models. AutoField(primary_key=True)
	type=models.IntegerField(null=False,blank=False) #1 for vocab, 2 for code 
	front=models.TextField(null=False,blank=False)
	back=models.TextField(null=False,blank=False)
	known=models.BooleanField(default=False)
 
class BaseManage(models.Manager):

	def get_db(self):
		cursor=connection.cursor();
		return cursor