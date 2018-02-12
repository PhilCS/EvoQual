from django.contrib import admin
from training.models import Activite, Athlete, Coach, Entrainement, EntrainementActivite, EntrainementAthlete, Groupe, InvitationGroupe, Mesocycle, MesocycleEntrainement, Records

admin.site.register(Activite)
admin.site.register(Athlete)
admin.site.register(Coach)
admin.site.register(Entrainement)
admin.site.register(EntrainementActivite)
admin.site.register(EntrainementAthlete)
admin.site.register(Groupe)
admin.site.register(InvitationGroupe)
admin.site.register(Mesocycle)
admin.site.register(MesocycleEntrainement)
admin.site.register(Records)
