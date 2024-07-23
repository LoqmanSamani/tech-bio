#Aufgabe 1
#a) Graeco-Latin Square
#b)
summary(aov(yield~time+catalyst+batch+acid, data=benzol))
#c) 25 (5*5), d.h. genauso viele

#Aufgabe 2
#a) RCB
#b) Vorsicht! "brand" wird als numerisch eingelesen, daher zuerst in Faktor umwandeln:
Battery <- within(Battery, brand <- factor(brand))
# dann ANOVA durchführen. Ergebnis: ex gibt einen Effekt von type (p = 0.0326):
summary(aov(cycle~type+brand, data=Battery))
#c) Nein:
summary(aov(cycle~type, data=Battery))

#Aufgabe 3
#a) Latin Square
#b) car und driver:
summary(aov(fuel~addon+car+driver, data=FuelUse))
#c) Wahrscheinlich nicht, weil driver die größte Varianzquelle ist

#Aufgabe 4
#a) Split Plot mit "cell" als whole und "cycline" als sub plot
#b) CDKI: Ja; Zell-Linien: Nein
summary(aov(cycle~cdki*cell+Error(Exp/cell), data=CDKI))
#c) CDKI7:
model.tables(aov(cycle~cdki*cell+Error(Exp/cell), data=CDKI), type="means")

#Aufgabe 5
#a) 2³
#b) mit zwei Levels für 3 Faktoren ist nur ein RCB möglich, bei dem Blöcke (Wochen) ind Blöcken (Standaorten) angelegt werden
#c) A*B*C

#Aufgabe 6
#a) Split Block:
'Die samples werden  nicht zufälig angelegt, sondern eines nach dem anderen wird aufgearbeitet;
samples sind also mit Experiment überlagert'
'Die Maschinen werden zwar in jeder Woche verwendet, aber es sind in den beiden Wochen keine 
unabhängigen Geräte: es gibt nur je eine Maschine pro Typ; also sind auch die Maschinen verschachtelt in Woche'
#b) Code:
summary(aov(cycles~sample*machine+Error(week/(sample*machine)), data=pcr))
#c) Die Entscheidung ist schwierig, da es eine Interaktion von Machine mit Sample gibt. 
'Note: eine Beurteilung von machine ist mit diesem Design nicht möglich!'

