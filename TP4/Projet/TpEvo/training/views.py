# coding=utf-8
# Programmeur:	Philippe Carpentier-Savard
from __future__ import unicode_literals # Cette simple déclaration s'assure que tous les strings sont en unicode... plus de maudits UnicodeDecodeError
from django.shortcuts import render
from django.http import Http404
from django.http import HttpResponse
from django.http import HttpResponseRedirect
from django.conf import settings
from django.contrib import auth
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.models import User
from django.core.exceptions import ObjectDoesNotExist
from django.core.mail import EmailMessage
from django.db.models.query import QuerySet
from django.utils import timezone
from training.models import Activite, Athlete, AthleteForm, Coach, Entrainement, EntrainementActivite, EntrainementAthlete, Groupe, GroupeForm, InvitationGroupe, MesoForm, Mesocycle, MesocycleEntrainement, Records
from training.utils import generate_random_username
import calendar
import datetime
import hashlib
import math
import re


def login(request):
	if request.user.is_authenticated():
		return HttpResponseRedirect('/')

	elif request.method == 'POST':
		f = AuthenticationForm(data=request.POST)
		if f.is_valid() :
			# Voir TpEvo/backends.py si compréhension nécessaire
			auth.login(request, f.get_user())
			next = request.GET.get('next', '/')
			return HttpResponseRedirect(next)

	else:
		f = AuthenticationForm()

	return render(request, 'myTrainer/login.html',{'form':f})

def logout(request):
	auth.logout(request)
	return HttpResponseRedirect("/login")

def enregistrement(request):
	if request.user.is_authenticated():
		return HttpResponseRedirect('/')

	idInvite = request.GET.get("invite", False)
	tokenInvite = request.GET.get("token", False)

	if request.method == "GET" and idInvite and tokenInvite:
		f = AthleteForm()
		f.fields['type_compte'].widget.attrs['disabled'] = True

		return render(request, 'myTrainer/enregistrement.html',{'form':f, 'invite':idInvite, 'token':tokenInvite})

	elif request.method == 'POST':
		idInvite = request.POST.get("invite", False)
		tokenInvite = request.POST.get("token", False)

		ig = False
		groupe = False
		modPOST = False

		if idInvite and tokenInvite:

			idInvite = int(idInvite)
			try:
				ig = InvitationGroupe.objects.get(pk=int(idInvite))
				dateEnvoi = timezone.make_naive(ig.date_envoi, timezone.get_current_timezone())

				if ig.user is None and hashlib.md5(dateEnvoi.ctime()).hexdigest() == tokenInvite:
					groupe = ig.groupe
				else:
					raise ObjectDoesNotExist()

			except ObjectDoesNotExist:
				return render(request, 'myTrainer/enregistrement.html',{'message':"Erreur : La demande d'invitation spécifiée est invalide."})

			modPOST = request.POST.copy()
			modPOST['type_compte'] = '1'

		if modPOST:
			f = AthleteForm(modPOST)
		else:
			f = AthleteForm(request.POST)

		if f.is_valid():
			a = Athlete()
			a.user = User.objects.create_user(generate_random_username(), email=f.cleaned_data['courriel'], password=f.cleaned_data['motPasse'])
			a.user.is_active = False
			a.user.save()
			a.nom=f.cleaned_data['nom']
			a.VAM=f.cleaned_data['VAM']

			if groupe:
				a.groupe = groupe

			a.save()

			if not ig and f.cleaned_data['type_compte'] == '2':
				c = Coach()
				c.user = a
				c.save()

			if ig:
				ig.delete()

			url_activ = 'http://' + request.get_host() + '/activation?id=' + str(a.user.pk) + '&token=' + hashlib.md5(a.user.date_joined.ctime()).hexdigest()

			e = EmailMessage('Entraînmax – Activation de votre compte', 'Veuillez cliquer sur ce lien pour activer votre compte: <a href="' + url_activ + '">' + url_activ + '</a>', to=[a.user.email])
			e.content_subtype = "html"
			e.send()
			return render(request, 'myTrainer/enregistrement.html')

		elif groupe:
			f.fields['type_compte'].widget.attrs['disabled'] = True

	else:
		f = AthleteForm()

	return render(request, 'myTrainer/enregistrement.html',{'form':f, 'invite':idInvite, 'token':tokenInvite})

def activation(request):
	if request.user.is_authenticated():
		return HttpResponseRedirect('/')

	idUser = request.GET.get('id', False)
	token = request.GET.get('token', False)

	if idUser and token:
		try:
			u = User.objects.get(pk=int(idUser))

			if not u.is_active and token == hashlib.md5(u.date_joined.ctime()).hexdigest():
				u.is_active = True
				u.save()
				return render(request, 'myTrainer/activation.html', {'email_actif':u.email})

		except User.DoesNotExist:
			pass

	return HttpResponseRedirect('/')

@login_required
def index(request):
	try:
		invitation = request.user.athlete.invitationgroupe
	except InvitationGroupe.DoesNotExist:
		invitation = False

	if invitation:
		return render(request, 'myTrainer/index.html', {'infos_invitation':[invitation.groupe.coach.user.nom, invitation.groupe.nom]})

	return render(request, 'myTrainer/index.html')

@login_required
def groupe(request):
	try:
		c = request.user.athlete.coach
	except Coach.DoesNotExist:
		return render(request, 'myTrainer/groupe.html')
	try:
		g = c.groupe
		return render(request, 'myTrainer/groupe.html', {'message':"Erreur : Vous êtes déjà entraîneur d'un groupe."})
	except Groupe.DoesNotExist:
		if request.method == 'POST':
			f = GroupeForm(request.POST)
			if f.is_valid():
				g = Groupe()
				g.nom = f.cleaned_data['nom']
				g.coach = c
				g.save()

				c.user.groupe = g
				c.user.save()

				# listSuccess = []
				# listFail = []
				# listPending = []

				for courriel in f.cleaned_data['courriels']:
					users = User.objects.filter(email=courriel)

					ig = InvitationGroupe()
					ig.groupe = g
					ig.date_envoi = datetime.datetime.now()
					ig.save()

					if users.exists():
						athlete = users[0].athlete
						if athlete.groupe is None:
							ig.user = athlete
							# listSuccess.append(courriel)
						else:
							# listFail.append(courriel)
							pass
					else:
						ig.courriel = courriel
						# listPending.append(courriel)

						url_invite = 'http://' + request.get_host() + '/enregistrement?invite=' + str(ig.pk) + '&token=' + hashlib.md5(ig.date_envoi.ctime()).hexdigest()

						e = EmailMessage('Entraînmax – Invitation à rejoindre un groupe', 'L\'entraîneur ' + c.user.nom + ' vous a invité à rejoindre le groupe "' + g.nom + '". Cliquer sur ce lien pour créer votre compte: <a href="' + url_invite + '">' + url_invite + '</a>', to=[courriel])
						e.content_subtype = "html"
						e.send()

					ig.save()

				ig.save()
				return render(request, 'myTrainer/groupe.html', {'message':'Création du groupe "' + g.nom + '" réussie. Des courriels d\'invitation ont été envoyés à ceux n\'étant pas inscrits sur le site.'})

		else:
			f = GroupeForm()

	return render(request, 'myTrainer/groupe.html', {'form':f})

@login_required
def groupeinvite(request):
	reponse = request.GET.get('reponse', False)

	if reponse:
		try:
			a = request.user.athlete
			ig = a.invitationgroupe
			resultat = False

			if reponse == 'oui':
				a.groupe = ig.groupe
				a.save()
				resultat = a.groupe.nom

			ig.delete()

			return render(request, 'myTrainer/groupeinvite.html', {'accepter':resultat})

		except ObjectDoesNotExist:
			pass

	return HttpResponseRedirect('/')

@login_required
def listemeso(request):
	try:
		coach = request.user.athlete.coach
	except Coach.DoesNotExist:
		return render(request, 'myTrainer/listemeso.html')
	try:
		groupe = coach.groupe
	except Groupe.DoesNotExist:
		return render(request, 'myTrainer/listemeso.html', {'message':"Erreur : Vous devez d'abord créer un groupe pour avoir accès à cette page."})


	mesos = groupe.mesocycle_set.order_by('periode').all()
	mesos_exists = True

	if not mesos.exists():
		mesos = True
		mesos_exists = False

	return render(request, 'myTrainer/listemeso.html', {'mesos':mesos, 'mesos_exists':mesos_exists})

@login_required
def creermeso(request):
	try:
		c = request.user.athlete.coach
	except Coach.DoesNotExist:
		return render(request, 'myTrainer/creermeso.html')
	try:
		g = c.groupe
	except Groupe.DoesNotExist:
		return render(request, 'myTrainer/creermeso.html', {'message':"Erreur : Vous devez d'abord créer un groupe pour avoir accès à cette page."})

	if request.method == 'POST':
		f = MesoForm(request.POST)
		if f.is_valid():
			periode = datetime.date(int(f.cleaned_data['annees']), int(f.cleaned_data['mois']), 1)
			nomperiode = settings.NOM_MOIS[periode.month][1] + " " + str(periode.year)

			if g.mesocycle_set.filter(periode=periode).exists():
				return render(request, 'myTrainer/creermeso.html', {'message':'Erreur : Votre groupe possède déja un mésocycle pour ' + nomperiode + '.'})
			else:
				m = Mesocycle()
				m.periode = periode
				m.nom = nomperiode
				m.groupe = g
				m.save()
				return render(request, 'myTrainer/creermeso.html', {'message':'Création du mésocycle "'+ nomperiode + '" effectuée avec succès.</p><p><a href="/listemeso">Accéder à la liste des mésocycles</a>'})

	else:
		f = MesoForm()

	return render(request, 'myTrainer/creermeso.html', {'form':f})

@login_required
def modifmeso(request):
	try:
		c = request.user.athlete.coach
	except Coach.DoesNotExist:
		return render(request, 'myTrainer/modifmeso.html')
	try:
		g = c.groupe
	except Groupe.DoesNotExist:
		return render(request, 'myTrainer/modifmeso.html', {'message':"Erreur : Vous devez d'abord créer un groupe pour avoir accès à cette page."})

	if request.method == 'POST':
		publier = request.POST.get("publier", False)
		meso_pattern = re.compile(r'(?:modif-mesocycle-)([0-9]+)')
		mesocycle = 0

		for param in request.POST:
			meso = re.findall(meso_pattern, param)
			if len(meso) == 1 :
				mesocycle = int(meso[0])
				break

		if mesocycle > 0:
			try:
				m = Mesocycle.objects.get(pk=mesocycle)
			except Mesocycle.DoesNotExist:
				m = False

			if m:
				if m.groupe != g:
					return render(request, 'myTrainer/modifmeso.html', {'message':"Erreur : Vous n'êtes pas entraîneur du groupe auquel ce mésocycle est assigné."})
				else:
					entrainements = Entrainement.objects.all()
					sauvegarde = request.POST.get("sauvegarde-mesocycle", False)

					if not sauvegarde:
						if entrainements.exists():
							return render(request, 'myTrainer/modifmeso.html', {'calendrier':CreerCalModifMeso(m), 'meso':m})
						else:
							return render(request, 'myTrainer/modifmeso.html', {'message':"Erreur : Il n'existe aucun entraînement. Vous devez d'abord en créer un avant de modifier le mésocycle."})
					else:
						ent_pattern = re.compile(r'(?:ent-j)([0-9]+)')
						mesoEnts = m.mesocycleentrainement_set.order_by('jour').all()

						if publier:
							m.public = True
							m.save()

						for param, value in request.POST.iteritems():
							jourEnt = re.findall(ent_pattern, param)
							if len(jourEnt) == 1:
								e = 0

								if value != '0':
									try:
										e = entrainements.get(pk=int(value))
									except Entrainement.DoesNotExist:
										e = -1

								if e != -1:
									jourMois = int(jourEnt[0])
									if jourMois >= 1 and jourMois <= calendar.monthrange(m.periode.year, m.periode.month)[1]:
										dateEnt = datetime.date(m.periode.year, m.periode.month, jourMois)
										creerEntAth = False

										try:
											me = mesoEnts.get(jour=dateEnt)
											if e == 0:
												me.delete()
											elif me.entrainement != e:
												me.entrainement = e
												me.save()
											else:
												creerEntAth = not me.entrainementathlete_set.exists()

										except MesocycleEntrainement.DoesNotExist:
											if e != 0:
												me = MesocycleEntrainement()
												me.mesocycle = m
												me.entrainement = e
												me.jour = dateEnt
												me.save()
												creerEntAth = True

										if m.public and creerEntAth:
											for a in g.athlete_set.filter(coach=None).all():
												ea = EntrainementAthlete()
												ea.seance = me
												ea.athlete = a
												ea.save()

						return render(request, 'myTrainer/modifmeso.html', {'message':'Sauvegarde du mésocycle "' + m.nom + '" effectuée avec succès.</p><p><a href="/listemeso">Retour à la liste des mésocycles</a>'})

	return render(request, 'myTrainer/modifmeso.html', {'message':"Erreur : Vous devez d'abord passez par la liste des mésocycles pour accéder à cette page.</p><p><a href=\"/listemeso\">Accéder à la liste des mésocycles</a>"})


def CreerCalModifMeso(meso):
	periode = meso.periode
	joursEnt = meso.mesocycleentrainement_set.order_by('jour')
	entrainements = Entrainement.objects.all()

	monthRange = calendar.monthrange(periode.year, periode.month)
	nbJours = monthRange[1]
	premierJourSemaine = monthRange[0]

	# Pour Python, une semaine commence le lundi...
	if premierJourSemaine == 6:
		premierJourSemaine = 0
	else:
		premierJourSemaine += 1

	nbRangees = int(math.ceil((premierJourSemaine + nbJours) / 7.0))
	rangees = []

	jour = datetime.date(periode.year, periode.month, 1)
	i = 0

	for rangee in xrange(0, nbRangees):
		chaine = ''
		jourSemaine = 0

		if rangee == 0 and premierJourSemaine > 0:
			chaine += '<td colspan="' + str(premierJourSemaine) + '" class="vide"/>'
			jourSemaine = premierJourSemaine

		while jourSemaine < 7 and jour.month == periode.month:
			chaine += '<td headers="' + str(rangee+1) + '"><span>' + str(jour.day) + '</span><select name="ent-j' + str(jour.day) + '"><option value="0">&nbsp;</option>'

			for entrainement in entrainements:
				chaine += '<option value="' + str(entrainement.id)+ '"'
				try:
					if joursEnt[i].jour == jour and joursEnt[i].entrainement == entrainement:
						chaine += ' selected="selected"'
						i += 1
				except IndexError:
					pass
				chaine += '>#' + str(entrainement.id) + ' – ' + entrainement.nom + '</option>'

			chaine += '</select></td>'
			jour += datetime.timedelta(days=1)

			if rangee == nbRangees - 1 and jour.month != periode.month and jourSemaine < 6:
				chaine += '<td colspan="' + str(6 - jourSemaine) + '" class="vide"/>'

			jourSemaine += 1

		rangees.append(chaine)

	return rangees

@login_required
def meso(request):
	mois = ["Janvier","Février","Mars","Avril","Mai","Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"]
	jour = datetime.datetime.now()
	try :
		meso = request.user.athlete.groupe.mesocycle_set.get(nom=mois[jour.month-1] + " " + str(jour.year))
	except Mesocycle.DoesNotExist:
		raise Http404
	except AttributeError:
		raise Http404
	try:
		mesoent = MesocycleEntrainement.objects.filter(mesocycle=meso).order_by('jour')
	except Exception, e:
		raise Http404
	listEnt = []

	for elem in mesoent:
		ent = elem.entrainement
		acts = EntrainementActivite.objects.filter(entrainement=ent.id)
		listAct = []
		for act in acts:
			listAct.append(act.activite)
			pass
		listEnt.append((elem.jour, ent.formatHTML(listAct)))
		pass

	return render(request, 'myTrainer/mesocycle.html',{'cal':CreerCalendrier(listEnt, meso)})

#fonction qui cree le calendrier en HTML et insere les entrainements
#normalement ma fonction ne devrait pas avoir autant de lignes , j'ai multiple les append pour vous faciliter la tache si jamais vous desirez changer ce code
def CreerCalendrier(ents, meso):
	chaine = []
	jour = ["l","ma","me","j","v","s","d"]
	dateDebut = meso.periode.weekday()

	chaine.append("<table border=\"1\"> <caption>" + meso.nom + "</caption> <thead> <tr>")
	chaine.append("<th id=\"l\">Lundi</th>")
	chaine.append("<th id=\"ma\">Mardi</th>")
	chaine.append("<th id=\"me\">Mercredi</th>")
	chaine.append("<th id=\"j\">Jeudi</th>")
	chaine.append("<th id=\"v\">Vendredi</th>")
	chaine.append("<th id=\"s\">Samedi</th>")
	chaine.append("<th id=\"d\">Dimanche</th>")
	chaine.append("</tr> </thead> <tbody> <tr>")

	casecount = 0
	for x in xrange(0, dateDebut):
		chaine.append("<td></td>")
		casecount += 1
		pass

	daycount = 1
	while len(ents) > 0:
			if casecount == 7:
				chaine.append("</tr><tr>")
				casecount=1
			else:
				casecount+=1
				pass

			if ents[0][0].day == daycount:
				chaine.append("<td headers=\"" + jour[casecount-1] + "\">")
				chaine.append("<p>" + str(daycount) + "</p>")
				chaine.append("<p>" + ents[0][1] + "</p>")
				chaine.append("</td>")
				del ents[0]
			else:
				chaine.append("<td headers=\"" + jour[casecount-1] + "\"><p>"+ str(daycount) + "</p></td>")
				pass
			daycount += 1
			pass
	chaine.append("</tr> </tbody> </table>")
	return ''.join(chaine)
