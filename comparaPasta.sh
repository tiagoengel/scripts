#!/bin/bash

# TITULO: Programa em bash para comparar pastas
# DATA: 28/Jan/2009
#
# Programa em bash para comparar recursivamente duas pastas
# - informa quais arquivos tem em uma e que nao tem em outra
# - quais subpastas tem em uma que nao tem em outra
# - se houverem arquivos com mesmo nome em uma pasta e na outra,
#   informa se eles sao iguais ou diferentes
#
# Atendendo pergunta do forum Viva o Linux:
# http://www.vivaolinux.com.br/topico/Shell-Script/Comparar-arquivos-de-uma-pasta-com-arquivos-de-outra-pasta
#
# Elgio Schlemer


# Se faltou parametros, este help eh executado
function sintaxe ()
{

	cat  << END
Forma de uso:

$0 <pasta1> <pasta2>

pasta1 e pasta2 devem ser diretorios existentes e com permissao de leitura
END

}

# testa se os parametros sao dir (devem ser) e se podem ser abertos
function testa ()
{
	if [ "$#" != 2 ]
	then 
		printf "%${espaco}sERRO. Deve informar 2 pastas\n" ""
		return 1
	fi

	for d in $*
	do 
		if [ ! -d $d ]
		then
			printf "%${espaco}sERRO. '$d' nao eh um diretorio\n" ""
			return 1
		fi

		if [ ! -x $d ]
		then
			printf "%${espaco}sERRO. '$d' nao tem permissao de acesso\n" ""
			return 1
		fi
		if [ ! -r $d ]
		then
			printf "%${espaco}sERRO. '$d' nao tem permissao de leitura\n" ""
			return 1
		fi

	done
		
	return 0
}

# Compara todos os arquivos de uma pasta com outra pasta
# se encontrar uma subpasta, chama-se recursivo para compara-las tambem
function compara()
{
	# Este IFS eh util para lidar com (SIC) arquivos com espacos em branco
	IFS="\n"

	for arq in $1/*
	do
		nome="`basename "$arq"`"
		if [ -d "$arq" ]
		# Se eh um diretorio, chama recursivo
		then
			printf "\n%${espaco}sComparando pasta '$1/$nome' com '$2/$nome'\n" ""
			espaco=$(( $espaco + 4));
			export espaco

			if testa "$1/$nome" "$2/$nome"
			then 
				compara "$1/$nome" "$2/$nome"				
			fi
			espaco=$(( $espaco - 4))
			export espaco

			continue
		fi
	
		if [ -f "$arq" ] # se arquivo
		then
			if [ ! -f "$2/$nome" ]
			then
				printf "%${espaco}sarquivo '$nome' em '$1' mas nao em '$2'\n" ""
				continue
			fi
			if  `diff -q "$1/$nome" "$2/$nome" 2>&1 > /dev/null`
			then
				printf "%${espaco}sOK com '$1/$nome' e '$2/$nome'\n" ""
			else
				printf "%${espaco}s'$1/$nome' e '$2/$nome' sao diferentes\n" ""
			fi

		fi

	done

	for arq in $2/*
	do
		nome="`basename "$arq"`"
		if [ -d "$arq" ]
		then
			# Se eh um dir, na pasta $1 deve ter o mesmo dir
			if [ -d "$1/$nome" ]
			then
				continue # se tem, pula. Ja foram comparadas na etapa anterior
			else 
				printf "%${espaco}sERRO. '$nome' nao existe na pasta '$1' como diretorio\n" ""
				continue
			fi
		fi
		if [ -f "$arq" ]
		then
			if [ -f "$1/$nome" ]
			then
				continue
			else
				printf "%${espaco}sERRO. '$nome' nao existe na pasta '$1' como arquivo\n" ""
			fi
		fi
	done
}

# espaco eh usado para dar uma identacao nas mensagens
espaco=4
export espaco

# Programa principal
if ! testa $* 
then
	sintaxe $0
	exit 1
fi

printf "Comparando pasta '$1' com '$2'\n"
compara $1 $2

