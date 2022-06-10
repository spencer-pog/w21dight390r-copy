for token in taught walks;
do
	echo ${token} | hfst-lookup -q ana.hfstol
done

for reading in teach+V+Past walk+V+Pres+3Sg
do
	echo ${reading} | hfst-lookup -q gen.hfstol
done
