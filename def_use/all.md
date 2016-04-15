#/home/icefox/git/Benchmarks/def_use/account/account_put
- 运行命令:
	klee account_ok.o 

AllFormulaNum:90
SovingTimes:0
TotalNewPath:1
TotalOldPath:0
TotalPath:1
allGlobal:7
brGlobal:7
AllBranch:0
satBranch:0
satCost:0
unSatBranch:0
unSatCost:0
uunSatBranch:0
SolvingCost:0.014536
RunningCost:0.001867
inputCost:0.000535
def-use size:14
TimeCost:2.401000e-02
Insts:159
totalline:53
name:account_put



#/home/icefox/git/Benchmarks/def_use/arithmetic/arithmetic_put
- 运行命令:
	klee arithmetic_prog_ok.o 

AllFormulaNum:1415
SovingTimes:0
TotalNewPath:1
TotalOldPath:0
TotalPath:1
allGlobal:33
brGlobal:33
AllBranch:0
satBranch:0
satCost:0
unSatBranch:0
unSatCost:0
uunSatBranch:0
SolvingCost:0.127226
RunningCost:0.005744
inputCost:0.000843
def-use size:27
TimeCost:1.446570e-01
Insts:786
totalline:79
name:arithmetic_put



#/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel
- 运行命令:
	klee blackscholes.m4.o 2 ./input/in_4.txt ./output/out_4.txt 
说白了是一个单线程程序，输入四组数据，创建四个线程分别计算。
AllFormulaNum:1612
SovingTimes:0
TotalNewPath:2
TotalOldPath:1
TotalPath:3
allGlobal:243
brGlobal:243
AllBranch:0
satBranch:0
satCost:0
unSatBranch:0
unSatCost:0
uunSatBranch:0
SolvingCost:0.351259
RunningCost:0.04828
inputCost:0.016277
def-use size:23
TimeCost:4.511560e-01
Insts:25021
totalline:569
name:blackscholes-parallel



#/home/icefox/git/Benchmarks/def_use/fft/fft
- 运行命令:
	klee FFT 
1.快速傅里叶变换，在main函数初始化，分配线程分别计算部分数据。通过同步机制保持各线程之间同步，如果修改同步机制会出错
AllFormulaNum:141182
SovingTimes:0
TotalNewPath:10
TotalOldPath:27
TotalPath:37
allGlobal:1291.5
brGlobal:1291.5
AllBranch:0
satBranch:0
satCost:0
unSatBranch:0
unSatCost:0
uunSatBranch:0
SolvingCost:20906.8
RunningCost:4.33806
inputCost:0.594517
def-use size:512
TimeCost:2.092205e+04
Insts:1603817
totalline:1496
name:fft



#/home/icefox/git/Benchmarks/def_use/lu/contiguous_blocks_put1
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
AllFormulaNum:66522
SovingTimes:0
TotalNewPath:12
TotalOldPath:43
TotalPath:55
allGlobal:926.5
brGlobal:926.5
AllBranch:0
satBranch:0
satCost:0
unSatBranch:0
unSatCost:0
uunSatBranch:0
SolvingCost:11814
RunningCost:2.45298
inputCost:0.375327
def-use size:295
TimeCost:1.181927e+04
Insts:798781
totalline:1410
name:contiguous_blocks_put1



#/home/icefox/git/Benchmarks/def_use/lu/non_contiguous_blocks_put1
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
AllFormulaNum:146530
SovingTimes:0
TotalNewPath:10
TotalOldPath:16
TotalPath:26
allGlobal:1749.9
brGlobal:1749.9
AllBranch:0
satBranch:0
satCost:0
unSatBranch:0
unSatCost:0
uunSatBranch:0
SolvingCost:9864.51
RunningCost:2.80787
inputCost:0.52053
def-use size:261
TimeCost:9.870533e+03
Insts:1163878
totalline:1180
name:non_contiguous_blocks_put1



#/home/icefox/git/Benchmarks/def_use/pcopy-1.5
- 运行命令:
	klee pcopy.o ./infile ./outfile 
只是一个复制程序
AllFormulaNum:9608
SovingTimes:0
TotalNewPath:6
TotalOldPath:17
TotalPath:23
allGlobal:178.667
brGlobal:178.667
AllBranch:0
satBranch:0
satCost:0
unSatBranch:0
unSatCost:0
uunSatBranch:0
SolvingCost:476.396
RunningCost:1.46492
inputCost:0.3666
def-use size:65
TimeCost:4.815337e+02
Insts:59414
totalline:537
name:pcopy-1.5



#/home/icefox/git/Benchmarks/def_use/pfscan/pfscan
- 运行命令:
	klee pfscan-1.0.o -V 3 ${PWD}/file/ 
pfscan-1.0.c中使用了系统ftw函数来便利目录，llvm外部调用出错。
写了一个遍历目录的函数来进行替换，替换之后可在klee上执行。
free函数无法使用，原因与klee的约束求解有关，需要进一步研究。
注释free函数不影响该程序的执行。(尚未提交的版本中该问题已经修复，不过需要进一步测试，暂时请注释所有的free函数)
运行时不能使用dfs模式，要使用bfs模式，原因见源程序967行。
pqueue_close执行过晚将导致所有子线程等待，之后主线程在第974行进入等待，没有子线程能够唤醒，因此死锁。
使用绝对路径。
AllFormulaNum:2970
SovingTimes:0
TotalNewPath:3
TotalOldPath:5
TotalPath:8
allGlobal:557
brGlobal:557
AllBranch:0
satBranch:0
satCost:0
unSatBranch:0
unSatCost:0
uunSatBranch:0
SolvingCost:1.27862
RunningCost:0.193744
inputCost:0.041745
def-use size:32
TimeCost:1.691122e+00
Insts:64618
totalline:982
name:pfscan



#/home/icefox/git/Benchmarks/def_use/qsort.comb
- 运行命令:
	klee qsort.comb.o 
qsort.comb.c中并行qsort调用了系统qsort函数，llvm外部调用过程中出错。写了一个qsort用于替换，该qsort与系统qsort接口一致。

totalline:709
name:qsort.comb



#/home/icefox/git/Benchmarks/def_use/qsort.new
- 运行命令:
	klee qsort.int.o 
只是一个排序程序
totalline:669
name:qsort.new



#/home/icefox/git/Benchmarks/def_use/queue/queue_put
- 运行命令:
	klee queue_ok.o 

AllFormulaNum:1162
SovingTimes:0
TotalNewPath:2
TotalOldPath:1
TotalPath:3
allGlobal:40
brGlobal:40
AllBranch:0
satBranch:0
satCost:0
unSatBranch:0
unSatCost:0
uunSatBranch:0
SolvingCost:0.142485
RunningCost:0.008049
inputCost:0.001914
def-use size:40
TimeCost:1.663120e-01
Insts:2752
totalline:129
name:queue_put



#/home/icefox/git/Benchmarks/def_use/radix/radix
- 运行命令:
	klee RADIX 
1.本程序实现了基数排序算法，参数已经作为默认值写入，直接运行即可。
- 参数
```c
#define DEFAULT_P                    2    ﻿//线程的数目
#define DEFAULT_N                    2    ﻿//排序的数字的数目
#define DEFAULT_R                    2     ﻿//基数的数目
#define DEFAULT_M                    2    ﻿//排序的数字的最大值
```
totalline:1559
name:radix



#/home/icefox/git/Benchmarks/def_use/stack/stack_put
- 运行命令:
	klee stack_ok.o 

AllFormulaNum:71625
SovingTimes:0
TotalNewPath:62
TotalOldPath:266
TotalPath:328
allGlobal:37.8226
brGlobal:37.8226
AllBranch:0
satBranch:0
satCost:0
unSatBranch:0
unSatCost:0
uunSatBranch:0
SolvingCost:39.087
RunningCost:0.631293
inputCost:0.063497
def-use size:20
TimeCost:4.008511e+01
Insts:170140
totalline:82
name:stack_put



#/home/icefox/git/Benchmarks/def_use/swarm/swarm
- 运行命令:
	klee swarm_isort64.revised.o 
1.本程序实现了基数排序算法，参数已经作为默认值写入，直接运行即可。
2.此程序根据线程数量，单独分配内存空间，每次创建线程用不同的参数。
参数的初始化工作为main函数完成，所以不存在BUG Multi threads read and write global id without locks.
5.程序计算函数为radixsort_swarm_s3();调用了两次countsort_swarm();
countsort_swarm()中的同步机制SWARM_Barrier()。
删除countsort_swarm()的SWARM_Barrier()会导致BUG;
AllFormulaNum:6930586
SovingTimes:0
TotalNewPath:2
TotalOldPath:2
TotalPath:4
allGlobal:1418
brGlobal:1418
AllBranch:0
satBranch:0
satCost:0
unSatBranch:0
unSatCost:0
uunSatBranch:0
SolvingCost:45.7748
RunningCost:0.344841
inputCost:0.929474
def-use size:169
TimeCost:4.870752e+01
Insts:107334
totalline:2260
name:swarm



