
/*
 * Copyright (c) 1988,1991 by Sozobon, Limited.  Author: Joseph M Treat
 *
 * Permission is granted to anyone to use this software for any purpose
 * on any computer system, and to redistribute it freely, with the
 * following restrictions:
 * 1) No charge may be made other than reasonable charges for reproduction.
 * 2) Modified versions must be clearly marked as such.
 * 3) The authors are not responsible for any harmful consequences
 *    of using this software, even if they result from defects in it.
 */

#include "jas.h"

#include "proto.h"

#define SCTALIGN 2

long dottxt = 0L, dotdat = 0L, dotbss = 0L, newdot = 0L;
long uptxt, updat, upbss, txtsize, datsize, bsssize;

SYM dot;

void chsegmt(unsigned short segment)
{
	switch ( dot.flags & SEGMT ) {
	case TXT:
		dottxt = newdot;
		break;
	case DAT:
		dotdat = newdot;
		break;
	case BSS:
		dotbss = newdot;
		break;
	}

	switch ( segment & SEGMT ) {
	case TXT:
		newdot = dottxt;
		break;
	case DAT:
		newdot = dotdat;
		break;
	case BSS:
		newdot = dotbss;
		break;
	}

	dot.flags = segment;
	dot.value = newdot;
}

void aspass1(void)
{
	extern jmp_buf err_buf;
	extern int Optimize;

#if defined (QDOS) || defined (XTC68)
	long l;
#endif

	dot.flags = TXT;
	dot.value = newdot = 0L;

	yyinit();
	if ( yyparse() ) {
		longjmp( err_buf, 1 );
	}

	chsegmt(TXT);

	if ( Optimize )
		do_opt();

	txtsize = dottxt;
	if ( (uptxt = txtsize % SCTALIGN) != 0 )
		txtsize += (uptxt = SCTALIGN - uptxt);
	datsize = dotdat;
	if ( (updat = datsize % SCTALIGN ) != 0)
		datsize += (updat = SCTALIGN - updat);
	bsssize = dotbss;
	if ( (upbss = bsssize % SCTALIGN) != 0 )
		bsssize += (upbss = SCTALIGN - upbss);

/* don't adjust the segments ...
	fixsymval( 0L, txtsize, DAT );
	fixsymval( 0L, txtsize + datsize, BSS );
...  */

	bufhead();
	symindex();
	headers();
	dot.value = newdot = 0L;
#if !defined (QDOS) & !defined (XTC68)
	translate( TXT, (int) uptxt );

	translate( DAT, (int) updat );
	dumpsym();
	dumprel();
#else
	dumpsym();
    if (txtsize) {
    output(mklowlong(0xFB04FFFFUL), 4, 1);
        translate( TXT, (int) uptxt );
    }

    if (datsize)
    {

        output(mklowlong(0xFB04FFFEUL), 4, 1);
        translate( DAT, (int) updat );
    }

	/* Output SECTION BSS (if there is any) */
	if( bsssize ) {
          output(mklowlong(0xFB04FFFDUL), 4, 1);
          output(mklowshort(0xFB05), 2, 1);
          output2fb((unsigned char *)mklowlong(bsssize), 4, 1);
    }
    output(mklowshort(0xFB13), 2, 1);
#endif /* QDOS */
}
