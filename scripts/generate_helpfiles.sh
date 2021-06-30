#! /bin/bash

# function sed-get-between-duplicate() {
#     sed -n '/'$1'/,/'$1'/{/'$1'/b;/'$1'/b;p}' $2
# }
#
# for FAUSTFILE in "$(find . /usr/share/faust | grep "\.lib" )"; do
DATADIR=data
HELPDIR=doc
FAUSTLIB=/usr/share/faust

function detect_architecture(){
	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		# LINUX
		if [[ $(uname -m) == "x86_64" ]]; then
			ARCHICTECTURE="linux_amd64"
		else
			ARCHICTECTURE="linux_arm"
		fi
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		# MACOS
		ARCHICTECTURE="darwin_amd64" 
	elif [[ "$OSTYPE" == "cygwin" ]]; then
		ARCHICTECTURE="windows_amd64" 
	else
		echo "$OSTYPE unknown" && exit 1
	fi

}

function get_converter(){
	CFILE="md2vim_$ARCHICTECTURE.tar.gz"
	URL="https://foosoft.net/projects/md2vim/dl/$CFILE"
	CONVERTER=$DATADIR/${CFILE%.tar.gz}/md2vim

	if [[ -z "$CONVERTER" ]]; then
	wget $URL --directory-prefix=$DATADIR/ &&\
		tar -xvf $DATADIR/$CFILE --directory=$DATADIR/ && \
		rm $DATADIR/$CFILE
	else
			echo "Detected converter already exists: $CONVERTER"
	fi
}

function init(){
	mkdir -p $DATADIR

	detect_architecture && \
	get_converter && \
		faustlib2markdownfiles
}

function faustlib2markdownfiles(){
	FFILES=$(ls -a1 $FAUSTLIB | grep "\.lib")

	mkdir -p $HELPDIR
	mkdir -p $DATADIR/md

	for FAUSTFILE in $FFILES; do
		FAUSTMD="$DATADIR/md/${FAUSTFILE%.lib}.md"
		FAUSTHELPFILE="$HELPDIR/${FAUSTFILE%.lib}.txt"

		# Convert faust lib to markdown (sed command removes extranous ticks)
		faust2md "$FAUSTLIB/$FAUSTFILE"	| sed 's/`//g' > $FAUSTMD 

		# Call converter and create
		./$CONVERTER -desc="Faust library documentation" $FAUSTMD $FAUSTHELPFILE 

		# Create footer
		echo "vim:tw=78:ts=8:ft=help:norl:" >> $FAUSTHELPFILE

	done

}

init
