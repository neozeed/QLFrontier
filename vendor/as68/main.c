
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

/*
 * Version 1.1 contains fixes for referencing the usc = calld ccr registers
 * and not exiting if the -V switch is specified. format specifications for
 * move sr, ?? and usp moves were incorrect -- fixed. added aliasing for
 * immediate operations to sr and ccr.
 *
 * Version 1.2 contains changes for minix: input compatibility with ack,
 * including short absolute addressing mode and explicit pc-relative addressing
 * mode involving text labels, and smarter use of memory.
 */

#include "jas.h"

#include "proto.h"

#ifdef VMS
#define unlink delete
#endif

#ifdef DOS_LIKE
#include <io.h>
#endif

#define VERSION	2
#define RELEASE 0

jmp_buf err_buf;

extern int sawerror;

char *ofile = NULL;
char *ifile = NULL;

int Optimize = 1;
int Lflag = 0;
int flag8 = 0;
extern FILE *yyin;

#ifdef	QDOS
#include <qdos.h>
long _stack = 20 * 1024L;
long _stackmargin = 1024L;
char _prog_name[] = "as68";
char _version[] = "v2.4";
void (*_consetup)() = consetup_title;
long (*_writetrans)() = NULL;
#endif /* QDOS */

void warn(n, s)
	int n;
	char *s;
{
#ifndef QDOS
	fprintf(stderr,"AS68: ");
#else
	fprintf(stderr,"jas: ");
#endif
	if ( n )
		fprintf(stderr,"line %d: ", n);
	fprintf(stderr,"( %s )\n", s);
	sawerror = 1;
}

void error(n, s)
	int n;
	char *s;
{
	warn( n, s );
	longjmp( err_buf, 1 );
}

/* Modified 2026: ordinary owned streams; never reopen standard streams. */
static FILE *object_file;
static int object_created;

static void file_error(const char *operation, const char *path)
{
    fprintf(stderr, "AS68: %s '%s': %s\n", operation, path, strerror(errno));
    longjmp(err_buf, 1);
}

static void cleanup(void)
{
    if (yyin) { fclose(yyin); yyin = NULL; }
    if (object_file) { fclose(object_file); object_file = NULL; }
    if (object_created && ofile) remove(ofile);
}

int main(int argc, char *argv[])
{
    struct stat source_stat, object_stat;
    if (setjmp(err_buf)) {
        cleanup();
        return 1;
    }
    setflags(argc, argv);
    yyin = fopen(ifile, "rb");
    if (!yyin) file_error("cannot open source", ifile);
    /* Reject aliases before opening the destination with truncation. */
    if (!stat(ifile, &source_stat) && !stat(ofile, &object_stat) &&
        source_stat.st_dev == object_stat.st_dev &&
        source_stat.st_ino == object_stat.st_ino)
        error(0, "source and object refer to the same file");
    object_file = fopen(ofile, "wb");
    if (!object_file) file_error("cannot open object", ofile);
    object_created = 1;
#ifdef QDOS
    {
        struct qdirect header;
        if (fs_headr(fgetchid(object_file),-1,&header,14) == 14) {
            header.d_type = QF_RELOC_TYPE;
            fs_heads(fgetchid(object_file),-1,&header,14);
        }
    }
#endif
    aspass1();
    if (ferror(yyin)) file_error("cannot read source", ifile);
    if (fclose(yyin)) {
        yyin = NULL;
        file_error("cannot close source", ifile);
    }
    yyin = NULL;
    if (fclose(object_file)) {
        object_file = NULL;
        file_error("cannot close object", ofile);
    }
    object_file = NULL;
    if (sawerror) { cleanup(); return 1; }
    object_created = 0;
    return 0;
}

char * allocate(unsigned long size)
{
        char *loc;

	loc = calloc( size, 1 );
#ifdef MEM_DEBUG
	fprintf( stderr, "alloc(%u bytes) => %lx\n", size, loc );
#endif
	if ( loc ) {
		return loc;
	}
	error( 0, "out of memory" );
	return (char *) NULL;
}

char *
myreallocate(ptr, size)
	char *ptr;
        unsigned long size;
{
	register char *loc;

	loc = realloc( ptr, size );
	if ( loc ) {
		return loc;
	}
	error( 0, "out of memory" );
	return (char *) NULL;
}

void setflags(ac,av)
	int ac;
        char **av;
{
	int errflag = 0, i;
	int Vflag = 0;
	for ( i = 1; i < ac; i++ ) {
		if ( *av[i] == '-' ) {
			switch ( av[i][1] ) {
			case 'o':
				if (++i >= ac) { errflag = 1; break; }
				ofile = av[i];
				break;
			case 'N':
			case 'n':
				Optimize = 0;
				break;
			case 'V':
			case 'v':
				Vflag = 1;
				break;
			case 'L':
				Lflag = 1;
				if ( av[i][2] )
					Lflag = av[i][2] - '0';
				break;
			case 's':
				i++;
			case 'l':
			case 'u':
				break;
			case '8':
				flag8 = 1;
				break;
			default:
				errflag = 1;
				break;
			}
		} else if (! ifile ) {
			ifile = av[i];
                } else if (! ofile ) {
                        ofile = av[i];
		} else {
			errflag = 1;
		}
	}

	if ( Vflag ) {
		fprintf( stderr, "Sozobon Assembler, Version %d.%d\n",
							VERSION, RELEASE );
		fprintf( stderr, "Copyright (c) 1988,1991 by Sozobon, Limited\n" );
	}

	if (! ifile)
		errflag = 1;

	if ( errflag ) {
                fprintf( stderr, "usage: as68 [-N] source [-o object]\n" );
		exit( 1 );
	}

	if (! ofile ) {
        const char *base = strrchr(ifile, '/');
        size_t len;
        base = base ? base + 1 : ifile;
        len = strlen(base);
        if (len < 2 || strcmp(base + len - 2, ".s")) {
            fprintf(stderr, "AS68: use -o object for a source without .s suffix\n");
            exit(1);
        }
        ofile = STRCPY(base);
        ofile[len - 1] = 'o';
	}
}

void output( buffer, size, nitems )
	char *buffer;
	int size, nitems;
{
	if ( fwrite( buffer, size, nitems, object_file ) != nitems )
		error( 0, "trouble writing object file" );
}

#if defined (QDOS) || defined(XTC68)
/*
 * This is the bit that looks after the fact that 0xFB is used as
 *  a directive in SROFF, so in many cases it needs to be output as
 *  0xFBFB instead.
 */
void
output2fb(unsigned  char *buffer, int size, int nitems)
{

    register unsigned s;

    while ( nitems-- ) {
        for ( s=size ; s-- ; ) {
            if (*buffer == 0xfb) {
               fputc(*buffer, object_file);
            }
            /** 6/1/90 jcg */
            fputc(*buffer++, object_file);
            if (ferror(object_file)) {
#ifdef QDOS
                extern int errno, _oserr;
                fprintf (stderr, "errno=%d, _oserr=%d\n",errno,_oserr);
#endif
                error( 0, "trouble writing object file for 2fb" );
            }
        }
    }
    return;
}
#endif

#ifdef MEM_DEBUG

#ifdef free
#undef free
#endif

my_free( x )
	char *x;
{
fprintf( stderr, "free( %lx )\n", x );
	free( x );
}
#endif /* MEM_DEBUG */

