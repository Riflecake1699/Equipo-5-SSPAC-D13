//Banco de registros con los registros de t0 a s4 (8 a 20)
//recordar no usar el registro 0
sw		$t0, 0($zero)
sw		$t1, 1($zero)
sw		$t2, 2($zero)
sw		$t3, 3($zero)
sw		$t4, 4($zero)
sw		$t5, 5($zero)
sw		$t6, 6($zero)
sw		$t7, 7($zero)
sw		$s0, 8($zero)
sw		$s1, 9($zero)
sw		$s2, 10($zero)
sw		$s3, 11($zero)
sw		$s4, 12($zero)


SW $1, offset(base)  //x0
SW $2, offset(base)  //y0
SW $3, offset(base)  //z0
SW $4, offset(base)  //c0
SW $5, offset(base)  //x1
SW $6, offset(base)  //y1
SW $7, offset(base)  //z1
	SW $8, offset(base)  //c1
SW $9, offset(base)  //x2
SW $10, offset(base)  //y2
SW $11, offset(base)  //z2
SW $12, offset(base) //c2
