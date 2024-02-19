# Simulation d'un systeme de transmission numérique sur matlab

Ce projet vise à simuler la couche physique d'un protocole de communication, correspondant au niveau 1 du modèle OSI, en utilisant le logiciel MATLAB® de MathWorks®. L'objectif est de prendre en compte plusieurs émetteurs et récepteurs pouvant communiquer simultanément, en utilisant le multiplexage fréquentiel.

## Contenu du Projet

Le projet est constitué des fichiers suivants :

### 1. `main.m`

Ce fichier lance les scripts de simulation dans un ordre logique et affiche une comparaison entre le signal émis et le signal recomposé par le récepteur.

### 2. `parameters.m`

Ce fichier permet de configurer les paramètres de simulation, tels que le nombre de canaux fréquentiels disponibles, la taille du message à envoyer et la vitesse d'envoi.

### 3. `sender.m`

Ce script génère les données aléatoirement et les sépare fréquentiellement pour l'envoi.

### 4. `channel.m`

Ce script simule les effets du canal de communication, notamment l'atténuation des amplitudes, le décalage temporel et l'ajout de bruit.

### 5. `receiver.m`

Ce script démodule les signaux reçus et tente de recomposer le signal émis, prenant des décisions sur les valeurs mesurées à intervalles de temps.

## Fonctionnement de la Simulation

1. Le fichier `main.m` lance les scripts dans l'ordre suivant : `parameters.m` → `sender.m` → `channel.m` → `receiver.m`.
2. Le script `sender.m` génère une séquence de bits aléatoires.
3. Le script `channel.m` simule les effets du canal de communication, tels que l'atténuation, le décalage temporel et le bruit.
4. Le script `receiver.m` démodule les signaux reçus et tente de recomposer le signal émis.
5. Une figure est générée pour comparer le signal émis et le signal recomposé.

## Notes

- Les paramètres de simulation peuvent être configurés dans le fichier `parameters.m`.
- La simulation peut être lancée en exécutant le fichier `main.m` dans MATLAB.

## Auteur

Ce projet a été réalisé par Daniel Djikpesse.

--- 
