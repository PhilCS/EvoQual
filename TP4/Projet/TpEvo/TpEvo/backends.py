# coding=utf-8
from django.conf import settings
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.models import User
from training.models import Athlete

class EmailModelBackend(object):
    def authenticate(self, username=None, password=None):
        AuthenticationForm.error_messages.update({'inactive': "Ce compte est inactif. Si celui-ci vient d'être créé, veuillez l'activer en cliquant sur le lien dans le courriel vous ayant été envoyé."})
        try:
            user = User.objects.get(email=username)
            if user.check_password(password) and Athlete.objects.filter(user=user).exists():
                return user
        except User.DoesNotExist:
            return None

    def get_user(self, user_id):
        try:
            return User.objects.get(pk=user_id)
        except User.DoesNotExist:
            return None
