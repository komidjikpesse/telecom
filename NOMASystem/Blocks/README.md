**README - Fonctions fournies**

1. **txConfig** :
    - **Objectif** : Initialise les paramètres du système de communication, y compris le type de modulation, le taux de codage, la longueur des données, etc.
    - **Fonctionnement** : Cette fonction crée une structure de paramètres (`txParams`) contenant toutes les informations nécessaires pour configurer le système de communication.

2. **UplinkTx** :
    - **Objectif** : Réalise la modulation OFDM des séquences de Zadoff-Chu pour chaque utilisateur, utilisées comme référence pour l'estimation du canal.
    - **Fonctionnement** : Génère les séquences de Zadoff-Chu pour chaque utilisateur, les module avec OFDM, et renvoie le signal modulé pour la transmission.

3. **UplinkRx** :
    - **Objectif** : Estime le canal de transmission en utilisant les séquences de Zadoff-Chu reçues et les compare aux séquences transmises.
    - **Fonctionnement** : Réalise la démodulation OFDM des signaux reçus, estime le canal pour chaque utilisateur, et renvoie les estimations de canal.

4. **Transmitter** :
    - **Objectif** : Génère et traite les données à transmettre, y compris le codage de canal, la modulation QAM, et l'allocation de puissance.
    - **Fonctionnement** : Prend en entrée les données à transmettre, les encode, les module avec QAM, alloue la puissance aux utilisateurs, et renvoie le signal modulé pour la transmission.

5. **Receiver** :
    - **Objectif** : Reçoit et décode les données transmises, y compris le décodage de canal et la démmodulation QAM.
    - **Fonctionnement** : Reçoit le signal transmis, effectue la démodulation QAM, décode le signal avec le décodeur de canal, et renvoie les données décodées.

6. **channelDecoding** :
    - **Objectif** : Décode les données reçues après la réception, en utilisant un décodeur de canal convolutionnel.
    - **Fonctionnement** : Décode les données reçues à l'aide du décodeur de canal convolutionnel avec ou sans quantification, selon la configuration spécifiée.

7. **MainSystem** :
    - **Objectif** : Orchestrer l'ensemble du processus de transmission et de réception en utilisant les fonctions définies précédemment.
    - **Fonctionnement** : Initialise les paramètres du système, simule la transmission, la réception et le traitement des données, et affiche les résultats de la simulation.

Chaque fonction remplit un rôle spécifique dans le système de communication global et contribue à simuler différents aspects du processus de transmission et de réception.
