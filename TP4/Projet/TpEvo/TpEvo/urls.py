from django.conf.urls import patterns, include, url
from django.conf import settings
# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'TpEvo.views.home', name='home'),
    # url(r'^TpEvo/', include('TpEvo.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
	url(r'^$', 'training.views.index', name="accueilUrl"),
    url(r'^login', 'training.views.login', name="loginUrl"),
    url(r'^logout', 'training.views.logout', name="logoutUrl"),
    url(r'^enregistrement', 'training.views.enregistrement', name="enregistrementUrl"),
    url(r'^activation', 'training.views.activation', name="activationUrl"),
    url(r'^groupeinvite', 'training.views.groupeinvite', name="groupeInviteUrl"),
    url(r'^groupe', 'training.views.groupe', name="groupeUrl"),
    url(r'^listemeso', 'training.views.listemeso', name="listemesoUrl"),
    url(r'^creermeso', 'training.views.creermeso', name="creermesoUrl"),
    url(r'^modifmeso', 'training.views.modifmeso', name="modifmesoUrl"),
	url(r'^mesocycle', 'training.views.meso', name="mesocycleUrl"),
	# Ligne pour le CSS, donne le chemin d'acces static au CSS via settings.py
	url(r'^myTrainer/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.MEDIA_ROOT}),

)
