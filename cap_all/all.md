#/home/zhy/Test/Benchmarks/blackscholes-parallel/blackscholes-parallel
- 运行命令:
		klee blackscholes.m4.o 2 ./input/in_4.txt ./output/out_4.txt 
说白了是一个单线程程序，输入四组数据，创建四个线程分别计算。


#/home/zhy/Test/Benchmarks/ctrace/ctrace_bug1
- 运行命令:
		klee ctrace.foobar.comb.mutex.o 1 
1.BUG1:deadlock
- line=475添加宏定义，改变解锁机制，可能导致死锁。
```c
#define ERR1 1
```
- line=1191添加
```c
assert( _hashreads>-1 && _hashreads<2 );
```
- 已测试


#/home/zhy/Test/Benchmarks/ctrace/ctrace_bug2
- 运行命令:
		klee ctrace.foobar.comb.mutex.o 1 
2.BUG2:deadlock
- line=475添加宏定义，改变解锁机制，可能导致死锁。
```c
#define ERR2 1
```
- 已测试
- line=1191添加
```c
assert( _hashreads>-1 && _hashreads<2 );
```


#/home/zhy/Test/Benchmarks/fft/fft
- 运行命令:
		klee FFT 
1.快速傅里叶变换，在main函数初始化，分配线程分别计算部分数据。通过同步机制保持各线程之间同步，如果修改同步机制会出错


#/home/zhy/Test/Benchmarks/fft/fft_bug1
- 运行命令:
		klee FFT 
1.BUG1:Multi threads read and write global id without locks
- 函数SlaveStart()中line=431，修改为:
```c
  // LOCK(Global->idlock);
    MyNum = Global->id;
    assert(MyNum == Global->id);
    Global->id++;
  // UNLOCK(Global->idlock); 
```
- 已测试


#/home/zhy/Test/Benchmarks/fft/fft_bug2
- 运行命令:
		klee FFT 
2.BUG2: Wrong synchronous barrier cause wrong outputs
- line=603
```c
    long id;
```
- line=626
```c
   id=ass;
    assert(id == ass);
    /*BARRIER(Global->start, P);*/
```
- line=647
```c
    ass++;
    BARRIER(Global->start, P);
```
- 已测试


#/home/zhy/Test/Benchmarks/lu/contiguous_blocks
- 运行命令:
		klee lu.o 
1.LU分解为矩阵计算，在main函数初始化，分配线程分别计算部分数据。通过同步机制保持各线程之间同步，如果修改同步机制会出错
- 参数
```c
#define DEFAULT_N                         4
#define DEFAULT_P                         2
#define DEFAULT_B                         2
#define PAGE_SIZE			1024
```


#/home/zhy/Test/Benchmarks/lu/contiguous_blocks_bug1
- 运行命令:
		klee lu.o 
2.BUG1:Multi threads increment global id without locks
- contigouos_blocks版本
- 函数SlaveStart()中line=415，修改为:
```c
  // LOCK(Global->idlock)
    MyNum = Global->id;
    assert(MyNum == Global->id);
    Global->id ++;
  // UNLOCK(Global->idlock)
```
- 参数
```c
#define DEFAULT_N                         2
#define DEFAULT_P                         2
#define DEFAULT_B                         2
```
- 已测试


#/home/zhy/Test/Benchmarks/lu/contiguous_blocks_bug2
- 运行命令:
		klee lu.o 
3.BUG2: Wrong synchronous barrier cause wrong outputs
- contigouos_blocks版本
- line=581
```c
    long id;
```
- line=607
```c
    id=ass;
    assert(id == ass);
    /*BARRIER(Global->start, P);*/
```
- line=649
```c
    ass++;
    BARRIER(Global->start, P);
```
- 参数
```c
#define DEFAULT_N                         3
#define DEFAULT_P                         2
#define DEFAULT_B                         2
```
- 已测试


#/home/zhy/Test/Benchmarks/lu/non_contiguous_blocks
- 运行命令:
		klee lu.o 
1.LU分解为矩阵计算，在main函数初始化，分配线程分别计算部分数据。通过同步机制保持各线程之间同步，如果修改同步机制会出错
- 参数
```c
#define DEFAULT_N                         4
#define DEFAULT_P                         2
#define DEFAULT_B                         2
#define PAGE_SIZE			1024
```


#/home/zhy/Test/Benchmarks/lu/non_contiguous_blocks_bug1
- 运行命令:
		klee lu.o 
2.BUG1:Multi threads increment global id without locks
- non_contigouos_blocks版本
- 函数SlaveStart()中line=325，修改为:
```c
  // LOCK(Global->idlock);
    MyNum = Global->id;
    assert(MyNum == Global->id);
    Global->id++;
  // UNLOCK(Global->idlock); 
```
- 参数
```c
#define DEFAULT_N                         4
#define DEFAULT_P                         2
#define DEFAULT_B                         2
```
- 已测试


#/home/zhy/Test/Benchmarks/lu/non_contiguous_blocks_bug2
- 运行命令:
		klee lu.o 
3.BUG2: Wrong synchronous barrier cause wrong outputs
- non_contigouos_blocks版本
- line=485
```c
    long id;
```
- line=506
```c
    id=ass;
    assert(id == ass);
    /*BARRIER(Global->start, P);*/
```
- line=543
```c
    ass++;
    BARRIER(Global->start, P);
```
- 参数
```c
#define DEFAULT_N                         3
#define DEFAULT_P                         2
#define DEFAULT_B                         2
```
- 已测试


#/home/zhy/Test/Benchmarks/pbzip
- 运行命令:
		klee pbzip2_revise2.o -k -f -p4 /home/zhy/Test/Benchmarks/pbzip/input 
1.在函数void *consumer (void *q)中，line=6842。
调用了pthread_cond_wait(fifo->notEmpty, fifo->mut);
一般不会执行或者在line=6773的pthread_cond_signal(fifo->notEmpty)之前执行。
2.计算出一条前缀，导致pthread_cond_wait在pthread_cond_signal之后执行，
从而有一个线程没有唤醒，而其他线程可以执行完，出错。



#/home/zhy/Test/Benchmarks/pcopy-1.5
- 运行命令:
		klee pcopy.o ./infile ./outfile 
只是一个复制程序


#/home/zhy/Test/Benchmarks/pfscan/pfscan
- 运行命令:
		klee pfscan-1.0.o -V 3 $PWD/file/ 
pfscan-1.0.c中使用了系统ftw函数来便利目录，llvm外部调用出错。
写了一个遍历目录的函数来进行替换，替换之后可在klee上执行。
free函数无法使用，原因与klee的约束求解有关，需要进一步研究。
注释free函数不影响该程序的执行。(尚未提交的版本中该问题已经修复，不过需要进一步测试，暂时请注释所有的free函数)
运行时不能使用dfs模式，要使用bfs模式，原因见源程序967行。
pqueue_close执行过晚将导致所有子线程等待，之后主线程在第974行进入等待，没有子线程能够唤醒，因此死锁。
使用绝对路径。


#/home/zhy/Test/Benchmarks/qsort.comb
- 运行命令:
		klee qsort.comb.o 
qsort.comb.c中并行qsort调用了系统qsort函数，llvm外部调用过程中出错。写了一个qsort用于替换，该qsort与系统qsort接口一致。



#/home/zhy/Test/Benchmarks/qsort.new
- 运行命令:
		klee qsort.int.o 
只是一个排序程序


#/home/zhy/Test/Benchmarks/radix/radix
- 运行命令:
		klee RADIX 
1.本程序实现了基数排序算法，参数已经作为默认值写入，直接运行即可。
- 参数
```c
#define DEFAULT_P                    2    //线程的数目
#define DEFAULT_N                    2    //排序的数字的数目
#define DEFAULT_R                    2     //基数的数目
#define DEFAULT_M                    2    //排序的数字的最大值
```


#/home/zhy/Test/Benchmarks/radix/radix_bug1
- 运行命令:
		klee RADIX 
1.BUG:Multi threads read and write global index without locks
- 函数slave_sort()中line=435，修改为:
```c
   // LOCK(global->lock_Index)
     MyNum = global->Index;
    assert(MyNum == global->Index);
     global->Index++;
   // UNLOCK(global->lock_Index)
```
- 已测试


#/home/zhy/Test/Benchmarks/radix/radix_bug2
- 运行命令:
		klee RADIX 
1.BUG: Wrong synchronous barrier cause wrong outputs
- 删除line=600\625的BARRIER(global->barrier_rank, number_of_pocessors);
- 参数
```c
#define DEFAULT_P                    2    //线程的数目
#define DEFAULT_N                    4    //排序的数字的数目
#define DEFAULT_R                    2     //基数的数目
#define DEFAULT_M                    8    //排序的数字的最大值
```
- 已测试


#/home/zhy/Test/Benchmarks/swarm/swarm
- 运行命令:
		klee swarm_isort64.revised.o 
1.本程序实现了基数排序算法，参数已经作为默认值写入，直接运行即可。
2.此程序根据线程数量，单独分配内存空间，每次创建线程用不同的参数。
参数的初始化工作为main函数完成，所以不存在BUG Multi threads read and write global id without locks.
5.程序计算函数为radixsort_swarm_s3();调用了两次countsort_swarm();
countsort_swarm()中的同步机制SWARM_Barrier()。
删除countsort_swarm()的SWARM_Barrier()会导致BUG;

