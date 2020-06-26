Prefix AST
==
Description
--
Implementarea unui program ce evalueaza o expresie prefixata
        stocata intr-un AST.
Usage
--
* Checker: **./checker.py**
 

Dependencies
--


Implementation
--
##### Application flow:  
Am parcurs arborele recursiv utilizand o functie, conditia de oprire fiind  
ajungerea intr-un nod in care se afla stocat un semn iar ambii copii, atat  
stanga cat si dreapta sunt frunze (frunzele fiind in toate cazurile numere)  
iar apoi rezultatul obtinut il stochez pe stiva ca mai apoi sa fie utilizat  
la revenirea din apelul recursiv. La fiecare apel recursiv mai retin pe stiva  
si valorile nodurilor din stanga si dreapta ca mai apoi sa fie folosite  
pentru comparatia la intoarcerea din apelul recursiv.  

Am mai utilizat si o functie auxiliara de atoi, implementata de mine, atat  
pentru numere negative cat si pozitive.  
