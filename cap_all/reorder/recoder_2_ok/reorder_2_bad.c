#include <assert.h>
#include <pthread.h>
#include <stdio.h>

static int iSet = 1;
static int iCheck = 1;

static int a = 0;
static int b = 0;
pthread_mutex_t mutex;

void __ESBMC_yield();

void *setThread(void *param);
void *checkThread(void *param);
void set();
int check();

int main(int argc, char *argv[]) {
  int i, err;
  /*
      if (argc != 1) {
          if (argc != 3) {
              fprintf(stderr, "./reorder <param1> <param2>\n");
              exit(-1);
          } else {
              sscanf(argv[1], "%d", &iSet);
              sscanf(argv[2], "%d", &iCheck);
          }
      }*/

  pthread_mutex_init(&mutex, 0);
  pthread_t setPool[iSet];
  pthread_t checkPool[iCheck];

  for (i = 0; i < iSet; i++) {
    if (0 != (err = pthread_create(&setPool[i], ((void *)0), &setThread,
                                   ((void *)0)))) {
      fprintf(stderr, "Error [%d] found creating set thread.\n", err);
      exit(-1);
    }
  }

  for (i = 0; i < iCheck; i++) {
    if (0 != (err = pthread_create(&checkPool[i], ((void *)0), &checkThread,
                                   ((void *)0)))) {
      fprintf(stderr, "Error [%d] found creating check thread.\n", err);
      exit(-1);
    }
  }

  for (i = 0; i < iSet; i++) {
    if (0 != (err = pthread_join(setPool[i], ((void *)0)))) {
      fprintf(stderr, "pthread join error: %d\n", err);
      exit(-1);
    }
  }

  for (i = 0; i < iCheck; i++) {
    if (0 != (err = pthread_join(checkPool[i], ((void *)0)))) {
      fprintf(stderr, "pthread join error: %d\n", err);
      exit(-1);
    }
  }

  return 0;
}

void *setThread(void *param) {
  pthread_mutex_lock(&mutex);
  a = 1;
  b = -1;
  pthread_mutex_unlock(&mutex);

  return ((void *)0);
}

void *checkThread(void *param) {
  if (!((a == 0 && b == 0) || (a == 1 && b == -1))) {
    fprintf(stderr, "Bug found!\n");
    assert(0);
  }

  return ((void *)0);
}
