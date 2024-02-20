NOMA (Non-Orthogonal Multiple Access) est une technique de multiple access qui permet à plusieurs utilisateurs de partager le même spectre de fréquences en utilisant des ressources non orthogonales. Dans le contexte de ce code, l'allocation de puissance différentiée aux utilisateurs peut être considérée comme une forme de NOMA, où différents utilisateurs ont des niveaux de puissance différents, ce qui leur permet de partager efficacement le même canal de transmission. Les codes fournis simulent le fonctionnement d'un système de communication multi-utilisateurs, où des techniques telles que l'estimation du canal et l'allocation de puissance sont cruciales pour améliorer les performances du système, ce qui est également pertinent dans le contexte de NOMA.

**Objectif** :
Les codes fournis sont une implémentation MATLAB d'un système de communication multi-utilisateurs utilisant une modulation QAM (Quadrature Amplitude Modulation), un codage convolutif, et des techniques d'allocation de puissance. L'objectif principal est de simuler le processus de transmission et de réception dans un environnement multi-utilisateurs, en tenant compte des effets du canal et du bruit.

**Fonctionnement** :
1. **Configuration du système** :
   - La fonction `txConfig` initialise les paramètres du système tels que le nombre d'utilisateurs, le taux de codage, le type de modulation, etc.

2. **Transmission en liaison montante** :
   - La fonction `UplinkTx` réalise la modulation OFDM des séquences de Zadoff-Chu pour chaque utilisateur. Ces séquences sont utilisées comme signal de référence pour l'estimation du canal.

3. **Estimation du canal de liaison montante** :
   - La fonction `UplinkRx` estime le canal de transmission en utilisant les séquences de Zadoff-Chu reçues et les compare aux séquences transmises.

4. **Génération des données et transmission** :
   - Des données aléatoires sont générées pour chaque utilisateur et transmises après encodage et modulation, en tenant compte de l'allocation de puissance.

5. **Canal de transmission** :
   - Un canal de transmission avec un rapport signal sur bruit spécifié est simulé pour chaque utilisateur.

6. **Réception et décodage** :
   - Les données reçues sont décodées à l'aide du décodeur de canal convolutionnel et les erreurs de transmission sont calculées.
---
**Agencement des codes** :
Les différents scripts sont organisés de manière à refléter le flux de données dans un système de communication typique :
- **Transmitter** (Émetteur) : Génère et traite les données à transmettre.
- **Receiver** (Récepteur) : Reçoit et décode les données transmises.
- **Channel Coding** (Codage de canal) : Effectue le codage de canal des données avant la transmission.
- **Channel Decoding** (Décodage de canal) : Décodage des données reçues après la réception.
- **UplinkTx** et **UplinkRx** : Gèrent respectivement la transmission et la réception dans la liaison montante, en particulier l'estimation du canal.
- **MainSystem** : Le script principal qui orchestre l'ensemble du processus de transmission et de réception, en utilisant les fonctions définies précédemment.
