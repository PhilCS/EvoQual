# coding=utf-8
# Programmeur:	Philippe Carpentier-Savard
from django.db import models
from django import forms
from django.conf import settings
from django.contrib.auth.models import User
from django.db.models.signals import post_save
import calendar
import datetime
import locale
import re

class Activite(models.Model):
    type = models.CharField(max_length=45)
    duree = models.TimeField(null=True)
    distance = models.PositiveSmallIntegerField(null=True)
    VAM = models.PositiveSmallIntegerField(null=True)

    def __unicode__(self):
        return self.type

class Groupe(models.Model):
    nom = models.CharField(max_length=45)
    coach = models.OneToOneField('Coach')

    def __unicode__(self):
        return self.nom

class Athlete(models.Model):
    user = models.OneToOneField(User, primary_key=True)
    nom = models.CharField(max_length=60)
    groupe = models.ForeignKey(Groupe, null=True)
    VAM =  models.PositiveSmallIntegerField(null=True)

    def __unicode__(self):
        return self.nom

class Coach(models.Model):
    user = models.OneToOneField(Athlete, primary_key=True)

class Entrainement(models.Model):
    nom = models.CharField(max_length=60)
    repetition = models.PositiveSmallIntegerField(null=True)
    series = models.PositiveSmallIntegerField(null=True)
    repos = models.TimeField(null=True)
    activites = models.ManyToManyField(Activite, through='EntrainementActivite')

    def __unicode__(self):
        return self.nom

    def formatHTML(self, acts):
        chaine = []
        if self.series > 1:
            chaine.append(str(self.series) + "*")
            chaine.append("<br/>")
        if self.repetition > 1:
            chaine.append(str(self.repetition) + "*")
        if len(acts) == 0:
            return ''
        elif len(acts) < 2:
            if acts[0].duree is None and acts[0].distance is None:
                chaine.append("Continu lent")
            else:
                chaine.append(self.activiteFormat(acts[0]))
                pass

            chaine.append(self.ajouterVAM(acts[0], False))
        elif len(acts) < 3:
            #training simple
            chaine.append(self.activiteFormat(acts[0]))
            chaine.append("/")
            chaine.append(self.activiteFormat(acts[1]))
            chaine.append(self.ajouterVAM(acts[0], False))
        else:
            #training complexe
            if len(chaine) > 0:
                chaine.append("<br/>")
            for index in xrange(0, len(acts),2):
                chaine.append(self.activiteFormat(acts[index]))
                chaine.append("/")
                chaine.append(self.activiteFormat(acts[index+1]))
                chaine.append(self.ajouterVAM(acts[index], False))
                chaine.append(self.ajouterVAM(acts[index+1], True))
                chaine.append("<br/>")
                pass
        chaine.append(self.ajouterReposEnt())
        return ''.join(chaine)

    #retourne la string d'affichage d'une activite
    def activiteFormat(self, act):
        if act.distance is None:
            if act.duree.minute > 0:
                chaine = str(act.duree.minute) + "'"
            if act.duree.second > 0:
                chaine += str(act.duree.second) + "''"
            return chaine
        else:
            return str(act.distance)

    def ajouterReposEnt(self):
        if self.repos is not None:
            chaine = "<br/>"
            if self.repos.minute > 0:
                chaine += str(self.repos.minute) + "'"
            if self.repos.second > 0:
                chaine += str(self.repos.second) + "''"
            return chaine
        else:
            return ''

    #retourne la VAM a afficher
    #TODO au lieu d'afficher un % de VAM vous devez afficher la duree ou la distance cible selon la VAM du membre
    def ajouterVAM(self, act, repos):
        if act.VAM is None:
            return ''
        else:
            if repos:
                return "/" + str(act.VAM) + "%"
            else:
                return " - " + str(act.VAM) + "%"
                pass
            pass


class Mesocycle(models.Model):
    nom = models.CharField(max_length=45)
    periode = models.DateField()
    groupe = models.ForeignKey(Groupe)
    public = models.BooleanField()
    entrainements = models.ManyToManyField(Entrainement, through='MesocycleEntrainement')

    def __unicode__(self):
        return self.nom

class MesocycleEntrainement(models.Model):
    entrainement = models.ForeignKey(Entrainement)
    mesocycle = models.ForeignKey(Mesocycle)
    jour = models.DateField()

class EntrainementActivite(models.Model):
    entrainement = models.ForeignKey(Entrainement)
    activite = models.ForeignKey(Activite)
    ordre = models.PositiveSmallIntegerField()

class EntrainementAthlete(models.Model):
    seance = models.ForeignKey(MesocycleEntrainement)
    athlete = models.ForeignKey(Athlete)
    fait = models.BooleanField()

class InvitationGroupe(models.Model):
    user = models.OneToOneField(Athlete, null=True)
    courriel = models.CharField(max_length=45)
    groupe = models.ForeignKey(Groupe)
    date_envoi = models.DateTimeField()

class Records(models.Model):
    athlete = models.ForeignKey(Athlete)
    activite = models.ForeignKey(Activite)
    duree = models.TimeField(null=True)
    distance = models.PositiveSmallIntegerField(null=True)

#Formulaire inscription
class AthleteForm(forms.Form):
    type_compte = forms.ChoiceField(widget=forms.RadioSelect(), label="Type de compte", choices=((1, 'Athlète'), (2, 'Entraîneur')), initial='1')
    nom = forms.CharField(max_length=60)
    courriel = forms.EmailField(max_length=60)
    motPasse = forms.CharField(widget=forms.PasswordInput, label="Mot de passe")
    VAM = forms.IntegerField(label="VAM")

    def clean_courriel(self):
        courriel = self.cleaned_data['courriel']
        if courriel and User.objects.filter(email=courriel).count() > 0:
            raise forms.ValidationError('Ce courriel est déjà utilisé, veuillez en choisir un autre.')
        return courriel

#Formulaire groupe
class GroupeForm(forms.Form):
    nom = forms.CharField(max_length=45)
    courriels = forms.CharField(help_text="Entrez une ou plusieurs adresses courriel, en les séparant par une virgule (,) (ex.: marise@hotmail.com, frank@gmail.com, etc.)")

    def clean_courriels(self):
        email_pattern = re.compile(r'(\S+?@[A-Za-z0-9-]+\.[A-Za-z0-9-\.]{2,})(?:,\s*|$)')
        adresses = re.findall(email_pattern, self.cleaned_data['courriels'])
        if len(adresses) == 0:
            raise forms.ValidationError('Vous devez entrer au moins une adresse courriel valide.')
        return adresses

#Formulaire création mésocycle
class MesoForm(forms.Form):
    lstMois = []
    for x in xrange(1, len(settings.NOM_MOIS)):
        lstMois.append(settings.NOM_MOIS[x])
    mois = forms.ChoiceField(choices=lstMois, error_messages = {'required': 'Ce champ est obligatoire'})

    lstAnnees = []
    annee = datetime.datetime.now().year
    for y in xrange(annee, annee+3):
        lstAnnees.append((y, y))
    annees = forms.ChoiceField(label="Année", choices=lstAnnees)
