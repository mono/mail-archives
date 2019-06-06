#! /bin/bash

LOW=200
HIGH=205

function create_iface () {
	COUNT=$1
	echo "public interface Iface_$COUNT {"
	for i in `seq 1 $COUNT`;
	do
		echo "	int Method_$i ();"
	done 
	echo "}"
	echo
}


function create_impl () {
	COUNT=$1
	echo "public class Impl_$COUNT : Iface_$COUNT {"
	for i in `seq 1 $COUNT`;
	do
		echo "	public int Method_$i () { return ${i}; }"
	done 
	echo "}"
	echo
}


function create_static_part () {
	IFACE=$1
	echo "	static Iface_$IFACE var_$IFACE = new Impl_$IFACE ();"
	echo "	static void Test_$IFACE () {
		int r;
	"

	for i in `seq 1 $IFACE`;
	do	
		echo "		if ((r = var_${IFACE}.Method_$i ()) != ${i})
			Console.WriteLine(\"iface $IFACE method $i returned {0}\", r);"

	done

	echo "	}"
}


function test_iface () {
	IFACE=$1
	echo "		Test_$IFACE ();"
}


####Part that split the output

echo "using System;

"

for i in `seq $LOW $HIGH`;
do
	create_iface $i
	create_impl $i
done



echo "
public class Driver
{
"


for i in `seq $LOW $HIGH`;
do
	create_static_part $i
done


echo "
	public static int Main ()
	{"


for i in `seq $LOW $HIGH`;
do
	test_iface  $i
done


echo "		return 0;
	}
}"


