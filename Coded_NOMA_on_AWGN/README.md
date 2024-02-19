# Simulation de Codage Non-Orthogonal Multiple Access (NOMA) avec Démodulation BPSK

Ce projet vise à simuler un système de communication utilisant le codage NOMA (Non-Orthogonal Multiple Access) et la modulation BPSK (Binary Phase Shift Keying) dans un canal AWGN (Additive White Gaussian Noise). Le projet est implémenté en MATLAB® et comprend les fichiers suivants :

## Fichiers MATLAB

### 1. `Coded_NOMA_BER_AWGN.m`

Ce fichier effectue la simulation principale du système de communication NOMA. Voici un aperçu de ce qu'il réalise :

- Il génère des données binaires aléatoires pour plusieurs utilisateurs.
- Il effectue une modulation BPSK des données.
- Il réalise un codage superposition en combinant les signaux modulés.
- Il simule le canal de communication en ajoutant du bruit blanc gaussien.
- Il décode les signaux reçus pour récupérer les données binaires originales.
- Il compare les données décodées avec les données transmises pour calculer le taux d'erreur binaire (BER) simulé.
- Il trace les courbes de BER simulées et théoriques en fonction du rapport signal-sur-bruit (SNR).

### 2. `decoded1.m`, `decoded2.m`, `decoded3.m`

Ces fichiers contiennent les fonctions de décodage pour chaque utilisateur. Chaque fonction prend en entrée les signaux reçus et renvoie les données binaires décodées pour un utilisateur spécifique.

### 3. `encoder1.m`, `encoder2.m`, `encoder3.m`

Ces fichiers contiennent les fonctions d'encodage pour chaque utilisateur. Chaque fonction prend en entrée les données binaires de l'utilisateur correspondant et génère les signaux modulés pour le codage superposition.

## Comment Utiliser

1. Assurez-vous que tous les fichiers MATLAB sont dans le même répertoire.
2. Exécutez le fichier `Coded_NOMA_BER_AWGN.m` dans MATLAB.
3. Observez les courbes de BER simulées et théoriques pour évaluer les performances du système NOMA dans le canal AWGN.

## Remarque

- Vous pouvez ajuster les paramètres de simulation, tels que le nombre de monte-carlo, la plage SNR, et les poids de puissance des utilisateurs, dans le fichier `Coded_NOMA_BER_AWGN.m` selon vos besoins.

Ce projet a été réalisé dans le cadre de l'étude des systèmes de communication avancés et de la modulation numérique. Il permet de mieux comprendre les concepts de codage superposition et de communication NOMA dans des environnements de canal bruités.

Cette simulation et basé sur cette publication : https://www.radioeng.cz/fulltexts/2024/24_01_0045_0053.pdf

Daniel djikpesse
