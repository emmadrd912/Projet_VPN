# Projet infra
## Routeur
Pour répondre a la demande nous avons mis en place une infrastructure avec deux LAN. le LAN1 (192.168.3.1/24) comportant le réseau interne de l'entreprise, un vpn et un serveur de fichier interne a l'entreprise puis un portail captif pour permettre que seul les utilisateurs authentifié puisse aller sur l'internet. Le LAN2 (192.168.4.1/24) Comportant le site web de l'entreprise. Pour le router nous avons choisi PfSense sur lequel il y a HAproxy pour permettre de faire du load balancing sur les serveurs web de l'entreprise et un un reverse proxy.
## Schéma d'infra
![picture](/image/Connexion.PNG)
