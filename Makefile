# if "thought" exists, you can update the maybe-not-extant "talking" this way

talking : thought
	cat thought >> talking
	echo "no seriously" >> talking
	cat thought >> talking

main.o : talking
	echo talking

clean :
	rm thought
