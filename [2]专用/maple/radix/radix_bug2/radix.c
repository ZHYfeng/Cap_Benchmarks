#line 228 "./null_macros/c.m4.null.POSIX"

#line 1 "radix.C"
/*************************************************************************/
/*                                                                       */
/*  Copyright (c) 1994 Stanford University                               */
/*                                                                       */
/*  All rights reserved.                                                 */
/*                                                                       */
/*  Permission is given to use, copy, and modify this software for any   */
/*  non-commercial purpose as long as this copyright notice is not       */
/*  removed.  All other uses, including redistribution in whole or in    */
/*  part, are forbidden without prior written permission.                */
/*                                                                       */
/*  This software is provided with absolutely no warranty and no         */
/*  support.                                                             */
/*                                                                       */
/*************************************************************************/

/*************************************************************************/
/*                                                                       */
/*  Integer radix sort of non-negative integers.                         */
/*                                                                       */
/*  Command line options:                                                */
/*                                                                       */
/*  -pP : P = number of processors.                                      */
/*  -rR : R = radix for sorting.  Must be power of 2.                    */
/*  -nN : N = number of keys to sort.                                    */
/*  -mM : M = maximum key value.  Integer keys k will be generated such  */
/*        that 0 <= k <= M.                                              */
/*  -s  : Print individual processor timing statistics.                  */
/*  -t  : Check to make sure all keys are sorted correctly.              */
/*  -o  : Print out sorted keys.                                         */
/*  -h  : Print out command line options.                                */
/*                                                                       */
/*  Default: RADIX -p1 -n262144 -r1024 -m524288                          */
/*                                                                       */
/*  Note: This version works under both the FORK and SPROC models        */
/*                                                                       */
/*************************************************************************/

#include <stdio.h>
#include <math.h>
#include <unistd.h>
#include <assert.h>

#define DEFAULT_P                    2
#define DEFAULT_N                    4
#define DEFAULT_R                    2 
#define DEFAULT_M                    8
#define MAX_PROCESSORS               2   
#define RADIX_S                8388608.0e0
#define RADIX           70368744177664.0e0
#define SEED                 314159265.0e0
#define RATIO               1220703125.0e0
#define PAGE_SIZE                    4
#define PAGE_MASK     (~(PAGE_SIZE-1))
#define MAX_RADIX                    4


#line 57
#include <pthread.h>
#line 57
#include <sys/time.h>
#line 57
#include <unistd.h>
#line 57
#include <stdlib.h>
#line 57
#define MAX_THREADS 32
#line 57
pthread_t PThreadTable[MAX_THREADS];
#line 57


struct prefix_node {
   long densities[MAX_RADIX];
   long ranks[MAX_RADIX];
   
#line 62
struct {
#line 62
	pthread_mutex_t	Mutex;
#line 62
	pthread_cond_t	CondVar;
#line 62
	unsigned long	Flag;
#line 62
} done;
#line 62

   char pad[PAGE_SIZE];
};

struct global_memory {
   long Index;                             /* process ID */
   pthread_mutex_t (lock_Index);                    /* for fetch and add to get ID */
   pthread_mutex_t (rank_lock);                     /* for fetch and add to get ID */
/*   pthread_mutex_t section_lock[MAX_PROCESSORS];*/  /* key locks */
   
#line 71
struct {
#line 71
	pthread_mutex_t	mutex;
#line 71
	pthread_cond_t	cv;
#line 71
	unsigned long	counter;
#line 71
	unsigned long	cycle;
#line 71
} (barrier_rank);
#line 71
                   /* for ranking process */
   
#line 72
struct {
#line 72
	pthread_mutex_t	mutex;
#line 72
	pthread_cond_t	cv;
#line 72
	unsigned long	counter;
#line 72
	unsigned long	cycle;
#line 72
} (barrier_key);
#line 72
                    /* for key sorting process */
   double *ranktime;
   double *sorttime;
   double *totaltime;
   long final;
   unsigned long starttime;
   unsigned long rs;
   unsigned long rf;
   struct prefix_node prefix_tree[2 * MAX_PROCESSORS];
} *global;

struct global_private {
  char pad[PAGE_SIZE];
  long *rank_ff;         /* overall processor ranks */
} gp[MAX_PROCESSORS];

long *key[2];            /* sort from one index into the other */
long **rank_me;          /* individual processor ranks */
long *key_partition;     /* keys a processor works on */
long *rank_partition;    /* ranks a processor works on */

long number_of_processors = DEFAULT_P;
long max_num_digits;
long radix = DEFAULT_R;
long num_keys = DEFAULT_N;
long max_key = DEFAULT_M;
long log2_radix;
long log2_keys;
long dostats = 0;
long test_result = 0;
long doprint = 0;
long ass;

void slave_sort(void);
double product_mod_46(double t1, double t2);
double ran_num_init(unsigned long k, double b, double t);
long get_max_digits(long max_key);
long get_log2_radix(long rad);
long get_log2_keys(long num_keys);
long log_2(long number);
void printerr(char *s);
void init(long key_start, long key_stop, long from);
void test_sort(long final);
void printout(void);

int main(int argc, char *argv[])
{
   long i;
   long p;
   long quotient;
   long remainder;
   long sum_i; 
   long sum_f;
   long size;
   long **temp;
   long **temp2;
   long *a;
   long c;
   double mint, maxt, avgt;
   double minrank, maxrank, avgrank;
   double minsort, maxsort, avgsort;
   unsigned long start;


   {
#line 136
	struct timeval	FullTime;
#line 136

#line 136
	gettimeofday(&FullTime, NULL);
#line 136
	(start) = (unsigned long)(FullTime.tv_usec + FullTime.tv_sec * 1000000);
#line 136
}

   while ((c = getopt(argc, argv, "p:r:n:m:stoh")) != -1) {
     switch(c) {
      case 'p': number_of_processors = atoi(optarg);
                if (number_of_processors < 1) {
                  printerr("P must be >= 1\n");
                  exit(-1);
                }
                if (number_of_processors > MAX_PROCESSORS) {
                  printerr("Maximum processors (MAX_PROCESSORS) exceeded\n"); 
		  exit(-1);
		}
                break;
      case 'r': radix = atoi(optarg);
                if (radix < 1) {
                  printerr("Radix must be a power of 2 greater than 0\n");
                  exit(-1);
                }
                log2_radix = log_2(radix);
                if (log2_radix == -1) {
                  printerr("Radix must be a power of 2\n");
                  exit(-1);
                }
                break;
      case 'n': num_keys = atoi(optarg);
                if (num_keys < 1) {
                  printerr("Number of keys must be >= 1\n");
                  exit(-1);
                }
                break;
      case 'm': max_key = atoi(optarg);
                if (max_key < 1) {
                  printerr("Maximum key must be >= 1\n");
                  exit(-1);
                }
                break;
      case 's': dostats = !dostats;
                break;
      case 't': test_result = !test_result;
                break;
      case 'o': doprint = !doprint;
                break;
      case 'h': printf("Usage: RADIX <options>\n\n");
                printf("   -pP : P = number of processors.\n");
                printf("   -rR : R = radix for sorting.  Must be power of 2.\n");
                printf("   -nN : N = number of keys to sort.\n");
                printf("   -mM : M = maximum key value.  Integer keys k will be generated such\n");
                printf("         that 0 <= k <= M.\n");
                printf("   -s  : Print individual processor timing statistics.\n");
                printf("   -t  : Check to make sure all keys are sorted correctly.\n");
                printf("   -o  : Print out sorted keys.\n");
                printf("   -h  : Print out command line options.\n\n");
                printf("Default: RADIX -p%1d -n%1d -r%1d -m%1d\n",
                        DEFAULT_P,DEFAULT_N,DEFAULT_R,DEFAULT_M);
		exit(0);
     }
   }

   {;}
   doprint =1;
   test_result=1;
   ass=0;
   log2_radix = log_2(radix); 
   log2_keys = log_2(num_keys);
   global = (struct global_memory *) valloc(sizeof(struct global_memory));;
   if (global == NULL) {
	   fprintf(stderr,"ERROR: Cannot malloc enough memory for global\n");
	   exit(-1);
   }
   key[0] = (long *) valloc(num_keys*sizeof(long));;
   key[1] = (long *) valloc(num_keys*sizeof(long));;
   key_partition = (long *) valloc((number_of_processors+1)*sizeof(long));;
   rank_partition = (long *) valloc((number_of_processors+1)*sizeof(long));;
   global->ranktime = (double *) valloc(number_of_processors*sizeof(double));;
   global->sorttime = (double *) valloc(number_of_processors*sizeof(double));;
   global->totaltime = (double *) valloc(number_of_processors*sizeof(double));;
   size = number_of_processors*(radix*sizeof(long)+sizeof(long *));
   rank_me = (long **) valloc(size);;
   if ((key[0] == NULL) || (key[1] == NULL) || (key_partition == NULL) || (rank_partition == NULL) || 
       (global->ranktime == NULL) || (global->sorttime == NULL) || (global->totaltime == NULL) || (rank_me == NULL)) {
     fprintf(stderr,"ERROR: Cannot malloc enough memory\n");
     exit(-1); 
   }

   temp = rank_me;
   temp2 = temp + number_of_processors;
   a = (long *) temp2;
   for (i=0;i<number_of_processors;i++) {
     *temp = (long *) a;
     temp++;
     a += radix;
   }
   for (i=0;i<number_of_processors;i++) {
     gp[i].rank_ff = (long *) valloc(radix*sizeof(long)+PAGE_SIZE);;
   }
   {pthread_mutex_init(&(global->lock_Index), NULL);}
   {pthread_mutex_init(&(global->rank_lock), NULL);}
/*   {
#line 234
	unsigned long	i, Error;
#line 234

#line 234
	for (i = 0; i < MAX_PROCESSORS; i++) {
#line 234
		Error = pthread_mutex_init(&global->section_lock[i], NULL);
#line 234
		if (Error != 0) {
#line 234
			printf("Error while initializing array of locks.\n");
#line 234
			exit(-1);
#line 234
		}
#line 234
	}
#line 234
}*/
   {
#line 235
	unsigned long	Error;
#line 235

#line 235
	Error = pthread_mutex_init(&(global->barrier_rank).mutex, NULL);
#line 235
	if (Error != 0) {
#line 235
		printf("Error while initializing barrier.\n");
#line 235
		exit(-1);
#line 235
	}
#line 235

#line 235
	Error = pthread_cond_init(&(global->barrier_rank).cv, NULL);
#line 235
	if (Error != 0) {
#line 235
		printf("Error while initializing barrier.\n");
#line 235
		pthread_mutex_destroy(&(global->barrier_rank).mutex);
#line 235
		exit(-1);
#line 235
	}
#line 235

#line 235
	(global->barrier_rank).counter = 0;
#line 235
	(global->barrier_rank).cycle = 0;
#line 235
}
   {
#line 236
	unsigned long	Error;
#line 236

#line 236
	Error = pthread_mutex_init(&(global->barrier_key).mutex, NULL);
#line 236
	if (Error != 0) {
#line 236
		printf("Error while initializing barrier.\n");
#line 236
		exit(-1);
#line 236
	}
#line 236

#line 236
	Error = pthread_cond_init(&(global->barrier_key).cv, NULL);
#line 236
	if (Error != 0) {
#line 236
		printf("Error while initializing barrier.\n");
#line 236
		pthread_mutex_destroy(&(global->barrier_key).mutex);
#line 236
		exit(-1);
#line 236
	}
#line 236

#line 236
	(global->barrier_key).counter = 0;
#line 236
	(global->barrier_key).cycle = 0;
#line 236
}
   
   for (i=0; i<2*number_of_processors; i++) {
     {
#line 239
	pthread_mutex_init(&global->prefix_tree[i].done.Mutex, NULL);
#line 239
	pthread_cond_init(&global->prefix_tree[i].done.CondVar, NULL);
#line 239
	global->prefix_tree[i].done.Flag = 0;
#line 239
}
#line 239
;
   }

   global->Index = 0;
   max_num_digits = get_max_digits(max_key);
   printf("\n");
   printf("Integer Radix Sort\n");
   printf("     %ld Keys\n",num_keys);
   printf("     %ld Processors\n",number_of_processors);
   printf("     Radix = %ld\n",radix);
   printf("     Max key = %ld\n",max_key);
   printf("\n");

   quotient = num_keys / number_of_processors;
   remainder = num_keys % number_of_processors;
   sum_i = 0;
   sum_f = 0;
   p = 0;
   while (sum_i < num_keys) {
      key_partition[p] = sum_i;
      p++;
      sum_i = sum_i + quotient;
      sum_f = sum_f + remainder;
      sum_i = sum_i + sum_f / number_of_processors;
      sum_f = sum_f % number_of_processors;
   }
   key_partition[p] = num_keys;

   quotient = radix / number_of_processors;
   remainder = radix % number_of_processors;
   sum_i = 0;
   sum_f = 0;
   p = 0;
   while (sum_i < radix) {
      rank_partition[p] = sum_i;
      p++;
      sum_i = sum_i + quotient;
      sum_f = sum_f + remainder;
      sum_i = sum_i + sum_f / number_of_processors;
      sum_f = sum_f % number_of_processors;
   }
   rank_partition[p] = radix;

/* POSSIBLE ENHANCEMENT:  Here is where one might distribute the key,
   rank_me, rank, and gp data structures across physically 
   distributed memories as desired. 
   
   One way to place data is as follows:  
      
   for (i=0;i<number_of_processors;i++) {
     Place all addresses x such that:
       &(key[0][key_partition[i]]) <= x < &(key[0][key_partition[i+1]])
            on node i
       &(key[1][key_partition[i]]) <= x < &(key[1][key_partition[i+1]])
            on node i
       &(rank_me[i][0]) <= x < &(rank_me[i][radix-1]) on node i
       &(gp[i]) <= x < &(gp[i+1]) on node i
       &(gp[i].rank_ff[0]) <= x < &(gp[i].rank_ff[radix]) on node i
   }
   start_p = 0;
   i = 0;

   for (toffset = 0; toffset < number_of_processors; toffset ++) {
     offset = toffset;
     level = number_of_processors >> 1;
     base = number_of_processors;
     while ((offset & 0x1) != 0) {
       offset >>= 1;
       index = base + offset;
       Place all addresses x such that:
         &(global->prefix_tree[index]) <= x < 
              &(global->prefix_tree[index + 1]) on node toffset
       base += level;
       level >>= 1;
     }  
   }  */

   /* Fill the random-number array. */
   
   {
#line 318
	long	i, Error;
#line 318

#line 318
	for (i = 0; i < (number_of_processors) - 1; i++) {
#line 318
		Error = pthread_create(&PThreadTable[i], NULL, (void * (*)(void *))(slave_sort), NULL);
#line 318
		if (Error != 0) {
#line 318
			printf("Error in pthread_create().\n");
#line 318
			exit(-1);
#line 318
		}
#line 318
	}
#line 318

#line 318
	slave_sort();
#line 318
};
   {
#line 319
	unsigned long	i, Error;
#line 319
	for (i = 0; i < (number_of_processors) - 1; i++) {
#line 319
		Error = pthread_join(PThreadTable[i], NULL);
#line 319
		if (Error != 0) {
#line 319
			printf("Error in pthread_join().\n");
#line 319
			exit(-1);
#line 319
		}
#line 319
	}
#line 319
};
   // assert ( key[global->final][0] == 3 );
   printf("\n");
   printf("                 PROCESS STATISTICS\n");
   printf("               Total            Rank            Sort\n");
   printf(" Proc          Time             Time            Time\n");
   printf("    0     %10.0f      %10.0f      %10.0f\n",
           global->totaltime[0],global->ranktime[0],
           global->sorttime[0]);
   if (dostats) {
     maxt = avgt = mint = global->totaltime[0];
     maxrank = avgrank = minrank = global->ranktime[0];
     maxsort = avgsort = minsort = global->sorttime[0];
     for (i=1; i<number_of_processors; i++) {
       if (global->totaltime[i] > maxt) {
         maxt = global->totaltime[i];
       }
       if (global->totaltime[i] < mint) {
         mint = global->totaltime[i];
       }
       if (global->ranktime[i] > maxrank) {
         maxrank = global->ranktime[i];
       }
       if (global->ranktime[i] < minrank) {
         minrank = global->ranktime[i];
       }
       if (global->sorttime[i] > maxsort) {
         maxsort = global->sorttime[i];
       }
       if (global->sorttime[i] < minsort) {
         minsort = global->sorttime[i];
       }
       avgt += global->totaltime[i];
       avgrank += global->ranktime[i];
       avgsort += global->sorttime[i];
     }
     avgt = avgt / number_of_processors;
     avgrank = avgrank / number_of_processors;
     avgsort = avgsort / number_of_processors;
     for (i=1; i<number_of_processors; i++) {
       printf("  %3ld     %10.0f      %10.0f      %10.0f\n",
               i,global->totaltime[i],global->ranktime[i],
               global->sorttime[i]);
     }
     printf("  Avg     %10.0f      %10.0f      %10.0f\n",avgt,avgrank,avgsort);
     printf("  Min     %10.0f      %10.0f      %10.0f\n",mint,minrank,minsort);
     printf("  Max     %10.0f      %10.0f      %10.0f\n",maxt,maxrank,maxsort);
     printf("\n");
   }

   printf("\n");
   global->starttime = start;
   printf("                 TIMING INFORMATION\n");
   printf("Start time                        : %16lu\n",
           global->starttime);
   printf("Initialization finish time        : %16lu\n",
           global->rs);
   printf("Overall finish time               : %16lu\n",
           global->rf);
   printf("Total time with initialization    : %16lu\n",
           global->rf-global->starttime);
   printf("Total time without initialization : %16lu\n",
           global->rf-global->rs);
   printf("\n");

   if (doprint) {
     printout();
   }
   if (test_result) {
     test_sort(global->final);  
   }
  
   {return 0;};
}

void slave_sort()
{
   long i;
   long MyNum;
   long this_key;
   long tmp;
   long loopnum;
   long shiftnum;
   long bb;
   long my_key;
   long key_start;
   long key_stop;
   long rank_start;
   long rank_stop;
   long from=0;
   long to=1;
   long *key_density;       /* individual processor key densities */
   unsigned long time1;
   unsigned long time2;
   unsigned long time3;
   unsigned long time4;
   unsigned long time5;
   unsigned long time6;
   double ranktime=0;
   double sorttime=0;
   long *key_from;
   long *key_to;
   long *rank_me_mynum;
   long *rank_ff_mynum;
   long stats;
   struct prefix_node* n;
   struct prefix_node* r;
   struct prefix_node* l;
   struct prefix_node* my_node;
   struct prefix_node* their_node;
   long index;
   long level;
   long base;
   long offset;
   long id;
   
   stats = dostats;

   {pthread_mutex_lock(&(global->lock_Index));}
     MyNum = global->Index;
     global->Index++;
   {pthread_mutex_unlock(&(global->lock_Index));}

   {;};
   {;};

/* POSSIBLE ENHANCEMENT:  Here is where one might pin processes to
   processors to avoid migration */

   key_density = (long *) valloc(radix*sizeof(long));;

   /* Fill the random-number array. */

   key_start = key_partition[MyNum];
   key_stop = key_partition[MyNum + 1];
   rank_start = rank_partition[MyNum];
   rank_stop = rank_partition[MyNum + 1];
   if (rank_stop == radix) {
     rank_stop--;
   }

   init(key_start,key_stop,from);

   {
#line 462
	unsigned long	Error, Cycle;
#line 462
	long		Cancel, Temp;
#line 462

#line 462
	Error = pthread_mutex_lock(&(global->barrier_key).mutex);
#line 462
	if (Error != 0) {
#line 462
		printf("Error while trying to get lock in barrier.\n");
#line 462
		exit(-1);
#line 462
	}
#line 462

#line 462
	Cycle = (global->barrier_key).cycle;
#line 462
	if (++(global->barrier_key).counter != (number_of_processors)) {
#line 462
		pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &Cancel);
#line 462
		while (Cycle == (global->barrier_key).cycle) {
#line 462
			Error = pthread_cond_wait(&(global->barrier_key).cv, &(global->barrier_key).mutex);
#line 462
			if (Error != 0) {
#line 462
				break;
#line 462
			}
#line 462
		}
#line 462
		pthread_setcancelstate(Cancel, &Temp);
#line 462
	} else {
#line 462
		(global->barrier_key).cycle = !(global->barrier_key).cycle;
#line 462
		(global->barrier_key).counter = 0;
#line 462
		Error = pthread_cond_broadcast(&(global->barrier_key).cv);
#line 462
	}
#line 462
	pthread_mutex_unlock(&(global->barrier_key).mutex);
#line 462
} 

/* POSSIBLE ENHANCEMENT:  Here is where one might reset the
   statistics that one is measuring about the parallel execution */

   {
#line 467
	unsigned long	Error, Cycle;
#line 467
	long		Cancel, Temp;
#line 467

#line 467
	Error = pthread_mutex_lock(&(global->barrier_key).mutex);
#line 467
	if (Error != 0) {
#line 467
		printf("Error while trying to get lock in barrier.\n");
#line 467
		exit(-1);
#line 467
	}
#line 467

#line 467
	Cycle = (global->barrier_key).cycle;
#line 467
	if (++(global->barrier_key).counter != (number_of_processors)) {
#line 467
		pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &Cancel);
#line 467
		while (Cycle == (global->barrier_key).cycle) {
#line 467
			Error = pthread_cond_wait(&(global->barrier_key).cv, &(global->barrier_key).mutex);
#line 467
			if (Error != 0) {
#line 467
				break;
#line 467
			}
#line 467
		}
#line 467
		pthread_setcancelstate(Cancel, &Temp);
#line 467
	} else {
#line 467
		(global->barrier_key).cycle = !(global->barrier_key).cycle;
#line 467
		(global->barrier_key).counter = 0;
#line 467
		Error = pthread_cond_broadcast(&(global->barrier_key).cv);
#line 467
	}
#line 467
	pthread_mutex_unlock(&(global->barrier_key).mutex);
#line 467
} 

   if ((MyNum == 0) || (stats)) {
     {
#line 470
	struct timeval	FullTime;
#line 470

#line 470
	gettimeofday(&FullTime, NULL);
#line 470
	(time1) = (unsigned long)(FullTime.tv_usec + FullTime.tv_sec * 1000000);
#line 470
}
   }

/* Do 1 iteration per digit.  */

   rank_me_mynum = rank_me[MyNum];
   rank_ff_mynum = gp[MyNum].rank_ff;
   for (loopnum=0;loopnum<max_num_digits;loopnum++) {
     shiftnum = (loopnum * log2_radix);
     bb = (radix-1) << shiftnum;

/* generate histograms based on one digit */

     if ((MyNum == 0) || (stats)) {
       {
#line 484
	struct timeval	FullTime;
#line 484

#line 484
	gettimeofday(&FullTime, NULL);
#line 484
	(time2) = (unsigned long)(FullTime.tv_usec + FullTime.tv_sec * 1000000);
#line 484
}
     }

     for (i = 0; i < radix; i++) {
       rank_me_mynum[i] = 0;
     }  
     key_from = (long *) key[from];
     key_to = (long *) key[to];
     for (i=key_start;i<key_stop;i++) {
       my_key = key_from[i] & bb;
       my_key = my_key >> shiftnum;  
       rank_me_mynum[my_key]++;
     }
     key_density[0] = rank_me_mynum[0]; 
     for (i=1;i<radix;i++) {
       key_density[i] = key_density[i-1] + rank_me_mynum[i];  
     }

     {
#line 502
	unsigned long	Error, Cycle;
#line 502
	long		Cancel, Temp;
#line 502

#line 502
	Error = pthread_mutex_lock(&(global->barrier_rank).mutex);
#line 502
	if (Error != 0) {
#line 502
		printf("Error while trying to get lock in barrier.\n");
#line 502
		exit(-1);
#line 502
	}
#line 502

#line 502
	Cycle = (global->barrier_rank).cycle;
#line 502
	if (++(global->barrier_rank).counter != (number_of_processors)) {
#line 502
		pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &Cancel);
#line 502
		while (Cycle == (global->barrier_rank).cycle) {
#line 502
			Error = pthread_cond_wait(&(global->barrier_rank).cv, &(global->barrier_rank).mutex);
#line 502
			if (Error != 0) {
#line 502
				break;
#line 502
			}
#line 502
		}
#line 502
		pthread_setcancelstate(Cancel, &Temp);
#line 502
	} else {
#line 502
		(global->barrier_rank).cycle = !(global->barrier_rank).cycle;
#line 502
		(global->barrier_rank).counter = 0;
#line 502
		Error = pthread_cond_broadcast(&(global->barrier_rank).cv);
#line 502
	}
#line 502
	pthread_mutex_unlock(&(global->barrier_rank).mutex);
#line 502
}

     n = &(global->prefix_tree[MyNum]);
     for (i = 0; i < radix; i++) {
        n->densities[i] = key_density[i];
        n->ranks[i] = rank_me_mynum[i];
     }
     offset = MyNum;
     level = number_of_processors >> 1;
     base = number_of_processors;
     if ((MyNum & 0x1) == 0) {
        {
#line 513
	pthread_mutex_lock(&global->prefix_tree[base + (offset >> 1)].done.Mutex);
#line 513
	global->prefix_tree[base + (offset >> 1)].done.Flag = 1;
#line 513
	pthread_cond_broadcast(&global->prefix_tree[base + (offset >> 1)].done.CondVar);
#line 513
	pthread_mutex_unlock(&global->prefix_tree[base + (offset >> 1)].done.Mutex);}
#line 513
;
     }
     while ((offset & 0x1) != 0) {
       offset >>= 1;
       r = n;
       l = n - 1;
       index = base + offset;
       n = &(global->prefix_tree[index]);
       {
#line 521
	pthread_mutex_lock(&n->done.Mutex);
#line 521
	if (n->done.Flag == 0) {
#line 521
		pthread_cond_wait(&n->done.CondVar, &n->done.Mutex);
#line 521
	}
#line 521
};
       {
#line 522
	n->done.Flag = 0;
#line 522
	pthread_mutex_unlock(&n->done.Mutex);}
#line 522
;
       if (offset != (level - 1)) {
         for (i = 0; i < radix; i++) {
           n->densities[i] = r->densities[i] + l->densities[i];
           n->ranks[i] = r->ranks[i] + l->ranks[i];
         }
       } else {
         for (i = 0; i < radix; i++) {
           n->densities[i] = r->densities[i] + l->densities[i];
         }
       }
       base += level;
       level >>= 1;
       if ((offset & 0x1) == 0) {
         {
#line 536
	pthread_mutex_lock(&global->prefix_tree[base + (offset >> 1)].done.Mutex);
#line 536
	global->prefix_tree[base + (offset >> 1)].done.Flag = 1;
#line 536
	pthread_cond_broadcast(&global->prefix_tree[base + (offset >> 1)].done.CondVar);
#line 536
	pthread_mutex_unlock(&global->prefix_tree[base + (offset >> 1)].done.Mutex);}
#line 536
;
       }
     }
     {
#line 539
	unsigned long	Error, Cycle;
#line 539
	long		Cancel, Temp;
#line 539

#line 539
	Error = pthread_mutex_lock(&(global->barrier_rank).mutex);
#line 539
	if (Error != 0) {
#line 539
		printf("Error while trying to get lock in barrier.\n");
#line 539
		exit(-1);
#line 539
	}
#line 539

#line 539
	Cycle = (global->barrier_rank).cycle;
#line 539
	if (++(global->barrier_rank).counter != (number_of_processors)) {
#line 539
		pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &Cancel);
#line 539
		while (Cycle == (global->barrier_rank).cycle) {
#line 539
			Error = pthread_cond_wait(&(global->barrier_rank).cv, &(global->barrier_rank).mutex);
#line 539
			if (Error != 0) {
#line 539
				break;
#line 539
			}
#line 539
		}
#line 539
		pthread_setcancelstate(Cancel, &Temp);
#line 539
	} else {
#line 539
		(global->barrier_rank).cycle = !(global->barrier_rank).cycle;
#line 539
		(global->barrier_rank).counter = 0;
#line 539
		Error = pthread_cond_broadcast(&(global->barrier_rank).cv);
#line 539
	}
#line 539
	pthread_mutex_unlock(&(global->barrier_rank).mutex);
#line 539
}

     if (MyNum != (number_of_processors - 1)) {
       offset = MyNum;
       level = number_of_processors;
       base = 0;
       while ((offset & 0x1) != 0) {
         offset >>= 1;
         base += level;
         level >>= 1;
       }
       my_node = &(global->prefix_tree[base + offset]);
       offset >>= 1;
       base += level;
       level >>= 1;
       while ((offset & 0x1) != 0) {
         offset >>= 1;
         base += level;
         level >>= 1;
       }
       their_node = &(global->prefix_tree[base + offset]);
       {
#line 560
	pthread_mutex_lock(&my_node->done.Mutex);
#line 560
	if (my_node->done.Flag == 0) {
#line 560
		pthread_cond_wait(&my_node->done.CondVar, &my_node->done.Mutex);
#line 560
	}
#line 560
};
       {
#line 561
	my_node->done.Flag = 0;
#line 561
	pthread_mutex_unlock(&my_node->done.Mutex);}
#line 561
;
       for (i = 0; i < radix; i++) {
         my_node->densities[i] = their_node->densities[i];
       }
     } else {
       my_node = &(global->prefix_tree[(2 * number_of_processors) - 2]);
     }
     offset = MyNum;
     level = number_of_processors;
     base = 0;
     while ((offset & 0x1) != 0) {
       {
#line 572
	pthread_mutex_lock(&global->prefix_tree[base + offset - 1].done.Mutex);
#line 572
	global->prefix_tree[base + offset - 1].done.Flag = 1;
#line 572
	pthread_cond_broadcast(&global->prefix_tree[base + offset - 1].done.CondVar);
#line 572
	pthread_mutex_unlock(&global->prefix_tree[base + offset - 1].done.Mutex);}
#line 572
;
       offset >>= 1;
       base += level;
       level >>= 1;
     }
     offset = MyNum;
     level = number_of_processors;
     base = 0;
     for(i = 0; i < radix; i++) {
       rank_ff_mynum[i] = 0;
     }
     while (offset != 0) {
       if ((offset & 0x1) != 0) {
         /* Add ranks of node to your left at this level */
         l = &(global->prefix_tree[base + offset - 1]);
         for (i = 0; i < radix; i++) {
           rank_ff_mynum[i] += l->ranks[i];
         }
       }
       base += level;
       level >>= 1;
       offset >>= 1;
     }
     for (i = 1; i < radix; i++) {
       rank_ff_mynum[i] += my_node->densities[i - 1];
     }

     if ((MyNum == 0) || (stats)) {
       {
#line 600
	struct timeval	FullTime;
#line 600

#line 600
	gettimeofday(&FullTime, NULL);
#line 600
	(time3) = (unsigned long)(FullTime.tv_usec + FullTime.tv_sec * 1000000);
#line 600
};
     }
     id=ass;
     assert(id==ass);
     /*{
#line 604
	unsigned long	Error, Cycle;
#line 604
	long		Cancel, Temp;
#line 604

#line 604
	Error = pthread_mutex_lock(&(global->barrier_rank).mutex);
#line 604
	if (Error != 0) {
#line 604
		printf("Error while trying to get lock in barrier.\n");
#line 604
		exit(-1);
#line 604
	}
#line 604

#line 604
	Cycle = (global->barrier_rank).cycle;
#line 604
	if (++(global->barrier_rank).counter != (number_of_processors)) {
#line 604
		pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &Cancel);
#line 604
		while (Cycle == (global->barrier_rank).cycle) {
#line 604
			Error = pthread_cond_wait(&(global->barrier_rank).cv, &(global->barrier_rank).mutex);
#line 604
			if (Error != 0) {
#line 604
				break;
#line 604
			}
#line 604
		}
#line 604
		pthread_setcancelstate(Cancel, &Temp);
#line 604
	} else {
#line 604
		(global->barrier_rank).cycle = !(global->barrier_rank).cycle;
#line 604
		(global->barrier_rank).counter = 0;
#line 604
		Error = pthread_cond_broadcast(&(global->barrier_rank).cv);
#line 604
	}
#line 604
	pthread_mutex_unlock(&(global->barrier_rank).mutex);
#line 604
}*/

     if ((MyNum == 0) || (stats)) {
       {
#line 607
	struct timeval	FullTime;
#line 607

#line 607
	gettimeofday(&FullTime, NULL);
#line 607
	(time4) = (unsigned long)(FullTime.tv_usec + FullTime.tv_sec * 1000000);
#line 607
};
     }

     /* put it in order according to this digit */

     for (i = key_start; i < key_stop; i++) {  
       this_key = key_from[i] & bb;
       this_key = this_key >> shiftnum;  
       tmp = rank_ff_mynum[this_key];
       key_to[tmp] = key_from[i];
       rank_ff_mynum[this_key]++;
     }   /*  i */  

     if ((MyNum == 0) || (stats)) {
       {
#line 621
	struct timeval	FullTime;
#line 621

#line 621
	gettimeofday(&FullTime, NULL);
#line 621
	(time5) = (unsigned long)(FullTime.tv_usec + FullTime.tv_sec * 1000000);
#line 621
};
     }

     if (loopnum != max_num_digits-1) {
       from = from ^ 0x1;
       to = to ^ 0x1;
     }

     /*{
#line 629
	unsigned long	Error, Cycle;
#line 629
	long		Cancel, Temp;
#line 629

#line 629
	Error = pthread_mutex_lock(&(global->barrier_rank).mutex);
#line 629
	if (Error != 0) {
#line 629
		printf("Error while trying to get lock in barrier.\n");
#line 629
		exit(-1);
#line 629
	}
#line 629

#line 629
	Cycle = (global->barrier_rank).cycle;
#line 629
	if (++(global->barrier_rank).counter != (number_of_processors)) {
#line 629
		pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &Cancel);
#line 629
		while (Cycle == (global->barrier_rank).cycle) {
#line 629
			Error = pthread_cond_wait(&(global->barrier_rank).cv, &(global->barrier_rank).mutex);
#line 629
			if (Error != 0) {
#line 629
				break;
#line 629
			}
#line 629
		}
#line 629
		pthread_setcancelstate(Cancel, &Temp);
#line 629
	} else {
#line 629
		(global->barrier_rank).cycle = !(global->barrier_rank).cycle;
#line 629
		(global->barrier_rank).counter = 0;
#line 629
		Error = pthread_cond_broadcast(&(global->barrier_rank).cv);
#line 629
	}
#line 629
	pthread_mutex_unlock(&(global->barrier_rank).mutex);
#line 629
} */

     if ((MyNum == 0) || (stats)) {
       ranktime += (time3 - time2);
       sorttime += (time5 - time4);
     }
     ass++;
   } /* for */

   {
#line 638
	unsigned long	Error, Cycle;
#line 638
	long		Cancel, Temp;
#line 638

#line 638
	Error = pthread_mutex_lock(&(global->barrier_rank).mutex);
#line 638
	if (Error != 0) {
#line 638
		printf("Error while trying to get lock in barrier.\n");
#line 638
		exit(-1);
#line 638
	}
#line 638

#line 638
	Cycle = (global->barrier_rank).cycle;
#line 638
	if (++(global->barrier_rank).counter != (number_of_processors)) {
#line 638
		pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &Cancel);
#line 638
		while (Cycle == (global->barrier_rank).cycle) {
#line 638
			Error = pthread_cond_wait(&(global->barrier_rank).cv, &(global->barrier_rank).mutex);
#line 638
			if (Error != 0) {
#line 638
				break;
#line 638
			}
#line 638
		}
#line 638
		pthread_setcancelstate(Cancel, &Temp);
#line 638
	} else {
#line 638
		(global->barrier_rank).cycle = !(global->barrier_rank).cycle;
#line 638
		(global->barrier_rank).counter = 0;
#line 638
		Error = pthread_cond_broadcast(&(global->barrier_rank).cv);
#line 638
	}
#line 638
	pthread_mutex_unlock(&(global->barrier_rank).mutex);
#line 638
}
   if ((MyNum == 0) || (stats)) {
     {
#line 640
	struct timeval	FullTime;
#line 640

#line 640
	gettimeofday(&FullTime, NULL);
#line 640
	(time6) = (unsigned long)(FullTime.tv_usec + FullTime.tv_sec * 1000000);
#line 640
}
     global->ranktime[MyNum] = ranktime;
     global->sorttime[MyNum] = sorttime;
     global->totaltime[MyNum] = time6-time1;
   }
   if (MyNum == 0) {
     global->rs = time1;
     global->rf = time6;
     global->final = to;
   }

}

/*
 * product_mod_46() returns the product (mod 2^46) of t1 and t2.
 */
double product_mod_46(double t1, double t2)
{
   double a1;
   double b1;
   double a2;
   double b2;
			
   a1 = (double)((long)(t1 / RADIX_S));    /* Decompose the arguments.  */
   a2 = t1 - a1 * RADIX_S;
   b1 = (double)((long)(t2 / RADIX_S));
   b2 = t2 - b1 * RADIX_S;
   t1 = a1 * b2 + a2 * b1;      /* Multiply the arguments.  */
   t2 = (double)((long)(t1 / RADIX_S));
   t2 = t1 - t2 * RADIX_S;
   t1 = t2 * RADIX_S + a2 * b2;
   t2 = (double)((long)(t1 / RADIX));

   return (t1 - t2 * RADIX);    /* Return the product.  */
}

/*
 * finds the (k)th random number, given the seed, b, and the ratio, t.
 */
double ran_num_init(unsigned long k, double b, double t)
{
   unsigned long j;

   while (k != 0) {             /* while() is executed m times
				   such that 2^m > k.  */
      j = k >> 1;
      if ((j << 1) != k) {
         b = product_mod_46(b, t);
      }
      t = product_mod_46(t, t);
      k = j;
   }

   return b;
}

long get_max_digits(long max_key)
{
  long done = 0;
  long temp = 1;
  long key_val;

  key_val = max_key;
  while (!done) {
    key_val = key_val / radix;
    if (key_val == 0) {
      done = 1;
    } else {
      temp ++;
    }
  }
  return temp;
}

long get_log2_radix(long rad)
{
   long cumulative=1;
   long out;

   for (out = 0; out < 20; out++) {
     if (cumulative == rad) {
       return(out);
     } else {
       cumulative = cumulative * 2;
     }
   }
   fprintf(stderr,"ERROR: Radix %ld not a power of 2\n", rad);
   exit(-1);
}

long get_log2_keys(long num_keys)
{
   long cumulative=1;
   long out;

   for (out = 0; out < 30; out++) {
     if (cumulative == num_keys) {
       return(out);
     } else {
       cumulative = cumulative * 2;
     }
   }
   fprintf(stderr,"ERROR: Number of keys %ld not a power of 2\n", num_keys);
   exit(-1);
}

long log_2(long number)
{
  long cumulative = 1;
  long out = 0;
  long done = 0;

  while ((cumulative < number) && (!done) && (out < 50)) {
    if (cumulative == number) {
      done = 1;
    } else {
      cumulative = cumulative * 2;
      out ++;
    }
  }

  if (cumulative == number) {
    return(out);
  } else {
    return(-1);
  }
}

void printerr(char *s)
{
  fprintf(stderr,"ERROR: %s\n",s);
}

void init(long key_start, long key_stop, long from)
{
   double ran_num;
   double sum;
   long tmp;
   long i;
   long *key_from;

   ran_num = ran_num_init((key_start << 2) + 1, SEED, RATIO);
   sum = ran_num / RADIX;
   key_from = (long *) key[from];
   for (i = key_start; i < key_stop; i++) {
      ran_num = product_mod_46(ran_num, RATIO);
      sum = sum + ran_num / RADIX;
      ran_num = product_mod_46(ran_num, RATIO);
      sum = sum + ran_num / RADIX;
      ran_num = product_mod_46(ran_num, RATIO);
      sum = sum + ran_num / RADIX;
      key_from[i] = (long) ((sum / 4.0) *  max_key);
      tmp = (long) ((key_from[i])/100);
      ran_num = product_mod_46(ran_num, RATIO);
      sum = ran_num / RADIX;
   }
}

void test_sort(long final)
{
   long i;
   long mistake = 0;
   long *key_final;

   printf("\n");
   printf("                  TESTING RESULTS\n");
   key_final = key[final];
   for (i = 0; i < num_keys-1; i++) {
     if (key_final[i] > key_final[i + 1]) {
       fprintf(stderr,"error with key %ld, value %ld %ld \n",
        i,key_final[i],key_final[i + 1]);
       mistake++;
     }
   }

   if (mistake) {
      printf("FAILED: %ld keys out of place.\n", mistake);
   } else {
      printf("PASSED: All keys in place.\n");
   }
   printf("\n");
}

void printout()
{
   long i;
   long *key_final;

   key_final = (long *) key[global->final];
   printf("\n");
   printf("                 SORTED KEY VALUES\n");
   printf("%8ld ",key_final[0]);
   for (i = 0; i < num_keys-1; i++) {
     printf("%8ld ",key_final[i+1]);
     if ((i+2)%5 == 0) {
       printf("\n");
     }
   }
   printf("\n");
}

