# Aufgabe 1
#a)
shapiro.test(mussel$Magadan)
#Voraussetzungen nicht erfüllt, da Magadan nicht normalverteilt
#b)
mst <- stack(log(mussel))
mst.aov <- aov(values~ind, data=mst)
#c)
library(agricolae)
HSD.test(mst.aov, "ind", group=T, console=T)

#Aufgabe 2
#a)
startup <- stack(startup)
#testen Sie zunächst, in welcher Reihenfolge die Faktor-level gelistet sind:
levels(startup$ind)
contrasts(startup$ind) <- c(1.5,1.5,-1,-1,-1)
contrasts(startup$ind)
startup.aov <- aov(values~ind, data=startup)
summary.aov(startup.aov,split=list(ind=list("food vs. non-food"=1)))
#b)
contrasts(startup$ind) <- c(1,1,1,1,-4)
startup.aov <- aov(values~ind, data=startup)
summary.aov(startup.aov,split=list(ind=list("pets vs. other"=1)))
#c)
summary(aov(values~ind, data=subset(startup, ind!="pets")))

#Aufgabe 3
#a)
summary(aov(Subjective_Valence~Item_Category+Error(Participant_ID/Item_Category), data=emotion))
#b)
# In der Aufgabe (b) wird nach einer two-way ANOVA gefragt. Hier hatten wir diskutiert, ob im Error-Term auch die Interaktion von 
# Item_Category und Emotion_Condition zu berücksichtigen ist. Während ich dies verneint habe, schlug Herr Beykoz vor, die Inter-
# aktion zu berücksichtigen. DIE LITERATUR GIBT HERRN BEYKOZ RECHT:
summary(aov(Subjective_Valence~Item_Category*Emotion_Condition+Error(Participant_ID/(Item_Category*Emotion_Condition)), data=emotion))
#c)
summary(aov(Subjective_Valence~Item_Category+Error(Participant_ID/Item_Categoty), data=subset(emotion, Emotion_Condition=="Negative" & Participant_Sex=="Female")))

#Aufgabe 4
#a)
# während Item_Category ein "within subject" Faktor ist (also innerhalb der Subjekte variiert wird), ist Geschlecht eine "between subjekt" Variable
# diese ist nicht in Participant_ID verschachtelt, DIE BERÜCKSICHTIGUNG IM ERROR-TERM HAT KEINEN EFFEKT:
summary(aov(Subjective_Valence~(Participant_Sex*Item_Category)+Error((Participant_ID/Item_Category)+Participant_Sex), data=emotion))
# ENTSPRICHT:
summary(aov(Subjective_Valence~(Participant_Sex*Item_Category)+Error(Participant_ID/Item_Category), data=emotion))
#b)
summary(aov(Subjective_Valence~(Participant_Sex*Emotion_Condition)+Error(Participant_ID/Emotion_Condition), data=emotion))
#c)
summary(aov(Subjective_Valence~(Participant_Sex*Emotion_Condition*Item_Category)+Error(Participant_ID/(Emotion_Condition*Item_Category)), data=emotion))

#Aufgabe 5
#a)
basket.lm = lm(points~height+weightclass+ratio, data=basketball)
library(car)
Anova(basket.lm)
#c)
Anova(lm(ratio~height+weightclass, data=basketball))
