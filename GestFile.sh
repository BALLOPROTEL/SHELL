#!/bin/bash
# Fonction qui affiche le menu
menu () {
  echo "Bienvenue dans le gestionnaire de fichiers en ligne de commande"
  echo "Veuillez choisir une option:"
  echo "1) Créer un fichier"
  echo "2) Créer un répertoire"
  echo "3) Afficher le contenu d'un fichier"
  echo "4) Afficher le contenu d'un répertoire"
  echo "5) Déplacer un fichier ou un répertoire"
  echo "6) Copier un fichier ou un répertoire"
  echo "7) Renommer un fichier ou un répertoire"
  echo "8) Supprimer un fichier ou un répertoire"
  echo "9) Rechercher un fichier ou un répertoire"
  echo "10) Compter le nombre de fichiers ou de répertoires"
  echo "11) Quitter le programme"
  echo -n "Choisissez une option entre 1 et 11: "
}
# Définir une fonction pour créer un fichier
creer_fichier () {
  read -p "Entrez le nom du fichier à créer: " nom_fichier
  touch $nom_fichier
  echo "Le fichier $nom_fichier a été créé avec succès."
}

# Définir une fonction pour créer un répertoire
creer_repertoire () {
  read -p "Entrez le nom du répertoire à créer: " nom_repertoire
  mkdir $nom_repertoire
  echo "Le répertoire $nom_repertoire a été créé avec succès."
}

# Définir une fonction pour afficher le contenu d'un fichier
afficher_fichier () {
  read -p "Entrez le nom du fichier à afficher: " nom_fichier
  if [ -f $nom_fichier ]; then
    cat $nom_fichier
  else
    echo "Le fichier $nom_fichier n'existe pas."
  fi
}

# Définir une fonction pour afficher le contenu d'un répertoire
afficher_repertoire () {
  read -p "Entrez le nom du répertoire à afficher: " nom_repertoire
  if [ -d $nom_repertoire ]; then
    ls $nom_repertoire
  else
    echo "Le répertoire $nom_repertoire n'existe pas."
  fi
}
# Fonction qui déplace un fichier ou un répertoire
deplacer () {
  echo -n "Entrez le chemin du fichier ou du répertoire à déplacer: "
  read source
  if [ -e "$source" ]; then # Vérifie si le fichier ou le répertoire existe
    echo -n "Entrez le chemin de destination: "
    read destination
    if [ -d "$destination" ]; then # Vérifie si le chemin de destination est un répertoire
      mv "$source" "$destination" # Déplace le fichier ou le répertoire
      echo "Le fichier ou le répertoire $source a été déplacé vers $destination"
    else
      echo "Le chemin de destination n'est pas un répertoire valide"
    fi
  else
    echo "Le fichier ou le répertoire $source n'existe pas"
  fi
}

# Fonction qui copie un fichier ou un répertoire
copier () {
  echo -n "Entrez le chemin du fichier ou du répertoire à copier: "
  read source
  if [ -e "$source" ]; then # Vérifie si le fichier ou le répertoire existe
    echo -n "Entrez le chemin de destination: "
    read destination
    if [ -d "$destination" ]; then # Vérifie si le chemin de destination est un répertoire
    echo "Le fichier $nom_fichier_destination existe déjà. Voulez-vous le remplacer ? (O/N)"
    read reponse
    if [[ "$reponse" != "O" ]]; then
      return
    fi
      cp -r "$source" "$destination" # Copie le fichier ou le répertoire avec l'option -r pour copier les sous-répertoires
      echo "Le fichier ou le répertoire $source a été copié vers $destination"
    else
      echo "Le chemin de destination n'est pas un répertoire valide"
    fi
  else
    echo "Le fichier ou le répertoire $source n'existe pas"
  fi
}

# Fonction qui renomme un fichier ou un répertoire
renommer () {
  echo -n "Entrez le chemin du fichier ou du répertoire à renommer: "
  read source
  if [ -e "$source" ]; then # Vérifie si le fichier ou le répertoire existe
    echo -n "Entrez le nouveau nom: "
    read nouveau_nom
    mv "$source" "$nouveau_nom" # Renomme le fichier ou le répertoire
    echo "Le fichier ou le répertoire $source a été renommé en $nouveau_nom"
  else
    echo "Le fichier ou le répertoire $source n'existe pas"
  fi
}

# Fonction qui supprime un fichier ou un répertoire
supprimer () {
  echo -n "Entrez le chemin du fichier ou du répertoire à supprimer: "
  read source
  if [ -e "$source" ]; then # Vérifie si le fichier ou le répertoire existe
  # Demander confirmation
  echo "Voulez-vous vraiment supprimer le fichier $nom_fichier ? (O/N)"
  read reponse
  if [[ "$reponse" != "O" ]]; then
    return
  fi
    rm -r "$source" # Supprime le fichier ou le répertoire avec l'option -r pour supprimer les sous-répertoires
    echo "Le fichier ou le répertoire $source a été supprimé"
  else
    echo "Le fichier ou le répertoire $source n'existe pas"
  fi
}

# Fonction qui recherche un fichier ou un répertoire par son nom
rechercher () {
  echo -n "Entrez le nom du fichier ou du répertoire à rechercher: "
  read nom
  find . -name "$nom" # Recherche dans le répertoire courant et ses sous-répertoires le fichier ou le répertoire qui correspond au nom
}

# Fonction qui compte le nombre de fichiers ou de répertoires
compter () {
  echo -n "Entrez le chemin du répertoire à compter: "
  read repertoire
  if [ -d "$repertoire" ]; then # Vérifie si le chemin est un répertoire
    nb_fichiers=$(find "$repertoire" -type f | wc -l) # Compte le nombre de fichiers dans le répertoire et ses sous-répertoires avec l'option -type f
    nb_repertoires=$(find "$repertoire" -type d | wc -l) # Compte le nombre de répertoires dans le répertoire et ses sous-répertoires avec l'option -type d
    echo "Le répertoire $repertoire contient $nb_fichiers fichiers et $nb_repertoires répertoires"
  else
    echo "Le chemin $repertoire n'est pas un répertoire valide"
  fi
}

# Boucle principale du programme
while true; do # Boucle infinie
  menu # Affiche le menu
  read choix # Lit le choix de l'utilisateur
  case $choix in # Selon le choix de l'utilisateur
    1) creer_fichier ;; # Appelle la fonction creer_fichier
    2) creer_repertoire ;; # Appelle la fonction creer_repertoire
    3) afficher_fichier ;; # Appelle la fonction afficher_fichier
    4) afficher_repertoire ;; # Appelle la fonction afficher_repertoire
    5) deplacer ;; # Appelle la fonction deplacer un fichier ou un repertoire
    6) copier ;; # Appelle la fonction copier un fichier ou un repertoire
    7) renommer ;; # Appelle la fonction renommer un fichier ou un repertoire
    8) supprimer ;; # Appelle la fonction supprimer un fichier ou un repertoire
    9) rechercher ;; # Appelle la fonction rechercher un fichier ou un repertoire 
    10) compter ;; # Appelle la fonction compter un fichier ou un repertoire
    11) break ;; # Sort de la boucle infinie
    *) echo "Option invalide" ;; # Affiche un message d'erreur si l'option n'est pas valide
  esac
done

echo "Au revoir"