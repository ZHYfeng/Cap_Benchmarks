; ModuleID = 'blackscholes.m4.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.OptionData_ = type { float, float, float, float, float, float, i8, float, float }
%union.pthread_mutexattr_t = type { i32 }
%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%union.pthread_attr_t = type { i64, [48 x i8] }

@_M4_numThreads = global i32 128, align 4
@numError = global i32 0, align 4
@errorInput = global i32 0, align 4
@numOptions = common global i32 0, align 4
@nThreads = common global i32 0, align 4
@sptprice = common global float* null, align 8
@strike = common global float* null, align 8
@rate = common global float* null, align 8
@volatility = common global float* null, align 8
@otime = common global float* null, align 8
@otype = common global i32* null, align 8
@prices = common global float* null, align 8
@.str = private unnamed_addr constant [24 x i8] c"PARSEC Benchmark Suite\0A\00", align 1
@.str1 = private unnamed_addr constant [48 x i8] c"Usage:\0A\09%s <nthreads> <inputFile> <outputFile>\0A\00", align 1
@.str2 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str3 = private unnamed_addr constant [32 x i8] c"ERROR: Unable to open file %s.\0A\00", align 1
@.str4 = private unnamed_addr constant [3 x i8] c"%i\00", align 1
@.str5 = private unnamed_addr constant [37 x i8] c"ERROR: Unable to read from file %s.\0A\00", align 1
@.str6 = private unnamed_addr constant [82 x i8] c"WARNING: Not enough work, reducing number of threads to match number of options.\0A\00", align 1
@data = common global %struct.OptionData_* null, align 8
@.str7 = private unnamed_addr constant [27 x i8] c"%f %f %f %f %f %f %c %f %f\00", align 1
@.str8 = private unnamed_addr constant [33 x i8] c"ERROR: Unable to close file %s.\0A\00", align 1
@_M4_normalMutexAttr = common global %union.pthread_mutexattr_t zeroinitializer, align 4
@_M4_threadsTableAllocated = common global [128 x i32] zeroinitializer, align 16
@.str9 = private unnamed_addr constant [20 x i8] c"Num of Options: %d\0A\00", align 1
@.str10 = private unnamed_addr constant [17 x i8] c"Num of Runs: %d\0A\00", align 1
@.str11 = private unnamed_addr constant [18 x i8] c"Size of data: %d\0A\00", align 1
@_M4_threadsTable = common global [128 x i64] zeroinitializer, align 16
@.str12 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str13 = private unnamed_addr constant [4 x i8] c"%i\0A\00", align 1
@.str14 = private unnamed_addr constant [36 x i8] c"ERROR: Unable to write to file %s.\0A\00", align 1
@.str15 = private unnamed_addr constant [7 x i8] c"%.18f\0A\00", align 1
@.str16 = private unnamed_addr constant [22 x i8] c"klee_div_zero_check.c\00", align 1
@.str117 = private unnamed_addr constant [15 x i8] c"divide by zero\00", align 1
@.str218 = private unnamed_addr constant [8 x i8] c"div.err\00", align 1
@.str319 = private unnamed_addr constant [8 x i8] c"IGNORED\00", align 1
@.str1420 = private unnamed_addr constant [16 x i8] c"overshift error\00", align 1
@.str25 = private unnamed_addr constant [14 x i8] c"overshift.err\00", align 1
@.str621 = private unnamed_addr constant [13 x i8] c"klee_range.c\00", align 1
@.str17 = private unnamed_addr constant [14 x i8] c"invalid range\00", align 1
@.str28 = private unnamed_addr constant [5 x i8] c"user\00", align 1

; Function Attrs: nounwind uwtable
define float @CNDF(float %InputX) #0 {
entry:
  %InputX.addr = alloca float, align 4
  %sign = alloca i32, align 4
  %OutputX = alloca float, align 4
  %xInput = alloca float, align 4
  %xNPrimeofX = alloca float, align 4
  %expValues = alloca float, align 4
  %xK2 = alloca float, align 4
  %xK2_2 = alloca float, align 4
  %xK2_3 = alloca float, align 4
  %xK2_4 = alloca float, align 4
  %xK2_5 = alloca float, align 4
  %xLocal = alloca float, align 4
  %xLocal_1 = alloca float, align 4
  %xLocal_2 = alloca float, align 4
  %xLocal_3 = alloca float, align 4
  store float %InputX, float* %InputX.addr, align 4
  %0 = load float* %InputX.addr, align 4, !dbg !182
  %conv = fpext float %0 to double, !dbg !182
  %cmp = fcmp olt double %conv, 0.000000e+00, !dbg !182
  br i1 %cmp, label %if.then, label %if.else, !dbg !182

if.then:                                          ; preds = %entry
  %1 = load float* %InputX.addr, align 4, !dbg !183
  %sub = fsub float -0.000000e+00, %1, !dbg !183
  store float %sub, float* %InputX.addr, align 4, !dbg !183
  store i32 1, i32* %sign, align 4, !dbg !185
  br label %if.end, !dbg !186

if.else:                                          ; preds = %entry
  store i32 0, i32* %sign, align 4, !dbg !187
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %2 = load float* %InputX.addr, align 4, !dbg !188
  store float %2, float* %xInput, align 4, !dbg !188
  %3 = load float* %InputX.addr, align 4, !dbg !189
  %mul = fmul float -5.000000e-01, %3, !dbg !189
  %4 = load float* %InputX.addr, align 4, !dbg !189
  %mul2 = fmul float %mul, %4, !dbg !189
  %conv3 = fpext float %mul2 to double, !dbg !189
  %call = call double @exp(double %conv3) #8, !dbg !189
  %conv4 = fptrunc double %call to float, !dbg !189
  store float %conv4, float* %expValues, align 4, !dbg !189
  %5 = load float* %expValues, align 4, !dbg !190
  store float %5, float* %xNPrimeofX, align 4, !dbg !190
  %6 = load float* %xNPrimeofX, align 4, !dbg !191
  %conv5 = fpext float %6 to double, !dbg !191
  %mul6 = fmul double %conv5, 0x3FD9884533D43651, !dbg !191
  %conv7 = fptrunc double %mul6 to float, !dbg !191
  store float %conv7, float* %xNPrimeofX, align 4, !dbg !191
  %7 = load float* %xInput, align 4, !dbg !192
  %conv8 = fpext float %7 to double, !dbg !192
  %mul9 = fmul double 2.316419e-01, %conv8, !dbg !192
  %conv10 = fptrunc double %mul9 to float, !dbg !192
  store float %conv10, float* %xK2, align 4, !dbg !192
  %8 = load float* %xK2, align 4, !dbg !193
  %conv11 = fpext float %8 to double, !dbg !193
  %add = fadd double 1.000000e+00, %conv11, !dbg !193
  %conv12 = fptrunc double %add to float, !dbg !193
  store float %conv12, float* %xK2, align 4, !dbg !193
  %9 = load float* %xK2, align 4, !dbg !194
  %conv13 = fpext float %9 to double, !dbg !194
  %div = fdiv double 1.000000e+00, %conv13, !dbg !194
  %conv14 = fptrunc double %div to float, !dbg !194
  store float %conv14, float* %xK2, align 4, !dbg !194
  %10 = load float* %xK2, align 4, !dbg !195
  %11 = load float* %xK2, align 4, !dbg !195
  %mul15 = fmul float %10, %11, !dbg !195
  store float %mul15, float* %xK2_2, align 4, !dbg !195
  %12 = load float* %xK2_2, align 4, !dbg !196
  %13 = load float* %xK2, align 4, !dbg !196
  %mul16 = fmul float %12, %13, !dbg !196
  store float %mul16, float* %xK2_3, align 4, !dbg !196
  %14 = load float* %xK2_3, align 4, !dbg !197
  %15 = load float* %xK2, align 4, !dbg !197
  %mul17 = fmul float %14, %15, !dbg !197
  store float %mul17, float* %xK2_4, align 4, !dbg !197
  %16 = load float* %xK2_4, align 4, !dbg !198
  %17 = load float* %xK2, align 4, !dbg !198
  %mul18 = fmul float %16, %17, !dbg !198
  store float %mul18, float* %xK2_5, align 4, !dbg !198
  %18 = load float* %xK2, align 4, !dbg !199
  %conv19 = fpext float %18 to double, !dbg !199
  %mul20 = fmul double %conv19, 0x3FD470BF3A92F8EC, !dbg !199
  %conv21 = fptrunc double %mul20 to float, !dbg !199
  store float %conv21, float* %xLocal_1, align 4, !dbg !199
  %19 = load float* %xK2_2, align 4, !dbg !200
  %conv22 = fpext float %19 to double, !dbg !200
  %mul23 = fmul double %conv22, 0xBFD6D1F0E5A8325B, !dbg !200
  %conv24 = fptrunc double %mul23 to float, !dbg !200
  store float %conv24, float* %xLocal_2, align 4, !dbg !200
  %20 = load float* %xK2_3, align 4, !dbg !201
  %conv25 = fpext float %20 to double, !dbg !201
  %mul26 = fmul double %conv25, 0x3FFC80EF025F5E68, !dbg !201
  %conv27 = fptrunc double %mul26 to float, !dbg !201
  store float %conv27, float* %xLocal_3, align 4, !dbg !201
  %21 = load float* %xLocal_2, align 4, !dbg !202
  %22 = load float* %xLocal_3, align 4, !dbg !202
  %add28 = fadd float %21, %22, !dbg !202
  store float %add28, float* %xLocal_2, align 4, !dbg !202
  %23 = load float* %xK2_4, align 4, !dbg !203
  %conv29 = fpext float %23 to double, !dbg !203
  %mul30 = fmul double %conv29, 0xBFFD23DD4EF278D0, !dbg !203
  %conv31 = fptrunc double %mul30 to float, !dbg !203
  store float %conv31, float* %xLocal_3, align 4, !dbg !203
  %24 = load float* %xLocal_2, align 4, !dbg !204
  %25 = load float* %xLocal_3, align 4, !dbg !204
  %add32 = fadd float %24, %25, !dbg !204
  store float %add32, float* %xLocal_2, align 4, !dbg !204
  %26 = load float* %xK2_5, align 4, !dbg !205
  %conv33 = fpext float %26 to double, !dbg !205
  %mul34 = fmul double %conv33, 0x3FF548CDD6F42943, !dbg !205
  %conv35 = fptrunc double %mul34 to float, !dbg !205
  store float %conv35, float* %xLocal_3, align 4, !dbg !205
  %27 = load float* %xLocal_2, align 4, !dbg !206
  %28 = load float* %xLocal_3, align 4, !dbg !206
  %add36 = fadd float %27, %28, !dbg !206
  store float %add36, float* %xLocal_2, align 4, !dbg !206
  %29 = load float* %xLocal_2, align 4, !dbg !207
  %30 = load float* %xLocal_1, align 4, !dbg !207
  %add37 = fadd float %29, %30, !dbg !207
  store float %add37, float* %xLocal_1, align 4, !dbg !207
  %31 = load float* %xLocal_1, align 4, !dbg !208
  %32 = load float* %xNPrimeofX, align 4, !dbg !208
  %mul38 = fmul float %31, %32, !dbg !208
  store float %mul38, float* %xLocal, align 4, !dbg !208
  %33 = load float* %xLocal, align 4, !dbg !209
  %conv39 = fpext float %33 to double, !dbg !209
  %sub40 = fsub double 1.000000e+00, %conv39, !dbg !209
  %conv41 = fptrunc double %sub40 to float, !dbg !209
  store float %conv41, float* %xLocal, align 4, !dbg !209
  %34 = load float* %xLocal, align 4, !dbg !210
  store float %34, float* %OutputX, align 4, !dbg !210
  %35 = load i32* %sign, align 4, !dbg !211
  %tobool = icmp ne i32 %35, 0, !dbg !211
  br i1 %tobool, label %if.then42, label %if.end46, !dbg !211

if.then42:                                        ; preds = %if.end
  %36 = load float* %OutputX, align 4, !dbg !212
  %conv43 = fpext float %36 to double, !dbg !212
  %sub44 = fsub double 1.000000e+00, %conv43, !dbg !212
  %conv45 = fptrunc double %sub44 to float, !dbg !212
  store float %conv45, float* %OutputX, align 4, !dbg !212
  br label %if.end46, !dbg !214

if.end46:                                         ; preds = %if.then42, %if.end
  %37 = load float* %OutputX, align 4, !dbg !215
  ret float %37, !dbg !215
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

; Function Attrs: nounwind
declare double @exp(double) #2

; Function Attrs: nounwind uwtable
define float @BlkSchlsEqEuroNoDiv(float %sptprice, float %strike, float %rate, float %volatility, float %time, i32 %otype, float %timet) #0 {
entry:
  %sptprice.addr = alloca float, align 4
  %strike.addr = alloca float, align 4
  %rate.addr = alloca float, align 4
  %volatility.addr = alloca float, align 4
  %time.addr = alloca float, align 4
  %otype.addr = alloca i32, align 4
  %timet.addr = alloca float, align 4
  %OptionPrice = alloca float, align 4
  %xStockPrice = alloca float, align 4
  %xStrikePrice = alloca float, align 4
  %xRiskFreeRate = alloca float, align 4
  %xVolatility = alloca float, align 4
  %xTime = alloca float, align 4
  %xSqrtTime = alloca float, align 4
  %logValues = alloca float, align 4
  %xLogTerm = alloca float, align 4
  %xD1 = alloca float, align 4
  %xD2 = alloca float, align 4
  %xPowerTerm = alloca float, align 4
  %xDen = alloca float, align 4
  %d1 = alloca float, align 4
  %d2 = alloca float, align 4
  %FutureValueX = alloca float, align 4
  %NofXd1 = alloca float, align 4
  %NofXd2 = alloca float, align 4
  %NegNofXd1 = alloca float, align 4
  %NegNofXd2 = alloca float, align 4
  store float %sptprice, float* %sptprice.addr, align 4
  store float %strike, float* %strike.addr, align 4
  store float %rate, float* %rate.addr, align 4
  store float %volatility, float* %volatility.addr, align 4
  store float %time, float* %time.addr, align 4
  store i32 %otype, i32* %otype.addr, align 4
  store float %timet, float* %timet.addr, align 4
  %0 = load float* %sptprice.addr, align 4, !dbg !216
  store float %0, float* %xStockPrice, align 4, !dbg !216
  %1 = load float* %strike.addr, align 4, !dbg !217
  store float %1, float* %xStrikePrice, align 4, !dbg !217
  %2 = load float* %rate.addr, align 4, !dbg !218
  store float %2, float* %xRiskFreeRate, align 4, !dbg !218
  %3 = load float* %volatility.addr, align 4, !dbg !219
  store float %3, float* %xVolatility, align 4, !dbg !219
  %4 = load float* %time.addr, align 4, !dbg !220
  store float %4, float* %xTime, align 4, !dbg !220
  %5 = load float* %xTime, align 4, !dbg !221
  %conv = fpext float %5 to double, !dbg !221
  %call = call double @sqrt(double %conv) #8, !dbg !221
  %conv1 = fptrunc double %call to float, !dbg !221
  store float %conv1, float* %xSqrtTime, align 4, !dbg !221
  %6 = load float* %sptprice.addr, align 4, !dbg !222
  %7 = load float* %strike.addr, align 4, !dbg !222
  %div = fdiv float %6, %7, !dbg !222
  %conv2 = fpext float %div to double, !dbg !222
  %call3 = call double @log(double %conv2) #8, !dbg !222
  %conv4 = fptrunc double %call3 to float, !dbg !222
  store float %conv4, float* %logValues, align 4, !dbg !222
  %8 = load float* %logValues, align 4, !dbg !223
  store float %8, float* %xLogTerm, align 4, !dbg !223
  %9 = load float* %xVolatility, align 4, !dbg !224
  %10 = load float* %xVolatility, align 4, !dbg !224
  %mul = fmul float %9, %10, !dbg !224
  store float %mul, float* %xPowerTerm, align 4, !dbg !224
  %11 = load float* %xPowerTerm, align 4, !dbg !225
  %conv5 = fpext float %11 to double, !dbg !225
  %mul6 = fmul double %conv5, 5.000000e-01, !dbg !225
  %conv7 = fptrunc double %mul6 to float, !dbg !225
  store float %conv7, float* %xPowerTerm, align 4, !dbg !225
  %12 = load float* %xRiskFreeRate, align 4, !dbg !226
  %13 = load float* %xPowerTerm, align 4, !dbg !226
  %add = fadd float %12, %13, !dbg !226
  store float %add, float* %xD1, align 4, !dbg !226
  %14 = load float* %xD1, align 4, !dbg !227
  %15 = load float* %xTime, align 4, !dbg !227
  %mul8 = fmul float %14, %15, !dbg !227
  store float %mul8, float* %xD1, align 4, !dbg !227
  %16 = load float* %xD1, align 4, !dbg !228
  %17 = load float* %xLogTerm, align 4, !dbg !228
  %add9 = fadd float %16, %17, !dbg !228
  store float %add9, float* %xD1, align 4, !dbg !228
  %18 = load float* %xVolatility, align 4, !dbg !229
  %19 = load float* %xSqrtTime, align 4, !dbg !229
  %mul10 = fmul float %18, %19, !dbg !229
  store float %mul10, float* %xDen, align 4, !dbg !229
  %20 = load float* %xD1, align 4, !dbg !230
  %21 = load float* %xDen, align 4, !dbg !230
  %div11 = fdiv float %20, %21, !dbg !230
  store float %div11, float* %xD1, align 4, !dbg !230
  %22 = load float* %xD1, align 4, !dbg !231
  %23 = load float* %xDen, align 4, !dbg !231
  %sub = fsub float %22, %23, !dbg !231
  store float %sub, float* %xD2, align 4, !dbg !231
  %24 = load float* %xD1, align 4, !dbg !232
  store float %24, float* %d1, align 4, !dbg !232
  %25 = load float* %xD2, align 4, !dbg !233
  store float %25, float* %d2, align 4, !dbg !233
  %26 = load float* %d1, align 4, !dbg !234
  %call12 = call float @CNDF(float %26), !dbg !234
  store float %call12, float* %NofXd1, align 4, !dbg !234
  %27 = load float* %d2, align 4, !dbg !235
  %call13 = call float @CNDF(float %27), !dbg !235
  store float %call13, float* %NofXd2, align 4, !dbg !235
  %28 = load float* %strike.addr, align 4, !dbg !236
  %conv14 = fpext float %28 to double, !dbg !236
  %29 = load float* %rate.addr, align 4, !dbg !236
  %sub15 = fsub float -0.000000e+00, %29, !dbg !236
  %30 = load float* %time.addr, align 4, !dbg !236
  %mul16 = fmul float %sub15, %30, !dbg !236
  %conv17 = fpext float %mul16 to double, !dbg !236
  %call18 = call double @exp(double %conv17) #8, !dbg !236
  %mul19 = fmul double %conv14, %call18, !dbg !236
  %conv20 = fptrunc double %mul19 to float, !dbg !236
  store float %conv20, float* %FutureValueX, align 4, !dbg !236
  %31 = load i32* %otype.addr, align 4, !dbg !237
  %cmp = icmp eq i32 %31, 0, !dbg !237
  br i1 %cmp, label %if.then, label %if.else, !dbg !237

if.then:                                          ; preds = %entry
  %32 = load float* %sptprice.addr, align 4, !dbg !238
  %33 = load float* %NofXd1, align 4, !dbg !238
  %mul22 = fmul float %32, %33, !dbg !238
  %34 = load float* %FutureValueX, align 4, !dbg !238
  %35 = load float* %NofXd2, align 4, !dbg !238
  %mul23 = fmul float %34, %35, !dbg !238
  %sub24 = fsub float %mul22, %mul23, !dbg !238
  store float %sub24, float* %OptionPrice, align 4, !dbg !238
  br label %if.end, !dbg !240

if.else:                                          ; preds = %entry
  %36 = load float* %NofXd1, align 4, !dbg !241
  %conv25 = fpext float %36 to double, !dbg !241
  %sub26 = fsub double 1.000000e+00, %conv25, !dbg !241
  %conv27 = fptrunc double %sub26 to float, !dbg !241
  store float %conv27, float* %NegNofXd1, align 4, !dbg !241
  %37 = load float* %NofXd2, align 4, !dbg !243
  %conv28 = fpext float %37 to double, !dbg !243
  %sub29 = fsub double 1.000000e+00, %conv28, !dbg !243
  %conv30 = fptrunc double %sub29 to float, !dbg !243
  store float %conv30, float* %NegNofXd2, align 4, !dbg !243
  %38 = load float* %FutureValueX, align 4, !dbg !244
  %39 = load float* %NegNofXd2, align 4, !dbg !244
  %mul31 = fmul float %38, %39, !dbg !244
  %40 = load float* %sptprice.addr, align 4, !dbg !244
  %41 = load float* %NegNofXd1, align 4, !dbg !244
  %mul32 = fmul float %40, %41, !dbg !244
  %sub33 = fsub float %mul31, %mul32, !dbg !244
  store float %sub33, float* %OptionPrice, align 4, !dbg !244
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %42 = load float* %OptionPrice, align 4, !dbg !245
  ret float %42, !dbg !245
}

; Function Attrs: nounwind
declare double @sqrt(double) #2

; Function Attrs: nounwind
declare double @log(double) #2

; Function Attrs: nounwind uwtable
define i32 @bs_thread(i8* %tid_ptr) #0 {
entry:
  %tid_ptr.addr = alloca i8*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %price = alloca float, align 4
  %priceDelta = alloca float, align 4
  %tid = alloca i32, align 4
  %start = alloca i32, align 4
  %end = alloca i32, align 4
  store i8* %tid_ptr, i8** %tid_ptr.addr, align 8
  %0 = load i8** %tid_ptr.addr, align 8, !dbg !246
  %1 = bitcast i8* %0 to i32*, !dbg !246
  %2 = load i32* %1, align 4, !dbg !246
  store i32 %2, i32* %tid, align 4, !dbg !246
  %3 = load i32* %tid, align 4, !dbg !247
  %4 = load i32* @numOptions, align 4, !dbg !247
  %5 = load i32* @nThreads, align 4, !dbg !247
  %int_cast_to_i64 = zext i32 %5 to i64
  call void @klee_div_zero_check(i64 %int_cast_to_i64), !dbg !247
  %div = sdiv i32 %4, %5, !dbg !247
  %mul = mul nsw i32 %3, %div, !dbg !247
  store i32 %mul, i32* %start, align 4, !dbg !247
  %6 = load i32* %start, align 4, !dbg !248
  %7 = load i32* @numOptions, align 4, !dbg !248
  %8 = load i32* @nThreads, align 4, !dbg !248
  %int_cast_to_i641 = zext i32 %8 to i64
  call void @klee_div_zero_check(i64 %int_cast_to_i641), !dbg !248
  %div1 = sdiv i32 %7, %8, !dbg !248
  %add = add nsw i32 %6, %div1, !dbg !248
  store i32 %add, i32* %end, align 4, !dbg !248
  %9 = load i32* @errorInput, align 4, !dbg !249
  %tobool = icmp ne i32 %9, 0, !dbg !249
  br i1 %tobool, label %if.then, label %if.end, !dbg !249

if.then:                                          ; preds = %entry
  store i32 0, i32* %j, align 4, !dbg !250
  br label %for.cond, !dbg !250

for.cond:                                         ; preds = %for.inc17, %if.then
  %10 = load i32* %j, align 4, !dbg !250
  %cmp = icmp slt i32 %10, 3, !dbg !250
  br i1 %cmp, label %for.body, label %if.end, !dbg !250

for.body:                                         ; preds = %for.cond
  %11 = load i32* %start, align 4, !dbg !253
  store i32 %11, i32* %i, align 4, !dbg !253
  br label %for.cond2, !dbg !253

for.cond2:                                        ; preds = %for.body4, %for.body
  %12 = load i32* %i, align 4, !dbg !253
  %13 = load i32* %end, align 4, !dbg !253
  %cmp3 = icmp slt i32 %12, %13, !dbg !253
  br i1 %cmp3, label %for.body4, label %for.inc17, !dbg !253

for.body4:                                        ; preds = %for.cond2
  %14 = load i32* %i, align 4, !dbg !256
  %idxprom = sext i32 %14 to i64, !dbg !256
  %15 = load float** @sptprice, align 8, !dbg !256
  %arrayidx = getelementptr inbounds float* %15, i64 %idxprom, !dbg !256
  %16 = load float* %arrayidx, align 4, !dbg !256
  %17 = load i32* %i, align 4, !dbg !256
  %idxprom5 = sext i32 %17 to i64, !dbg !256
  %18 = load float** @strike, align 8, !dbg !256
  %arrayidx6 = getelementptr inbounds float* %18, i64 %idxprom5, !dbg !256
  %19 = load float* %arrayidx6, align 4, !dbg !256
  %20 = load i32* %i, align 4, !dbg !256
  %idxprom7 = sext i32 %20 to i64, !dbg !256
  %21 = load float** @rate, align 8, !dbg !256
  %arrayidx8 = getelementptr inbounds float* %21, i64 %idxprom7, !dbg !256
  %22 = load float* %arrayidx8, align 4, !dbg !256
  %23 = load i32* %i, align 4, !dbg !256
  %idxprom9 = sext i32 %23 to i64, !dbg !256
  %24 = load float** @volatility, align 8, !dbg !256
  %arrayidx10 = getelementptr inbounds float* %24, i64 %idxprom9, !dbg !256
  %25 = load float* %arrayidx10, align 4, !dbg !256
  %26 = load i32* %i, align 4, !dbg !256
  %idxprom11 = sext i32 %26 to i64, !dbg !256
  %27 = load float** @otime, align 8, !dbg !256
  %arrayidx12 = getelementptr inbounds float* %27, i64 %idxprom11, !dbg !256
  %28 = load float* %arrayidx12, align 4, !dbg !256
  %29 = load i32* %i, align 4, !dbg !256
  %idxprom13 = sext i32 %29 to i64, !dbg !256
  %30 = load i32** @otype, align 8, !dbg !256
  %arrayidx14 = getelementptr inbounds i32* %30, i64 %idxprom13, !dbg !256
  %31 = load i32* %arrayidx14, align 4, !dbg !256
  %call = call float @BlkSchlsEqEuroNoDiv(float %16, float %19, float %22, float %25, float %28, i32 %31, float 0.000000e+00), !dbg !256
  store float %call, float* %price, align 4, !dbg !256
  %32 = load float* %price, align 4, !dbg !258
  %33 = load i32* %i, align 4, !dbg !258
  %idxprom15 = sext i32 %33 to i64, !dbg !258
  %34 = load float** @prices, align 8, !dbg !258
  %arrayidx16 = getelementptr inbounds float* %34, i64 %idxprom15, !dbg !258
  store float %32, float* %arrayidx16, align 4, !dbg !258
  %35 = load i32* %i, align 4, !dbg !253
  %inc = add nsw i32 %35, 1, !dbg !253
  store i32 %inc, i32* %i, align 4, !dbg !253
  br label %for.cond2, !dbg !253

for.inc17:                                        ; preds = %for.cond2
  %36 = load i32* %j, align 4, !dbg !250
  %inc18 = add nsw i32 %36, 1, !dbg !250
  store i32 %inc18, i32* %j, align 4, !dbg !250
  br label %for.cond, !dbg !250

if.end:                                           ; preds = %for.cond, %entry
  %37 = load i32* %tid, align 4, !dbg !259
  store i32 %37, i32* @errorInput, align 4, !dbg !259
  ret i32 1, !dbg !260
}

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %file = alloca %struct._IO_FILE*, align 8
  %i = alloca i32, align 4
  %loopnum = alloca i32, align 4
  %buffer = alloca float*, align 8
  %buffer2 = alloca i32*, align 8
  %rv = alloca i32, align 4
  %inputFile = alloca i8*, align 8
  %outputFile = alloca i8*, align 8
  %_M4_i = alloca i32, align 4
  %tids = alloca i32*, align 8
  %_M4_i144 = alloca i32, align 4
  %_M4_i168 = alloca i32, align 4
  %_M4_ret = alloca i8*, align 8
  store i32 0, i32* %retval
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 8
  %call = call i32 (i32*, ...)* bitcast (i32 (...)* @make_input to i32 (i32*, ...)*)(i32* @errorInput), !dbg !261
  %call1 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([24 x i8]* @.str, i32 0, i32 0)), !dbg !262
  %call2 = call i32 @fflush(%struct._IO_FILE* null), !dbg !263
  %0 = load i32* %argc.addr, align 4, !dbg !264
  %cmp = icmp ne i32 %0, 4, !dbg !264
  %1 = load i8*** %argv.addr, align 8, !dbg !265
  br i1 %cmp, label %if.then, label %if.end, !dbg !264

if.then:                                          ; preds = %entry
  %arrayidx = getelementptr inbounds i8** %1, i64 0, !dbg !265
  %2 = load i8** %arrayidx, align 8, !dbg !265
  %call3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([48 x i8]* @.str1, i32 0, i32 0), i8* %2), !dbg !265
  store i32 1, i32* %retval, !dbg !267
  br label %return, !dbg !267

if.end:                                           ; preds = %entry
  %arrayidx4 = getelementptr inbounds i8** %1, i64 1, !dbg !268
  %3 = load i8** %arrayidx4, align 8, !dbg !268
  %call5 = call i32 @atoi(i8* %3) #9, !dbg !268
  store i32 %call5, i32* @nThreads, align 4, !dbg !268
  %4 = load i8*** %argv.addr, align 8, !dbg !269
  %arrayidx6 = getelementptr inbounds i8** %4, i64 2, !dbg !269
  %5 = load i8** %arrayidx6, align 8, !dbg !269
  store i8* %5, i8** %inputFile, align 8, !dbg !269
  %6 = load i8*** %argv.addr, align 8, !dbg !270
  %arrayidx7 = getelementptr inbounds i8** %6, i64 3, !dbg !270
  %7 = load i8** %arrayidx7, align 8, !dbg !270
  store i8* %7, i8** %outputFile, align 8, !dbg !270
  %8 = load i8** %inputFile, align 8, !dbg !271
  %call8 = call %struct._IO_FILE* @fopen(i8* %8, i8* getelementptr inbounds ([2 x i8]* @.str2, i32 0, i32 0)), !dbg !271
  store %struct._IO_FILE* %call8, %struct._IO_FILE** %file, align 8, !dbg !271
  %9 = load %struct._IO_FILE** %file, align 8, !dbg !272
  %cmp9 = icmp eq %struct._IO_FILE* %9, null, !dbg !272
  br i1 %cmp9, label %if.then10, label %if.end12, !dbg !272

if.then10:                                        ; preds = %if.end
  %10 = load i8** %inputFile, align 8, !dbg !273
  %call11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([32 x i8]* @.str3, i32 0, i32 0), i8* %10), !dbg !273
  store i32 1, i32* %retval, !dbg !275
  br label %return, !dbg !275

if.end12:                                         ; preds = %if.end
  %11 = load %struct._IO_FILE** %file, align 8, !dbg !276
  %call13 = call i32 (%struct._IO_FILE*, i8*, ...)* @__isoc99_fscanf(%struct._IO_FILE* %11, i8* getelementptr inbounds ([3 x i8]* @.str4, i32 0, i32 0), i32* @numOptions), !dbg !276
  store i32 %call13, i32* %rv, align 4, !dbg !276
  %12 = load i32* %rv, align 4, !dbg !277
  %cmp14 = icmp ne i32 %12, 1, !dbg !277
  br i1 %cmp14, label %if.then15, label %if.end18, !dbg !277

if.then15:                                        ; preds = %if.end12
  %13 = load i8** %inputFile, align 8, !dbg !278
  %call16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([37 x i8]* @.str5, i32 0, i32 0), i8* %13), !dbg !278
  %14 = load %struct._IO_FILE** %file, align 8, !dbg !280
  %call17 = call i32 @fclose(%struct._IO_FILE* %14), !dbg !280
  store i32 1, i32* %retval, !dbg !281
  br label %return, !dbg !281

if.end18:                                         ; preds = %if.end12
  %15 = load i32* @nThreads, align 4, !dbg !282
  %16 = load i32* @numOptions, align 4, !dbg !282
  %cmp19 = icmp sgt i32 %15, %16, !dbg !282
  br i1 %cmp19, label %if.then20, label %if.end22, !dbg !282

if.then20:                                        ; preds = %if.end18
  %call21 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([82 x i8]* @.str6, i32 0, i32 0)), !dbg !283
  %17 = load i32* @numOptions, align 4, !dbg !285
  store i32 %17, i32* @nThreads, align 4, !dbg !285
  br label %if.end22, !dbg !286

if.end22:                                         ; preds = %if.then20, %if.end18
  %18 = load i32* @numOptions, align 4, !dbg !287
  %conv = sext i32 %18 to i64, !dbg !287
  %mul = mul i64 %conv, 36, !dbg !287
  %call23 = call noalias i8* @malloc(i64 %mul) #8, !dbg !287
  %19 = bitcast i8* %call23 to %struct.OptionData_*, !dbg !287
  store %struct.OptionData_* %19, %struct.OptionData_** @data, align 8, !dbg !287
  %20 = load i32* @numOptions, align 4, !dbg !288
  %conv24 = sext i32 %20 to i64, !dbg !288
  %mul25 = mul i64 %conv24, 4, !dbg !288
  %call26 = call noalias i8* @malloc(i64 %mul25) #8, !dbg !288
  %21 = bitcast i8* %call26 to float*, !dbg !288
  store float* %21, float** @prices, align 8, !dbg !288
  store i32 0, i32* %loopnum, align 4, !dbg !289
  br label %for.cond, !dbg !289

for.cond:                                         ; preds = %for.inc, %if.end22
  %22 = load i32* %loopnum, align 4, !dbg !289
  %23 = load i32* @numOptions, align 4, !dbg !289
  %cmp27 = icmp slt i32 %22, %23, !dbg !289
  %24 = load %struct._IO_FILE** %file, align 8, !dbg !291
  br i1 %cmp27, label %for.body, label %for.end, !dbg !289

for.body:                                         ; preds = %for.cond
  %25 = load i32* %loopnum, align 4, !dbg !291
  %idxprom = sext i32 %25 to i64, !dbg !291
  %26 = load %struct.OptionData_** @data, align 8, !dbg !291
  %arrayidx29 = getelementptr inbounds %struct.OptionData_* %26, i64 %idxprom, !dbg !291
  %s = getelementptr inbounds %struct.OptionData_* %arrayidx29, i32 0, i32 0, !dbg !291
  %27 = load i32* %loopnum, align 4, !dbg !291
  %idxprom30 = sext i32 %27 to i64, !dbg !291
  %28 = load %struct.OptionData_** @data, align 8, !dbg !291
  %arrayidx31 = getelementptr inbounds %struct.OptionData_* %28, i64 %idxprom30, !dbg !291
  %strike = getelementptr inbounds %struct.OptionData_* %arrayidx31, i32 0, i32 1, !dbg !291
  %29 = load i32* %loopnum, align 4, !dbg !291
  %idxprom32 = sext i32 %29 to i64, !dbg !291
  %30 = load %struct.OptionData_** @data, align 8, !dbg !291
  %arrayidx33 = getelementptr inbounds %struct.OptionData_* %30, i64 %idxprom32, !dbg !291
  %r = getelementptr inbounds %struct.OptionData_* %arrayidx33, i32 0, i32 2, !dbg !291
  %31 = load i32* %loopnum, align 4, !dbg !291
  %idxprom34 = sext i32 %31 to i64, !dbg !291
  %32 = load %struct.OptionData_** @data, align 8, !dbg !291
  %arrayidx35 = getelementptr inbounds %struct.OptionData_* %32, i64 %idxprom34, !dbg !291
  %divq = getelementptr inbounds %struct.OptionData_* %arrayidx35, i32 0, i32 3, !dbg !291
  %33 = load i32* %loopnum, align 4, !dbg !291
  %idxprom36 = sext i32 %33 to i64, !dbg !291
  %34 = load %struct.OptionData_** @data, align 8, !dbg !291
  %arrayidx37 = getelementptr inbounds %struct.OptionData_* %34, i64 %idxprom36, !dbg !291
  %v = getelementptr inbounds %struct.OptionData_* %arrayidx37, i32 0, i32 4, !dbg !291
  %35 = load i32* %loopnum, align 4, !dbg !291
  %idxprom38 = sext i32 %35 to i64, !dbg !291
  %36 = load %struct.OptionData_** @data, align 8, !dbg !291
  %arrayidx39 = getelementptr inbounds %struct.OptionData_* %36, i64 %idxprom38, !dbg !291
  %t = getelementptr inbounds %struct.OptionData_* %arrayidx39, i32 0, i32 5, !dbg !291
  %37 = load i32* %loopnum, align 4, !dbg !291
  %idxprom40 = sext i32 %37 to i64, !dbg !291
  %38 = load %struct.OptionData_** @data, align 8, !dbg !291
  %arrayidx41 = getelementptr inbounds %struct.OptionData_* %38, i64 %idxprom40, !dbg !291
  %OptionType = getelementptr inbounds %struct.OptionData_* %arrayidx41, i32 0, i32 6, !dbg !291
  %39 = load i32* %loopnum, align 4, !dbg !291
  %idxprom42 = sext i32 %39 to i64, !dbg !291
  %40 = load %struct.OptionData_** @data, align 8, !dbg !291
  %arrayidx43 = getelementptr inbounds %struct.OptionData_* %40, i64 %idxprom42, !dbg !291
  %divs = getelementptr inbounds %struct.OptionData_* %arrayidx43, i32 0, i32 7, !dbg !291
  %41 = load i32* %loopnum, align 4, !dbg !291
  %idxprom44 = sext i32 %41 to i64, !dbg !291
  %42 = load %struct.OptionData_** @data, align 8, !dbg !291
  %arrayidx45 = getelementptr inbounds %struct.OptionData_* %42, i64 %idxprom44, !dbg !291
  %DGrefval = getelementptr inbounds %struct.OptionData_* %arrayidx45, i32 0, i32 8, !dbg !291
  %call46 = call i32 (%struct._IO_FILE*, i8*, ...)* @__isoc99_fscanf(%struct._IO_FILE* %24, i8* getelementptr inbounds ([27 x i8]* @.str7, i32 0, i32 0), float* %s, float* %strike, float* %r, float* %divq, float* %v, float* %t, i8* %OptionType, float* %d
  store i32 %call46, i32* %rv, align 4, !dbg !291
  %43 = load i32* %rv, align 4, !dbg !293
  %cmp47 = icmp ne i32 %43, 9, !dbg !293
  br i1 %cmp47, label %if.then49, label %for.inc, !dbg !293

if.then49:                                        ; preds = %for.body
  %44 = load i8** %inputFile, align 8, !dbg !294
  %call50 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([37 x i8]* @.str5, i32 0, i32 0), i8* %44), !dbg !294
  %45 = load %struct._IO_FILE** %file, align 8, !dbg !296
  %call51 = call i32 @fclose(%struct._IO_FILE* %45), !dbg !296
  store i32 1, i32* %retval, !dbg !297
  br label %return, !dbg !297

for.inc:                                          ; preds = %for.body
  %46 = load i32* %loopnum, align 4, !dbg !289
  %inc = add nsw i32 %46, 1, !dbg !289
  store i32 %inc, i32* %loopnum, align 4, !dbg !289
  br label %for.cond, !dbg !289

for.end:                                          ; preds = %for.cond
  %call53 = call i32 @fclose(%struct._IO_FILE* %24), !dbg !298
  store i32 %call53, i32* %rv, align 4, !dbg !298
  %47 = load i32* %rv, align 4, !dbg !299
  %cmp54 = icmp ne i32 %47, 0, !dbg !299
  br i1 %cmp54, label %if.then56, label %if.end58, !dbg !299

if.then56:                                        ; preds = %for.end
  %48 = load i8** %inputFile, align 8, !dbg !300
  %call57 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([33 x i8]* @.str8, i32 0, i32 0), i8* %48), !dbg !300
  store i32 1, i32* %retval, !dbg !302
  br label %return, !dbg !302

if.end58:                                         ; preds = %for.end
  %call59 = call i32 @pthread_mutexattr_init(%union.pthread_mutexattr_t* @_M4_normalMutexAttr) #8, !dbg !303
  %49 = load i32* @nThreads, align 4, !dbg !304
  store i32 %49, i32* @_M4_numThreads, align 4, !dbg !304
  store i32 0, i32* %_M4_i, align 4, !dbg !305
  br label %for.cond60, !dbg !305

for.cond60:                                       ; preds = %for.body63, %if.end58
  %50 = load i32* %_M4_i, align 4, !dbg !305
  %cmp61 = icmp slt i32 %50, 128, !dbg !305
  br i1 %cmp61, label %for.body63, label %for.end68, !dbg !305

for.body63:                                       ; preds = %for.cond60
  %51 = load i32* %_M4_i, align 4, !dbg !308
  %idxprom64 = sext i32 %51 to i64, !dbg !308
  %arrayidx65 = getelementptr inbounds [128 x i32]* @_M4_threadsTableAllocated, i32 0, i64 %idxprom64, !dbg !308
  store i32 0, i32* %arrayidx65, align 4, !dbg !308
  %52 = load i32* %_M4_i, align 4, !dbg !305
  %inc67 = add nsw i32 %52, 1, !dbg !305
  store i32 %inc67, i32* %_M4_i, align 4, !dbg !305
  br label %for.cond60, !dbg !305

for.end68:                                        ; preds = %for.cond60
  %53 = load i32* @errorInput, align 4, !dbg !310
  %cmp69 = icmp eq i32 %53, 2, !dbg !310
  br i1 %cmp69, label %if.then71, label %if.end74, !dbg !310

if.then71:                                        ; preds = %for.end68
  %54 = load i32* @numOptions, align 4, !dbg !311
  %call72 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str9, i32 0, i32 0), i32 %54), !dbg !311
  %call73 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([17 x i8]* @.str10, i32 0, i32 0), i32 3), !dbg !313
  br label %if.end74, !dbg !314

if.end74:                                         ; preds = %if.then71, %for.end68
  %55 = load i32* @numOptions, align 4, !dbg !315
  %mul75 = mul nsw i32 5, %55, !dbg !315
  %conv76 = sext i32 %mul75 to i64, !dbg !315
  %mul77 = mul i64 %conv76, 4, !dbg !315
  %add = add i64 %mul77, 256, !dbg !315
  %call78 = call noalias i8* @malloc(i64 %add) #8, !dbg !315
  %56 = bitcast i8* %call78 to float*, !dbg !315
  store float* %56, float** %buffer, align 8, !dbg !315
  %57 = load float** %buffer, align 8, !dbg !316
  %58 = ptrtoint float* %57 to i64, !dbg !316
  %add79 = add i64 %58, 256, !dbg !316
  %and = and i64 %add79, -64, !dbg !316
  %59 = inttoptr i64 %and to float*, !dbg !316
  store float* %59, float** @sptprice, align 8, !dbg !316
  %60 = load float** @sptprice, align 8, !dbg !317
  %61 = load i32* @numOptions, align 4, !dbg !317
  %idx.ext = sext i32 %61 to i64, !dbg !317
  %add.ptr = getelementptr inbounds float* %60, i64 %idx.ext, !dbg !317
  store float* %add.ptr, float** @strike, align 8, !dbg !317
  %62 = load float** @strike, align 8, !dbg !318
  %63 = load i32* @numOptions, align 4, !dbg !318
  %idx.ext80 = sext i32 %63 to i64, !dbg !318
  %add.ptr81 = getelementptr inbounds float* %62, i64 %idx.ext80, !dbg !318
  store float* %add.ptr81, float** @rate, align 8, !dbg !318
  %64 = load float** @rate, align 8, !dbg !319
  %65 = load i32* @numOptions, align 4, !dbg !319
  %idx.ext82 = sext i32 %65 to i64, !dbg !319
  %add.ptr83 = getelementptr inbounds float* %64, i64 %idx.ext82, !dbg !319
  store float* %add.ptr83, float** @volatility, align 8, !dbg !319
  %66 = load float** @volatility, align 8, !dbg !320
  %67 = load i32* @numOptions, align 4, !dbg !320
  %idx.ext84 = sext i32 %67 to i64, !dbg !320
  %add.ptr85 = getelementptr inbounds float* %66, i64 %idx.ext84, !dbg !320
  store float* %add.ptr85, float** @otime, align 8, !dbg !320
  %68 = load i32* @numOptions, align 4, !dbg !321
  %conv86 = sext i32 %68 to i64, !dbg !321
  %mul87 = mul i64 %conv86, 4, !dbg !321
  %add88 = add i64 %mul87, 256, !dbg !321
  %call89 = call noalias i8* @malloc(i64 %add88) #8, !dbg !321
  %69 = bitcast i8* %call89 to i32*, !dbg !321
  store i32* %69, i32** %buffer2, align 8, !dbg !321
  %70 = load i32** %buffer2, align 8, !dbg !322
  %71 = ptrtoint i32* %70 to i64, !dbg !322
  %add90 = add i64 %71, 256, !dbg !322
  %and91 = and i64 %add90, -64, !dbg !322
  %72 = inttoptr i64 %and91 to i32*, !dbg !322
  store i32* %72, i32** @otype, align 8, !dbg !322
  store i32 0, i32* %i, align 4, !dbg !323
  br label %for.cond92, !dbg !323

for.cond92:                                       ; preds = %for.body95, %if.end74
  %73 = load i32* %i, align 4, !dbg !323
  %74 = load i32* @numOptions, align 4, !dbg !323
  %cmp93 = icmp slt i32 %73, %74, !dbg !323
  br i1 %cmp93, label %for.body95, label %for.end131, !dbg !323

for.body95:                                       ; preds = %for.cond92
  %75 = load i32* %i, align 4, !dbg !325
  %idxprom96 = sext i32 %75 to i64, !dbg !325
  %76 = load %struct.OptionData_** @data, align 8, !dbg !325
  %arrayidx97 = getelementptr inbounds %struct.OptionData_* %76, i64 %idxprom96, !dbg !325
  %OptionType98 = getelementptr inbounds %struct.OptionData_* %arrayidx97, i32 0, i32 6, !dbg !325
  %77 = load i8* %OptionType98, align 1, !dbg !325
  %conv99 = sext i8 %77 to i32, !dbg !325
  %cmp100 = icmp eq i32 %conv99, 80, !dbg !325
  %cond = select i1 %cmp100, i32 1, i32 0, !dbg !325
  %78 = load i32* %i, align 4, !dbg !325
  %idxprom102 = sext i32 %78 to i64, !dbg !325
  %79 = load i32** @otype, align 8, !dbg !325
  %arrayidx103 = getelementptr inbounds i32* %79, i64 %idxprom102, !dbg !325
  store i32 %cond, i32* %arrayidx103, align 4, !dbg !325
  %80 = load i32* %i, align 4, !dbg !327
  %idxprom104 = sext i32 %80 to i64, !dbg !327
  %81 = load %struct.OptionData_** @data, align 8, !dbg !327
  %arrayidx105 = getelementptr inbounds %struct.OptionData_* %81, i64 %idxprom104, !dbg !327
  %s106 = getelementptr inbounds %struct.OptionData_* %arrayidx105, i32 0, i32 0, !dbg !327
  %82 = load float* %s106, align 4, !dbg !327
  %83 = load i32* %i, align 4, !dbg !327
  %idxprom107 = sext i32 %83 to i64, !dbg !327
  %84 = load float** @sptprice, align 8, !dbg !327
  %arrayidx108 = getelementptr inbounds float* %84, i64 %idxprom107, !dbg !327
  store float %82, float* %arrayidx108, align 4, !dbg !327
  %85 = load i32* %i, align 4, !dbg !328
  %idxprom109 = sext i32 %85 to i64, !dbg !328
  %86 = load %struct.OptionData_** @data, align 8, !dbg !328
  %arrayidx110 = getelementptr inbounds %struct.OptionData_* %86, i64 %idxprom109, !dbg !328
  %strike111 = getelementptr inbounds %struct.OptionData_* %arrayidx110, i32 0, i32 1, !dbg !328
  %87 = load float* %strike111, align 4, !dbg !328
  %88 = load i32* %i, align 4, !dbg !328
  %idxprom112 = sext i32 %88 to i64, !dbg !328
  %89 = load float** @strike, align 8, !dbg !328
  %arrayidx113 = getelementptr inbounds float* %89, i64 %idxprom112, !dbg !328
  store float %87, float* %arrayidx113, align 4, !dbg !328
  %90 = load i32* %i, align 4, !dbg !329
  %idxprom114 = sext i32 %90 to i64, !dbg !329
  %91 = load %struct.OptionData_** @data, align 8, !dbg !329
  %arrayidx115 = getelementptr inbounds %struct.OptionData_* %91, i64 %idxprom114, !dbg !329
  %r116 = getelementptr inbounds %struct.OptionData_* %arrayidx115, i32 0, i32 2, !dbg !329
  %92 = load float* %r116, align 4, !dbg !329
  %93 = load i32* %i, align 4, !dbg !329
  %idxprom117 = sext i32 %93 to i64, !dbg !329
  %94 = load float** @rate, align 8, !dbg !329
  %arrayidx118 = getelementptr inbounds float* %94, i64 %idxprom117, !dbg !329
  store float %92, float* %arrayidx118, align 4, !dbg !329
  %95 = load i32* %i, align 4, !dbg !330
  %idxprom119 = sext i32 %95 to i64, !dbg !330
  %96 = load %struct.OptionData_** @data, align 8, !dbg !330
  %arrayidx120 = getelementptr inbounds %struct.OptionData_* %96, i64 %idxprom119, !dbg !330
  %v121 = getelementptr inbounds %struct.OptionData_* %arrayidx120, i32 0, i32 4, !dbg !330
  %97 = load float* %v121, align 4, !dbg !330
  %98 = load i32* %i, align 4, !dbg !330
  %idxprom122 = sext i32 %98 to i64, !dbg !330
  %99 = load float** @volatility, align 8, !dbg !330
  %arrayidx123 = getelementptr inbounds float* %99, i64 %idxprom122, !dbg !330
  store float %97, float* %arrayidx123, align 4, !dbg !330
  %100 = load i32* %i, align 4, !dbg !331
  %idxprom124 = sext i32 %100 to i64, !dbg !331
  %101 = load %struct.OptionData_** @data, align 8, !dbg !331
  %arrayidx125 = getelementptr inbounds %struct.OptionData_* %101, i64 %idxprom124, !dbg !331
  %t126 = getelementptr inbounds %struct.OptionData_* %arrayidx125, i32 0, i32 5, !dbg !331
  %102 = load float* %t126, align 4, !dbg !331
  %103 = load i32* %i, align 4, !dbg !331
  %idxprom127 = sext i32 %103 to i64, !dbg !331
  %104 = load float** @otime, align 8, !dbg !331
  %arrayidx128 = getelementptr inbounds float* %104, i64 %idxprom127, !dbg !331
  store float %102, float* %arrayidx128, align 4, !dbg !331
  %105 = load i32* %i, align 4, !dbg !323
  %inc130 = add nsw i32 %105, 1, !dbg !323
  store i32 %inc130, i32* %i, align 4, !dbg !323
  br label %for.cond92, !dbg !323

for.end131:                                       ; preds = %for.cond92
  %106 = load i32* @numOptions, align 4, !dbg !332
  %conv132 = sext i32 %106 to i64, !dbg !332
  %mul133 = mul i64 %conv132, 40, !dbg !332
  %call134 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str11, i32 0, i32 0), i64 %mul133), !dbg !332
  %107 = load i32* @nThreads, align 4, !dbg !333
  %conv135 = sext i32 %107 to i64, !dbg !333
  %mul136 = mul i64 %conv135, 4, !dbg !333
  %call137 = call noalias i8* @malloc(i64 %mul136) #8, !dbg !333
  %108 = bitcast i8* %call137 to i32*, !dbg !333
  store i32* %108, i32** %tids, align 8, !dbg !333
  store i32 0, i32* %i, align 4, !dbg !334
  br label %for.cond138, !dbg !334

for.cond138:                                      ; preds = %for.end157, %for.end131
  %109 = load i32* %i, align 4, !dbg !334
  %110 = load i32* @nThreads, align 4, !dbg !334
  %cmp139 = icmp slt i32 %109, %110, !dbg !334
  br i1 %cmp139, label %for.body141, label %for.end167, !dbg !334

for.body141:                                      ; preds = %for.cond138
  %111 = load i32* %i, align 4, !dbg !336
  %112 = load i32* %i, align 4, !dbg !336
  %idxprom142 = sext i32 %112 to i64, !dbg !336
  %113 = load i32** %tids, align 8, !dbg !336
  %arrayidx143 = getelementptr inbounds i32* %113, i64 %idxprom142, !dbg !336
  store i32 %111, i32* %arrayidx143, align 4, !dbg !336
  store i32 0, i32* %_M4_i144, align 4, !dbg !338
  br label %for.cond145, !dbg !338

for.cond145:                                      ; preds = %for.inc155, %for.body141
  %114 = load i32* %_M4_i144, align 4, !dbg !338
  %cmp146 = icmp slt i32 %114, 128, !dbg !338
  br i1 %cmp146, label %for.body148, label %for.end157, !dbg !338

for.body148:                                      ; preds = %for.cond145
  %115 = load i32* %_M4_i144, align 4, !dbg !341
  %idxprom149 = sext i32 %115 to i64, !dbg !341
  %arrayidx150 = getelementptr inbounds [128 x i32]* @_M4_threadsTableAllocated, i32 0, i64 %idxprom149, !dbg !341
  %116 = load i32* %arrayidx150, align 4, !dbg !341
  %cmp151 = icmp eq i32 %116, 0, !dbg !341
  br i1 %cmp151, label %for.end157, label %for.inc155, !dbg !341

for.inc155:                                       ; preds = %for.body148
  %117 = load i32* %_M4_i144, align 4, !dbg !338
  %inc156 = add nsw i32 %117, 1, !dbg !338
  store i32 %inc156, i32* %_M4_i144, align 4, !dbg !338
  br label %for.cond145, !dbg !338

for.end157:                                       ; preds = %for.body148, %for.cond145
  %118 = load i32* %_M4_i144, align 4, !dbg !343
  %idxprom158 = sext i32 %118 to i64, !dbg !343
  %arrayidx159 = getelementptr inbounds [128 x i64]* @_M4_threadsTable, i32 0, i64 %idxprom158, !dbg !343
  %119 = load i32* %i, align 4, !dbg !343
  %idxprom160 = sext i32 %119 to i64, !dbg !343
  %120 = load i32** %tids, align 8, !dbg !343
  %arrayidx161 = getelementptr inbounds i32* %120, i64 %idxprom160, !dbg !343
  %121 = bitcast i32* %arrayidx161 to i8*, !dbg !343
  %call162 = call i32 @pthread_create(i64* %arrayidx159, %union.pthread_attr_t* null, i8* (i8*)* bitcast (i32 (i8*)* @bs_thread to i8* (i8*)*), i8* %121) #8, !dbg !343
  %122 = load i32* %_M4_i144, align 4, !dbg !344
  %idxprom163 = sext i32 %122 to i64, !dbg !344
  %arrayidx164 = getelementptr inbounds [128 x i32]* @_M4_threadsTableAllocated, i32 0, i64 %idxprom163, !dbg !344
  store i32 1, i32* %arrayidx164, align 4, !dbg !344
  %123 = load i32* %i, align 4, !dbg !334
  %inc166 = add nsw i32 %123, 1, !dbg !334
  store i32 %inc166, i32* %i, align 4, !dbg !334
  br label %for.cond138, !dbg !334

for.end167:                                       ; preds = %for.cond138
  store i32 0, i32* %_M4_i168, align 4, !dbg !345
  br label %for.cond169, !dbg !345

for.cond169:                                      ; preds = %if.end178, %for.end167
  %124 = load i32* %_M4_i168, align 4, !dbg !345
  %cmp170 = icmp slt i32 %124, 128, !dbg !345
  br i1 %cmp170, label %for.body172, label %for.end184, !dbg !345

for.body172:                                      ; preds = %for.cond169
  %125 = load i32* %_M4_i168, align 4, !dbg !348
  %idxprom173 = sext i32 %125 to i64, !dbg !348
  %arrayidx174 = getelementptr inbounds [128 x i32]* @_M4_threadsTableAllocated, i32 0, i64 %idxprom173, !dbg !348
  %126 = load i32* %arrayidx174, align 4, !dbg !348
  %cmp175 = icmp eq i32 %126, 0, !dbg !348
  br i1 %cmp175, label %for.end184, label %if.end178, !dbg !348

if.end178:                                        ; preds = %for.body172
  %127 = load i32* %_M4_i168, align 4, !dbg !350
  %idxprom179 = sext i32 %127 to i64, !dbg !350
  %arrayidx180 = getelementptr inbounds [128 x i64]* @_M4_threadsTable, i32 0, i64 %idxprom179, !dbg !350
  %128 = load i64* %arrayidx180, align 8, !dbg !350
  %call181 = call i32 @pthread_join(i64 %128, i8** %_M4_ret), !dbg !350
  %129 = load i32* %_M4_i168, align 4, !dbg !345
  %inc183 = add nsw i32 %129, 1, !dbg !345
  store i32 %inc183, i32* %_M4_i168, align 4, !dbg !345
  br label %for.cond169, !dbg !345

for.end184:                                       ; preds = %for.body172, %for.cond169
  %130 = load i32** %tids, align 8, !dbg !351
  %131 = bitcast i32* %130 to i8*, !dbg !351
  call void @free(i8* %131) #8, !dbg !351
  %132 = load i8** %outputFile, align 8, !dbg !352
  %call185 = call %struct._IO_FILE* @fopen(i8* %132, i8* getelementptr inbounds ([2 x i8]* @.str12, i32 0, i32 0)), !dbg !352
  store %struct._IO_FILE* %call185, %struct._IO_FILE** %file, align 8, !dbg !352
  %133 = load %struct._IO_FILE** %file, align 8, !dbg !353
  %cmp186 = icmp eq %struct._IO_FILE* %133, null, !dbg !353
  br i1 %cmp186, label %if.then188, label %if.end190, !dbg !353

if.then188:                                       ; preds = %for.end184
  %134 = load i8** %outputFile, align 8, !dbg !354
  %call189 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([32 x i8]* @.str3, i32 0, i32 0), i8* %134), !dbg !354
  store i32 1, i32* %retval, !dbg !356
  br label %return, !dbg !356

if.end190:                                        ; preds = %for.end184
  %135 = load %struct._IO_FILE** %file, align 8, !dbg !357
  %136 = load i32* @numOptions, align 4, !dbg !357
  %call191 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %135, i8* getelementptr inbounds ([4 x i8]* @.str13, i32 0, i32 0), i32 %136), !dbg !357
  store i32 %call191, i32* %rv, align 4, !dbg !357
  %137 = load i32* %rv, align 4, !dbg !358
  %cmp192 = icmp slt i32 %137, 0, !dbg !358
  br i1 %cmp192, label %if.then194, label %if.end197, !dbg !358

if.then194:                                       ; preds = %if.end190
  %138 = load i8** %outputFile, align 8, !dbg !359
  %call195 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str14, i32 0, i32 0), i8* %138), !dbg !359
  %139 = load %struct._IO_FILE** %file, align 8, !dbg !361
  %call196 = call i32 @fclose(%struct._IO_FILE* %139), !dbg !361
  store i32 1, i32* %retval, !dbg !362
  br label %return, !dbg !362

if.end197:                                        ; preds = %if.end190
  store i32 0, i32* %i, align 4, !dbg !363
  br label %for.cond198, !dbg !363

for.cond198:                                      ; preds = %for.inc212, %if.end197
  %140 = load i32* %i, align 4, !dbg !363
  %141 = load i32* @numOptions, align 4, !dbg !363
  %cmp199 = icmp slt i32 %140, %141, !dbg !363
  %142 = load %struct._IO_FILE** %file, align 8, !dbg !365
  br i1 %cmp199, label %for.body201, label %for.end214, !dbg !363

for.body201:                                      ; preds = %for.cond198
  %143 = load i32* %i, align 4, !dbg !365
  %idxprom202 = sext i32 %143 to i64, !dbg !365
  %144 = load float** @prices, align 8, !dbg !365
  %arrayidx203 = getelementptr inbounds float* %144, i64 %idxprom202, !dbg !365
  %145 = load float* %arrayidx203, align 4, !dbg !365
  %conv204 = fpext float %145 to double, !dbg !365
  %call205 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %142, i8* getelementptr inbounds ([7 x i8]* @.str15, i32 0, i32 0), double %conv204), !dbg !365
  store i32 %call205, i32* %rv, align 4, !dbg !365
  %146 = load i32* %rv, align 4, !dbg !367
  %cmp206 = icmp slt i32 %146, 0, !dbg !367
  br i1 %cmp206, label %if.then208, label %for.inc212, !dbg !367

if.then208:                                       ; preds = %for.body201
  %147 = load i8** %outputFile, align 8, !dbg !368
  %call209 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str14, i32 0, i32 0), i8* %147), !dbg !368
  %148 = load %struct._IO_FILE** %file, align 8, !dbg !370
  %call210 = call i32 @fclose(%struct._IO_FILE* %148), !dbg !370
  store i32 1, i32* %retval, !dbg !371
  br label %return, !dbg !371

for.inc212:                                       ; preds = %for.body201
  %149 = load i32* %i, align 4, !dbg !363
  %inc213 = add nsw i32 %149, 1, !dbg !363
  store i32 %inc213, i32* %i, align 4, !dbg !363
  br label %for.cond198, !dbg !363

for.end214:                                       ; preds = %for.cond198
  %call215 = call i32 @fclose(%struct._IO_FILE* %142), !dbg !372
  store i32 %call215, i32* %rv, align 4, !dbg !372
  %150 = load i32* %rv, align 4, !dbg !373
  %cmp216 = icmp ne i32 %150, 0, !dbg !373
  br i1 %cmp216, label %if.then218, label %if.end220, !dbg !373

if.then218:                                       ; preds = %for.end214
  %151 = load i8** %outputFile, align 8, !dbg !374
  %call219 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([33 x i8]* @.str8, i32 0, i32 0), i8* %151), !dbg !374
  store i32 1, i32* %retval, !dbg !376
  br label %return, !dbg !376

if.end220:                                        ; preds = %for.end214
  %152 = load %struct.OptionData_** @data, align 8, !dbg !377
  %153 = bitcast %struct.OptionData_* %152 to i8*, !dbg !377
  call void @free(i8* %153) #8, !dbg !377
  %154 = load float** @prices, align 8, !dbg !378
  %155 = bitcast float* %154 to i8*, !dbg !378
  call void @free(i8* %155) #8, !dbg !378
  store i32 1, i32* %retval, !dbg !379
  br label %return, !dbg !379

return:                                           ; preds = %if.end220, %if.then218, %if.then208, %if.then194, %if.then188, %if.then56, %if.then49, %if.then15, %if.then10, %if.then
  %156 = load i32* %retval, !dbg !379
  ret i32 %156, !dbg !379
}

declare i32 @make_input(...) #3

declare i32 @printf(i8*, ...) #3

declare i32 @fflush(%struct._IO_FILE*) #3

; Function Attrs: nounwind readonly
declare i32 @atoi(i8*) #4

declare %struct._IO_FILE* @fopen(i8*, i8*) #3

declare i32 @__isoc99_fscanf(%struct._IO_FILE*, i8*, ...) #3

declare i32 @fclose(%struct._IO_FILE*) #3

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

; Function Attrs: nounwind
declare i32 @pthread_mutexattr_init(%union.pthread_mutexattr_t*) #2

; Function Attrs: nounwind
declare i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) #2

declare i32 @pthread_join(i64, i8**) #3

; Function Attrs: nounwind
declare void @free(i8*) #2

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...) #3

; Function Attrs: nounwind uwtable
define void @klee_div_zero_check(i64 %z) #5 {
entry:
  %cmp = icmp eq i64 %z, 0, !dbg !380
  br i1 %cmp, label %if.then, label %if.end, !dbg !380

if.then:                                          ; preds = %entry
  tail call void @klee_report_error(i8* getelementptr inbounds ([22 x i8]* @.str16, i64 0, i64 0), i32 14, i8* getelementptr inbounds ([15 x i8]* @.str117, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str218, i64 0, i64 0)) #10, !dbg !381
  unreachable, !dbg !381

if.end:                                           ; preds = %entry
  ret void, !dbg !382
}

; Function Attrs: noreturn
declare void @klee_report_error(i8*, i32, i8*, i8*) #6

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

; Function Attrs: nounwind uwtable
define i32 @klee_int(i8* %name) #5 {
entry:
  %x = alloca i32, align 4
  %0 = bitcast i32* %x to i8*, !dbg !383
  call void @klee_make_symbolic(i8* %0, i64 4, i8* %name) #11, !dbg !383
  %1 = load i32* %x, align 4, !dbg !384, !tbaa !385
  ret i32 %1, !dbg !384
}

declare void @klee_make_symbolic(i8*, i64, i8*) #7

; Function Attrs: nounwind uwtable
define void @klee_overshift_check(i64 %bitWidth, i64 %shift) #5 {
entry:
  %cmp = icmp ult i64 %shift, %bitWidth, !dbg !388
  br i1 %cmp, label %if.end, label %if.then, !dbg !388

if.then:                                          ; preds = %entry
  tail call void @klee_report_error(i8* getelementptr inbounds ([8 x i8]* @.str319, i64 0, i64 0), i32 0, i8* getelementptr inbounds ([16 x i8]* @.str1420, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8]* @.str25, i64 0, i64 0)) #10, !dbg !389
  unreachable, !dbg !389

if.end:                                           ; preds = %entry
  ret void, !dbg !391
}

; Function Attrs: nounwind uwtable
define i32 @klee_range(i32 %start, i32 %end, i8* %name) #5 {
entry:
  %x = alloca i32, align 4
  %cmp = icmp slt i32 %start, %end, !dbg !392
  br i1 %cmp, label %if.end, label %if.then, !dbg !392

if.then:                                          ; preds = %entry
  call void @klee_report_error(i8* getelementptr inbounds ([13 x i8]* @.str621, i64 0, i64 0), i32 17, i8* getelementptr inbounds ([14 x i8]* @.str17, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str28, i64 0, i64 0)) #10, !dbg !393
  unreachable, !dbg !393

if.end:                                           ; preds = %entry
  %add = add nsw i32 %start, 1, !dbg !394
  %cmp1 = icmp eq i32 %add, %end, !dbg !394
  br i1 %cmp1, label %return, label %if.else, !dbg !394

if.else:                                          ; preds = %if.end
  %0 = bitcast i32* %x to i8*, !dbg !395
  call void @klee_make_symbolic(i8* %0, i64 4, i8* %name) #11, !dbg !395
  %cmp3 = icmp eq i32 %start, 0, !dbg !397
  %1 = load i32* %x, align 4, !dbg !398, !tbaa !385
  br i1 %cmp3, label %if.then4, label %if.else7, !dbg !397

if.then4:                                         ; preds = %if.else
  %cmp5 = icmp ult i32 %1, %end, !dbg !398
  %conv6 = zext i1 %cmp5 to i64, !dbg !398
  call void @klee_assume(i64 %conv6) #11, !dbg !398
  br label %if.end14, !dbg !400

if.else7:                                         ; preds = %if.else
  %cmp8 = icmp sge i32 %1, %start, !dbg !401
  %conv10 = zext i1 %cmp8 to i64, !dbg !401
  call void @klee_assume(i64 %conv10) #11, !dbg !401
  %2 = load i32* %x, align 4, !dbg !403, !tbaa !385
  %cmp11 = icmp slt i32 %2, %end, !dbg !403
  %conv13 = zext i1 %cmp11 to i64, !dbg !403
  call void @klee_assume(i64 %conv13) #11, !dbg !403
  br label %if.end14

if.end14:                                         ; preds = %if.else7, %if.then4
  %3 = load i32* %x, align 4, !dbg !404, !tbaa !385
  br label %return, !dbg !404

return:                                           ; preds = %if.end14, %if.end
  %retval.0 = phi i32 [ %3, %if.end14 ], [ %start, %if.end ]
  ret i32 %retval.0, !dbg !405
}

declare void @klee_assume(i64) #7

; Function Attrs: nounwind uwtable
define weak i8* @memcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #5 {
entry:
  %cmp3 = icmp eq i64 %len, 0, !dbg !406
  br i1 %cmp3, label %while.end, label %while.body, !dbg !406

while.body:                                       ; preds = %while.body, %entry
  %src.06 = phi i8* [ %incdec.ptr, %while.body ], [ %srcaddr, %entry ]
  %dest.05 = phi i8* [ %incdec.ptr1, %while.body ], [ %destaddr, %entry ]
  %len.addr.04 = phi i64 [ %dec, %while.body ], [ %len, %entry ]
  %dec = add i64 %len.addr.04, -1, !dbg !406
  %incdec.ptr = getelementptr inbounds i8* %src.06, i64 1, !dbg !407
  %0 = load i8* %src.06, align 1, !dbg !407, !tbaa !386
  %incdec.ptr1 = getelementptr inbounds i8* %dest.05, i64 1, !dbg !407
  store i8 %0, i8* %dest.05, align 1, !dbg !407, !tbaa !386
  %cmp = icmp eq i64 %dec, 0, !dbg !406
  br i1 %cmp, label %while.end, label %while.body, !dbg !406

while.end:                                        ; preds = %while.body, %entry
  ret i8* %destaddr, !dbg !408
}

; Function Attrs: nounwind uwtable
define weak i8* @memmove(i8* %dst, i8* %src, i64 %count) #5 {
entry:
  %cmp = icmp eq i8* %src, %dst, !dbg !409
  br i1 %cmp, label %return, label %if.end, !dbg !409

if.end:                                           ; preds = %entry
  %cmp1 = icmp ugt i8* %src, %dst, !dbg !410
  br i1 %cmp1, label %while.cond.preheader, label %if.else, !dbg !410

while.cond.preheader:                             ; preds = %if.end
  %tobool27 = icmp eq i64 %count, 0, !dbg !411
  br i1 %tobool27, label %return, label %while.body, !dbg !411

while.body:                                       ; preds = %while.body, %while.cond.preheader
  %b.030 = phi i8* [ %incdec.ptr, %while.body ], [ %src, %while.cond.preheader ]
  %a.029 = phi i8* [ %incdec.ptr3, %while.body ], [ %dst, %while.cond.preheader ]
  %count.addr.028 = phi i64 [ %dec, %while.body ], [ %count, %while.cond.preheader ]
  %dec = add i64 %count.addr.028, -1, !dbg !411
  %incdec.ptr = getelementptr inbounds i8* %b.030, i64 1, !dbg !411
  %0 = load i8* %b.030, align 1, !dbg !411, !tbaa !386
  %incdec.ptr3 = getelementptr inbounds i8* %a.029, i64 1, !dbg !411
  store i8 %0, i8* %a.029, align 1, !dbg !411, !tbaa !386
  %tobool = icmp eq i64 %dec, 0, !dbg !411
  br i1 %tobool, label %return, label %while.body, !dbg !411

if.else:                                          ; preds = %if.end
  %sub = add i64 %count, -1, !dbg !413
  %tobool832 = icmp eq i64 %count, 0, !dbg !415
  br i1 %tobool832, label %return, label %while.body9.lr.ph, !dbg !415

while.body9.lr.ph:                                ; preds = %if.else
  %add.ptr5 = getelementptr inbounds i8* %src, i64 %sub, !dbg !416
  %add.ptr = getelementptr inbounds i8* %dst, i64 %sub, !dbg !413
  br label %while.body9, !dbg !415

while.body9:                                      ; preds = %while.body9, %while.body9.lr.ph
  %b.135 = phi i8* [ %add.ptr5, %while.body9.lr.ph ], [ %incdec.ptr10, %while.body9 ]
  %a.134 = phi i8* [ %add.ptr, %while.body9.lr.ph ], [ %incdec.ptr11, %while.body9 ]
  %count.addr.133 = phi i64 [ %count, %while.body9.lr.ph ], [ %dec7, %while.body9 ]
  %dec7 = add i64 %count.addr.133, -1, !dbg !415
  %incdec.ptr10 = getelementptr inbounds i8* %b.135, i64 -1, !dbg !415
  %1 = load i8* %b.135, align 1, !dbg !415, !tbaa !386
  %incdec.ptr11 = getelementptr inbounds i8* %a.134, i64 -1, !dbg !415
  store i8 %1, i8* %a.134, align 1, !dbg !415, !tbaa !386
  %tobool8 = icmp eq i64 %dec7, 0, !dbg !415
  br i1 %tobool8, label %return, label %while.body9, !dbg !415

return:                                           ; preds = %while.body9, %if.else, %while.body, %while.cond.preheader, %entry
  ret i8* %dst, !dbg !417
}

; Function Attrs: nounwind uwtable
define weak i8* @mempcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #5 {
entry:
  %cmp3 = icmp eq i64 %len, 0, !dbg !418
  br i1 %cmp3, label %while.end, label %while.body, !dbg !418

while.body:                                       ; preds = %while.body, %entry
  %src.06 = phi i8* [ %incdec.ptr, %while.body ], [ %srcaddr, %entry ]
  %dest.05 = phi i8* [ %incdec.ptr1, %while.body ], [ %destaddr, %entry ]
  %len.addr.04 = phi i64 [ %dec, %while.body ], [ %len, %entry ]
  %dec = add i64 %len.addr.04, -1, !dbg !418
  %incdec.ptr = getelementptr inbounds i8* %src.06, i64 1, !dbg !419
  %0 = load i8* %src.06, align 1, !dbg !419, !tbaa !386
  %incdec.ptr1 = getelementptr inbounds i8* %dest.05, i64 1, !dbg !419
  store i8 %0, i8* %dest.05, align 1, !dbg !419, !tbaa !386
  %cmp = icmp eq i64 %dec, 0, !dbg !418
  br i1 %cmp, label %while.cond.while.end_crit_edge, label %while.body, !dbg !418

while.cond.while.end_crit_edge:                   ; preds = %while.body
  %scevgep = getelementptr i8* %destaddr, i64 %len
  br label %while.end, !dbg !418

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %entry
  %dest.0.lcssa = phi i8* [ %scevgep, %while.cond.while.end_crit_edge ], [ %destaddr, %entry ]
  ret i8* %dest.0.lcssa, !dbg !420
}

; Function Attrs: nounwind uwtable
define weak i8* @memset(i8* %dst, i32 %s, i64 %count) #5 {
entry:
  %cmp2 = icmp eq i64 %count, 0, !dbg !421
  br i1 %cmp2, label %while.end, label %while.body.lr.ph, !dbg !421

while.body.lr.ph:                                 ; preds = %entry
  %conv = trunc i32 %s to i8, !dbg !422
  br label %while.body, !dbg !421

while.body:                                       ; preds = %while.body, %while.body.lr.ph
  %a.04 = phi i8* [ %dst, %while.body.lr.ph ], [ %incdec.ptr, %while.body ]
  %count.addr.03 = phi i64 [ %count, %while.body.lr.ph ], [ %dec, %while.body ]
  %dec = add i64 %count.addr.03, -1, !dbg !421
  %incdec.ptr = getelementptr inbounds i8* %a.04, i64 1, !dbg !422
  store volatile i8 %conv, i8* %a.04, align 1, !dbg !422, !tbaa !386
  %cmp = icmp eq i64 %dec, 0, !dbg !421
  br i1 %cmp, label %while.end, label %while.body, !dbg !421

while.end:                                        ; preds = %while.body, %entry
  ret i8* %dst, !dbg !423
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf"="true" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf"="true" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf"="true" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf"="true" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-frame-pointer-elim-non-leaf"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-frame-pointer-elim-non-leaf"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-frame-pointer-elim-non-leaf"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { nounwind }
attributes #9 = { nounwind readonly }
attributes #10 = { nobuiltin noreturn nounwind }
attributes #11 = { nobuiltin nounwind }

!llvm.dbg.cu = !{!0, !70, !81, !94, !106, !119, !136, !151, !166}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.3 (tags/RELEASE_33/final)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !23, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home/icefox
!1 = metadata !{metadata !"blackscholes.m4.c", metadata !"/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel"}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4, metadata !9, metadata !13, metadata !17}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"CNDF", metadata !"CNDF", metadata !"", i32 116, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, float (float)* @CNDF, null, null, metadata !2, i32 116} ; [ DW_TAG_sub
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!6 = metadata !{i32 786453, i32 0, i32 0, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"float", i32 0, i64 32, i64 32, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [float] [line 0, size 32, align 32, offset 0, enc DW_ATE_float]
!9 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"BlkSchlsEqEuroNoDiv", metadata !"BlkSchlsEqEuroNoDiv", metadata !"", i32 177, metadata !10, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, float (float, float, float, float, floa
!10 = metadata !{i32 786453, i32 0, i32 0, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !11, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!11 = metadata !{metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !8, metadata !12, metadata !8}
!12 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!13 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"bs_thread", metadata !"bs_thread", metadata !"", i32 300, metadata !14, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i8*)* @bs_thread, null, null, metadata !2, i32 300} ;
!14 = metadata !{i32 786453, i32 0, i32 0, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !15, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!15 = metadata !{metadata !12, metadata !16}
!16 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!17 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"main", metadata !"main", metadata !"", i32 342, metadata !18, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i32, i8**)* @main, null, null, metadata !2, i32 342} ; [ DW_TAG
!18 = metadata !{i32 786453, i32 0, i32 0, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !19, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!19 = metadata !{metadata !12, metadata !12, metadata !20}
!20 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !21} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!21 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !22} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!22 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!23 = metadata !{metadata !24, metadata !25, metadata !26, metadata !27, metadata !33, metadata !35, metadata !45, metadata !59, metadata !61, metadata !62, metadata !64, metadata !65, metadata !66, metadata !67, metadata !68, metadata !69}
!24 = metadata !{i32 786484, i32 0, null, metadata !"_M4_numThreads", metadata !"_M4_numThreads", metadata !"", metadata !5, i32 49, metadata !12, i32 0, i32 1, i32* @_M4_numThreads, null} ; [ DW_TAG_variable ] [_M4_numThreads] [line 49] [def]
!25 = metadata !{i32 786484, i32 0, null, metadata !"numError", metadata !"numError", metadata !"", metadata !5, i32 104, metadata !12, i32 0, i32 1, i32* @numError, null} ; [ DW_TAG_variable ] [numError] [line 104] [def]
!26 = metadata !{i32 786484, i32 0, null, metadata !"errorInput", metadata !"errorInput", metadata !"", metadata !5, i32 105, metadata !12, i32 0, i32 1, i32* @errorInput, null} ; [ DW_TAG_variable ] [errorInput] [line 105] [def]
!27 = metadata !{i32 786484, i32 0, null, metadata !"_M4_threadsTable", metadata !"_M4_threadsTable", metadata !"", metadata !5, i32 46, metadata !28, i32 0, i32 1, [128 x i64]* @_M4_threadsTable, null} ; [ DW_TAG_variable ] [_M4_threadsTable] [line 46] 
!28 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 8192, i64 64, i32 0, i32 0, metadata !29, metadata !31, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 8192, align 64, offset 0] [from pthread_t]
!29 = metadata !{i32 786454, metadata !1, null, metadata !"pthread_t", i32 60, i64 0, i64 0, i64 0, i32 0, metadata !30} ; [ DW_TAG_typedef ] [pthread_t] [line 60, size 0, align 0, offset 0] [from long unsigned int]
!30 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!31 = metadata !{metadata !32}
!32 = metadata !{i32 786465, i64 0, i64 128}      ; [ DW_TAG_subrange_type ] [0, 127]
!33 = metadata !{i32 786484, i32 0, null, metadata !"_M4_threadsTableAllocated", metadata !"_M4_threadsTableAllocated", metadata !"", metadata !5, i32 47, metadata !34, i32 0, i32 1, [128 x i32]* @_M4_threadsTableAllocated, null} ; [ DW_TAG_variable ] [_
!34 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 4096, i64 32, i32 0, i32 0, metadata !12, metadata !31, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 4096, align 32, offset 0] [from int]
!35 = metadata !{i32 786484, i32 0, null, metadata !"_M4_normalMutexAttr", metadata !"_M4_normalMutexAttr", metadata !"", metadata !5, i32 48, metadata !36, i32 0, i32 1, %union.pthread_mutexattr_t* @_M4_normalMutexAttr, null} ; [ DW_TAG_variable ] [_M4_
!36 = metadata !{i32 786454, metadata !1, null, metadata !"pthread_mutexattr_t", i32 133, i64 0, i64 0, i64 0, i32 0, metadata !37} ; [ DW_TAG_typedef ] [pthread_mutexattr_t] [line 133, size 0, align 0, offset 0] [from ]
!37 = metadata !{i32 786455, metadata !38, null, metadata !"", i32 129, i64 32, i64 32, i64 0, i32 0, null, metadata !39, i32 0, i32 0, null} ; [ DW_TAG_union_type ] [line 129, size 32, align 32, offset 0] [from ]
!38 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", metadata !"/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel"}
!39 = metadata !{metadata !40, metadata !44}
!40 = metadata !{i32 786445, metadata !38, metadata !37, metadata !"__size", i32 131, i64 32, i64 8, i64 0, i32 0, metadata !41} ; [ DW_TAG_member ] [__size] [line 131, size 32, align 8, offset 0] [from ]
!41 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 32, i64 8, i32 0, i32 0, metadata !22, metadata !42, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 32, align 8, offset 0] [from char]
!42 = metadata !{metadata !43}
!43 = metadata !{i32 786465, i64 0, i64 4}        ; [ DW_TAG_subrange_type ] [0, 3]
!44 = metadata !{i32 786445, metadata !38, metadata !37, metadata !"__align", i32 132, i64 32, i64 32, i64 0, i32 0, metadata !12} ; [ DW_TAG_member ] [__align] [line 132, size 32, align 32, offset 0] [from int]
!45 = metadata !{i32 786484, i32 0, null, metadata !"data", metadata !"data", metadata !"", metadata !5, i32 94, metadata !46, i32 0, i32 1, %struct.OptionData_** @data, null} ; [ DW_TAG_variable ] [data] [line 94] [def]
!46 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !47} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from OptionData]
!47 = metadata !{i32 786454, metadata !1, null, metadata !"OptionData", i32 92, i64 0, i64 0, i64 0, i32 0, metadata !48} ; [ DW_TAG_typedef ] [OptionData] [line 92, size 0, align 0, offset 0] [from OptionData_]
!48 = metadata !{i32 786451, metadata !1, null, metadata !"OptionData_", i32 81, i64 288, i64 32, i32 0, i32 0, null, metadata !49, i32 0, null, null} ; [ DW_TAG_structure_type ] [OptionData_] [line 81, size 288, align 32, offset 0] [from ]
!49 = metadata !{metadata !50, metadata !51, metadata !52, metadata !53, metadata !54, metadata !55, metadata !56, metadata !57, metadata !58}
!50 = metadata !{i32 786445, metadata !1, metadata !48, metadata !"s", i32 82, i64 32, i64 32, i64 0, i32 0, metadata !8} ; [ DW_TAG_member ] [s] [line 82, size 32, align 32, offset 0] [from float]
!51 = metadata !{i32 786445, metadata !1, metadata !48, metadata !"strike", i32 83, i64 32, i64 32, i64 32, i32 0, metadata !8} ; [ DW_TAG_member ] [strike] [line 83, size 32, align 32, offset 32] [from float]
!52 = metadata !{i32 786445, metadata !1, metadata !48, metadata !"r", i32 84, i64 32, i64 32, i64 64, i32 0, metadata !8} ; [ DW_TAG_member ] [r] [line 84, size 32, align 32, offset 64] [from float]
!53 = metadata !{i32 786445, metadata !1, metadata !48, metadata !"divq", i32 85, i64 32, i64 32, i64 96, i32 0, metadata !8} ; [ DW_TAG_member ] [divq] [line 85, size 32, align 32, offset 96] [from float]
!54 = metadata !{i32 786445, metadata !1, metadata !48, metadata !"v", i32 86, i64 32, i64 32, i64 128, i32 0, metadata !8} ; [ DW_TAG_member ] [v] [line 86, size 32, align 32, offset 128] [from float]
!55 = metadata !{i32 786445, metadata !1, metadata !48, metadata !"t", i32 87, i64 32, i64 32, i64 160, i32 0, metadata !8} ; [ DW_TAG_member ] [t] [line 87, size 32, align 32, offset 160] [from float]
!56 = metadata !{i32 786445, metadata !1, metadata !48, metadata !"OptionType", i32 89, i64 8, i64 8, i64 192, i32 0, metadata !22} ; [ DW_TAG_member ] [OptionType] [line 89, size 8, align 8, offset 192] [from char]
!57 = metadata !{i32 786445, metadata !1, metadata !48, metadata !"divs", i32 90, i64 32, i64 32, i64 224, i32 0, metadata !8} ; [ DW_TAG_member ] [divs] [line 90, size 32, align 32, offset 224] [from float]
!58 = metadata !{i32 786445, metadata !1, metadata !48, metadata !"DGrefval", i32 91, i64 32, i64 32, i64 256, i32 0, metadata !8} ; [ DW_TAG_member ] [DGrefval] [line 91, size 32, align 32, offset 256] [from float]
!59 = metadata !{i32 786484, i32 0, null, metadata !"prices", metadata !"prices", metadata !"", metadata !5, i32 95, metadata !60, i32 0, i32 1, float** @prices, null} ; [ DW_TAG_variable ] [prices] [line 95] [def]
!60 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !8} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from float]
!61 = metadata !{i32 786484, i32 0, null, metadata !"numOptions", metadata !"numOptions", metadata !"", metadata !5, i32 96, metadata !12, i32 0, i32 1, i32* @numOptions, null} ; [ DW_TAG_variable ] [numOptions] [line 96] [def]
!62 = metadata !{i32 786484, i32 0, null, metadata !"otype", metadata !"otype", metadata !"", metadata !5, i32 98, metadata !63, i32 0, i32 1, i32** @otype, null} ; [ DW_TAG_variable ] [otype] [line 98] [def]
!63 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !12} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!64 = metadata !{i32 786484, i32 0, null, metadata !"sptprice", metadata !"sptprice", metadata !"", metadata !5, i32 99, metadata !60, i32 0, i32 1, float** @sptprice, null} ; [ DW_TAG_variable ] [sptprice] [line 99] [def]
!65 = metadata !{i32 786484, i32 0, null, metadata !"strike", metadata !"strike", metadata !"", metadata !5, i32 100, metadata !60, i32 0, i32 1, float** @strike, null} ; [ DW_TAG_variable ] [strike] [line 100] [def]
!66 = metadata !{i32 786484, i32 0, null, metadata !"rate", metadata !"rate", metadata !"", metadata !5, i32 101, metadata !60, i32 0, i32 1, float** @rate, null} ; [ DW_TAG_variable ] [rate] [line 101] [def]
!67 = metadata !{i32 786484, i32 0, null, metadata !"volatility", metadata !"volatility", metadata !"", metadata !5, i32 102, metadata !60, i32 0, i32 1, float** @volatility, null} ; [ DW_TAG_variable ] [volatility] [line 102] [def]
!68 = metadata !{i32 786484, i32 0, null, metadata !"otime", metadata !"otime", metadata !"", metadata !5, i32 103, metadata !60, i32 0, i32 1, float** @otime, null} ; [ DW_TAG_variable ] [otime] [line 103] [def]
!69 = metadata !{i32 786484, i32 0, null, metadata !"nThreads", metadata !"nThreads", metadata !"", metadata !5, i32 106, metadata !12, i32 0, i32 1, i32* @nThreads, null} ; [ DW_TAG_variable ] [nThreads] [line 106] [def]
!70 = metadata !{i32 786449, metadata !71, i32 1, metadata !"clang version 3.3 (tags/RELEASE_33/final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !72, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home/icefox
!71 = metadata !{metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic/klee_div_zero_check.c", metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic"}
!72 = metadata !{metadata !73}
!73 = metadata !{i32 786478, metadata !74, metadata !75, metadata !"klee_div_zero_check", metadata !"klee_div_zero_check", metadata !"", i32 12, metadata !76, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64)* @klee_div_zero_check, null
!74 = metadata !{metadata !"klee_div_zero_check.c", metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic"}
!75 = metadata !{i32 786473, metadata !74}        ; [ DW_TAG_file_type ] [/home/icefox/workspace/inputGen/runtime/Intrinsic/klee_div_zero_check.c]
!76 = metadata !{i32 786453, i32 0, i32 0, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !77, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!77 = metadata !{null, metadata !78}
!78 = metadata !{i32 786468, null, null, metadata !"long long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!79 = metadata !{metadata !80}
!80 = metadata !{i32 786689, metadata !73, metadata !"z", metadata !75, i32 16777228, metadata !78, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [z] [line 12]
!81 = metadata !{i32 786449, metadata !82, i32 1, metadata !"clang version 3.3 (tags/RELEASE_33/final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !83, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home/icefox
!82 = metadata !{metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic/klee_int.c", metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic"}
!83 = metadata !{metadata !84}
!84 = metadata !{i32 786478, metadata !85, metadata !86, metadata !"klee_int", metadata !"klee_int", metadata !"", i32 13, metadata !87, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*)* @klee_int, null, null, metadata !91, i32 13} ; [ 
!85 = metadata !{metadata !"klee_int.c", metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic"}
!86 = metadata !{i32 786473, metadata !85}        ; [ DW_TAG_file_type ] [/home/icefox/workspace/inputGen/runtime/Intrinsic/klee_int.c]
!87 = metadata !{i32 786453, i32 0, i32 0, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !88, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!88 = metadata !{metadata !12, metadata !89}
!89 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !90} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!90 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !22} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!91 = metadata !{metadata !92, metadata !93}
!92 = metadata !{i32 786689, metadata !84, metadata !"name", metadata !86, i32 16777229, metadata !89, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!93 = metadata !{i32 786688, metadata !84, metadata !"x", metadata !86, i32 14, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!94 = metadata !{i32 786449, metadata !95, i32 1, metadata !"clang version 3.3 (tags/RELEASE_33/final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !96, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home/icefox
!95 = metadata !{metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic/klee_overshift_check.c", metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic"}
!96 = metadata !{metadata !97}
!97 = metadata !{i32 786478, metadata !98, metadata !99, metadata !"klee_overshift_check", metadata !"klee_overshift_check", metadata !"", i32 20, metadata !100, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64, i64)* @klee_overshift_ch
!98 = metadata !{metadata !"klee_overshift_check.c", metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic"}
!99 = metadata !{i32 786473, metadata !98}        ; [ DW_TAG_file_type ] [/home/icefox/workspace/inputGen/runtime/Intrinsic/klee_overshift_check.c]
!100 = metadata !{i32 786453, i32 0, i32 0, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !101, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!101 = metadata !{null, metadata !102, metadata !102}
!102 = metadata !{i32 786468, null, null, metadata !"long long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!103 = metadata !{metadata !104, metadata !105}
!104 = metadata !{i32 786689, metadata !97, metadata !"bitWidth", metadata !99, i32 16777236, metadata !102, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [bitWidth] [line 20]
!105 = metadata !{i32 786689, metadata !97, metadata !"shift", metadata !99, i32 33554452, metadata !102, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [shift] [line 20]
!106 = metadata !{i32 786449, metadata !107, i32 1, metadata !"clang version 3.3 (tags/RELEASE_33/final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !108, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home/ice
!107 = metadata !{metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic/klee_range.c", metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic"}
!108 = metadata !{metadata !109}
!109 = metadata !{i32 786478, metadata !110, metadata !111, metadata !"klee_range", metadata !"klee_range", metadata !"", i32 13, metadata !112, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i32, i8*)* @klee_range, null, null, metada
!110 = metadata !{metadata !"klee_range.c", metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic"}
!111 = metadata !{i32 786473, metadata !110}      ; [ DW_TAG_file_type ] [/home/icefox/workspace/inputGen/runtime/Intrinsic/klee_range.c]
!112 = metadata !{i32 786453, i32 0, i32 0, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !113, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!113 = metadata !{metadata !12, metadata !12, metadata !12, metadata !89}
!114 = metadata !{metadata !115, metadata !116, metadata !117, metadata !118}
!115 = metadata !{i32 786689, metadata !109, metadata !"start", metadata !111, i32 16777229, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [start] [line 13]
!116 = metadata !{i32 786689, metadata !109, metadata !"end", metadata !111, i32 33554445, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [end] [line 13]
!117 = metadata !{i32 786689, metadata !109, metadata !"name", metadata !111, i32 50331661, metadata !89, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!118 = metadata !{i32 786688, metadata !109, metadata !"x", metadata !111, i32 14, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!119 = metadata !{i32 786449, metadata !120, i32 1, metadata !"clang version 3.3 (tags/RELEASE_33/final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !121, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home/ice
!120 = metadata !{metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic/memcpy.c", metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic"}
!121 = metadata !{metadata !122}
!122 = metadata !{i32 786478, metadata !123, metadata !124, metadata !"memcpy", metadata !"memcpy", metadata !"", i32 12, metadata !125, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memcpy, null, null, metadata !130, i32
!123 = metadata !{metadata !"memcpy.c", metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic"}
!124 = metadata !{i32 786473, metadata !123}      ; [ DW_TAG_file_type ] [/home/icefox/workspace/inputGen/runtime/Intrinsic/memcpy.c]
!125 = metadata !{i32 786453, i32 0, i32 0, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !126, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!126 = metadata !{metadata !16, metadata !16, metadata !127, metadata !129}
!127 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !128} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!128 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from ]
!129 = metadata !{i32 786454, metadata !123, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !30} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!130 = metadata !{metadata !131, metadata !132, metadata !133, metadata !134, metadata !135}
!131 = metadata !{i32 786689, metadata !122, metadata !"destaddr", metadata !124, i32 16777228, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 12]
!132 = metadata !{i32 786689, metadata !122, metadata !"srcaddr", metadata !124, i32 33554444, metadata !127, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 12]
!133 = metadata !{i32 786689, metadata !122, metadata !"len", metadata !124, i32 50331660, metadata !129, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 12]
!134 = metadata !{i32 786688, metadata !122, metadata !"dest", metadata !124, i32 13, metadata !21, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 13]
!135 = metadata !{i32 786688, metadata !122, metadata !"src", metadata !124, i32 14, metadata !89, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 14]
!136 = metadata !{i32 786449, metadata !137, i32 1, metadata !"clang version 3.3 (tags/RELEASE_33/final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !138, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home/ice
!137 = metadata !{metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic/memmove.c", metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic"}
!138 = metadata !{metadata !139}
!139 = metadata !{i32 786478, metadata !140, metadata !141, metadata !"memmove", metadata !"memmove", metadata !"", i32 12, metadata !142, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memmove, null, null, metadata !145, 
!140 = metadata !{metadata !"memmove.c", metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic"}
!141 = metadata !{i32 786473, metadata !140}      ; [ DW_TAG_file_type ] [/home/icefox/workspace/inputGen/runtime/Intrinsic/memmove.c]
!142 = metadata !{i32 786453, i32 0, i32 0, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !143, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!143 = metadata !{metadata !16, metadata !16, metadata !127, metadata !144}
!144 = metadata !{i32 786454, metadata !140, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !30} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!145 = metadata !{metadata !146, metadata !147, metadata !148, metadata !149, metadata !150}
!146 = metadata !{i32 786689, metadata !139, metadata !"dst", metadata !141, i32 16777228, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 12]
!147 = metadata !{i32 786689, metadata !139, metadata !"src", metadata !141, i32 33554444, metadata !127, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [src] [line 12]
!148 = metadata !{i32 786689, metadata !139, metadata !"count", metadata !141, i32 50331660, metadata !144, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 12]
!149 = metadata !{i32 786688, metadata !139, metadata !"a", metadata !141, i32 13, metadata !21, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 13]
!150 = metadata !{i32 786688, metadata !139, metadata !"b", metadata !141, i32 14, metadata !89, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 14]
!151 = metadata !{i32 786449, metadata !152, i32 1, metadata !"clang version 3.3 (tags/RELEASE_33/final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !153, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home/ice
!152 = metadata !{metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic/mempcpy.c", metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic"}
!153 = metadata !{metadata !154}
!154 = metadata !{i32 786478, metadata !155, metadata !156, metadata !"mempcpy", metadata !"mempcpy", metadata !"", i32 11, metadata !157, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @mempcpy, null, null, metadata !160, 
!155 = metadata !{metadata !"mempcpy.c", metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic"}
!156 = metadata !{i32 786473, metadata !155}      ; [ DW_TAG_file_type ] [/home/icefox/workspace/inputGen/runtime/Intrinsic/mempcpy.c]
!157 = metadata !{i32 786453, i32 0, i32 0, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !158, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!158 = metadata !{metadata !16, metadata !16, metadata !127, metadata !159}
!159 = metadata !{i32 786454, metadata !155, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !30} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!160 = metadata !{metadata !161, metadata !162, metadata !163, metadata !164, metadata !165}
!161 = metadata !{i32 786689, metadata !154, metadata !"destaddr", metadata !156, i32 16777227, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 11]
!162 = metadata !{i32 786689, metadata !154, metadata !"srcaddr", metadata !156, i32 33554443, metadata !127, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 11]
!163 = metadata !{i32 786689, metadata !154, metadata !"len", metadata !156, i32 50331659, metadata !159, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 11]
!164 = metadata !{i32 786688, metadata !154, metadata !"dest", metadata !156, i32 12, metadata !21, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 12]
!165 = metadata !{i32 786688, metadata !154, metadata !"src", metadata !156, i32 13, metadata !89, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 13]
!166 = metadata !{i32 786449, metadata !167, i32 1, metadata !"clang version 3.3 (tags/RELEASE_33/final)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !168, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home/ice
!167 = metadata !{metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic/memset.c", metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic"}
!168 = metadata !{metadata !169}
!169 = metadata !{i32 786478, metadata !170, metadata !171, metadata !"memset", metadata !"memset", metadata !"", i32 11, metadata !172, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i32, i64)* @memset, null, null, metadata !175, i32
!170 = metadata !{metadata !"memset.c", metadata !"/home/icefox/workspace/inputGen/runtime/Intrinsic"}
!171 = metadata !{i32 786473, metadata !170}      ; [ DW_TAG_file_type ] [/home/icefox/workspace/inputGen/runtime/Intrinsic/memset.c]
!172 = metadata !{i32 786453, i32 0, i32 0, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !173, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!173 = metadata !{metadata !16, metadata !16, metadata !12, metadata !174}
!174 = metadata !{i32 786454, metadata !170, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !30} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!175 = metadata !{metadata !176, metadata !177, metadata !178, metadata !179}
!176 = metadata !{i32 786689, metadata !169, metadata !"dst", metadata !171, i32 16777227, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 11]
!177 = metadata !{i32 786689, metadata !169, metadata !"s", metadata !171, i32 33554443, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 11]
!178 = metadata !{i32 786689, metadata !169, metadata !"count", metadata !171, i32 50331659, metadata !174, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 11]
!179 = metadata !{i32 786688, metadata !169, metadata !"a", metadata !171, i32 12, metadata !180, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 12]
!180 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !181} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!181 = metadata !{i32 786485, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !22} ; [ DW_TAG_volatile_type ] [line 0, size 0, align 0, offset 0] [from char]
!182 = metadata !{i32 130, i32 0, metadata !4, null}
!183 = metadata !{i32 131, i32 0, metadata !184, null}
!184 = metadata !{i32 786443, metadata !1, metadata !4, i32 130, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!185 = metadata !{i32 132, i32 0, metadata !184, null}
!186 = metadata !{i32 133, i32 0, metadata !184, null}
!187 = metadata !{i32 134, i32 0, metadata !4, null}
!188 = metadata !{i32 136, i32 0, metadata !4, null}
!189 = metadata !{i32 139, i32 0, metadata !4, null}
!190 = metadata !{i32 140, i32 0, metadata !4, null}
!191 = metadata !{i32 141, i32 0, metadata !4, null}
!192 = metadata !{i32 143, i32 0, metadata !4, null}
!193 = metadata !{i32 144, i32 0, metadata !4, null}
!194 = metadata !{i32 145, i32 0, metadata !4, null}
!195 = metadata !{i32 146, i32 0, metadata !4, null}
!196 = metadata !{i32 147, i32 0, metadata !4, null}
!197 = metadata !{i32 148, i32 0, metadata !4, null}
!198 = metadata !{i32 149, i32 0, metadata !4, null}
!199 = metadata !{i32 151, i32 0, metadata !4, null}
!200 = metadata !{i32 152, i32 0, metadata !4, null}
!201 = metadata !{i32 153, i32 0, metadata !4, null}
!202 = metadata !{i32 154, i32 0, metadata !4, null}
!203 = metadata !{i32 155, i32 0, metadata !4, null}
!204 = metadata !{i32 156, i32 0, metadata !4, null}
!205 = metadata !{i32 157, i32 0, metadata !4, null}
!206 = metadata !{i32 158, i32 0, metadata !4, null}
!207 = metadata !{i32 160, i32 0, metadata !4, null}
!208 = metadata !{i32 161, i32 0, metadata !4, null}
!209 = metadata !{i32 162, i32 0, metadata !4, null}
!210 = metadata !{i32 164, i32 0, metadata !4, null}
!211 = metadata !{i32 166, i32 0, metadata !4, null}
!212 = metadata !{i32 167, i32 0, metadata !213, null}
!213 = metadata !{i32 786443, metadata !1, metadata !4, i32 166, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!214 = metadata !{i32 168, i32 0, metadata !213, null}
!215 = metadata !{i32 170, i32 0, metadata !4, null}
!216 = metadata !{i32 204, i32 0, metadata !9, null}
!217 = metadata !{i32 205, i32 0, metadata !9, null}
!218 = metadata !{i32 206, i32 0, metadata !9, null}
!219 = metadata !{i32 207, i32 0, metadata !9, null}
!220 = metadata !{i32 209, i32 0, metadata !9, null}
!221 = metadata !{i32 210, i32 0, metadata !9, null}
!222 = metadata !{i32 212, i32 0, metadata !9, null}
!223 = metadata !{i32 214, i32 0, metadata !9, null}
!224 = metadata !{i32 216, i32 0, metadata !9, null}
!225 = metadata !{i32 217, i32 0, metadata !9, null}
!226 = metadata !{i32 219, i32 0, metadata !9, null}
!227 = metadata !{i32 220, i32 0, metadata !9, null}
!228 = metadata !{i32 221, i32 0, metadata !9, null}
!229 = metadata !{i32 223, i32 0, metadata !9, null}
!230 = metadata !{i32 224, i32 0, metadata !9, null}
!231 = metadata !{i32 225, i32 0, metadata !9, null}
!232 = metadata !{i32 227, i32 0, metadata !9, null}
!233 = metadata !{i32 228, i32 0, metadata !9, null}
!234 = metadata !{i32 230, i32 0, metadata !9, null}
!235 = metadata !{i32 231, i32 0, metadata !9, null}
!236 = metadata !{i32 233, i32 0, metadata !9, null}
!237 = metadata !{i32 234, i32 0, metadata !9, null}
!238 = metadata !{i32 235, i32 0, metadata !239, null}
!239 = metadata !{i32 786443, metadata !1, metadata !9, i32 234, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!240 = metadata !{i32 236, i32 0, metadata !239, null}
!241 = metadata !{i32 237, i32 0, metadata !242, null}
!242 = metadata !{i32 786443, metadata !1, metadata !9, i32 236, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!243 = metadata !{i32 238, i32 0, metadata !242, null}
!244 = metadata !{i32 239, i32 0, metadata !242, null}
!245 = metadata !{i32 242, i32 0, metadata !9, null}
!246 = metadata !{i32 305, i32 0, metadata !13, null}
!247 = metadata !{i32 306, i32 0, metadata !13, null}
!248 = metadata !{i32 307, i32 0, metadata !13, null}
!249 = metadata !{i32 309, i32 0, metadata !13, null}
!250 = metadata !{i32 311, i32 0, metadata !251, null}
!251 = metadata !{i32 786443, metadata !1, metadata !252, i32 311, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!252 = metadata !{i32 786443, metadata !1, metadata !13, i32 309, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!253 = metadata !{i32 316, i32 0, metadata !254, null}
!254 = metadata !{i32 786443, metadata !1, metadata !255, i32 316, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!255 = metadata !{i32 786443, metadata !1, metadata !251, i32 311, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!256 = metadata !{i32 321, i32 0, metadata !257, null}
!257 = metadata !{i32 786443, metadata !1, metadata !254, i32 316, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!258 = metadata !{i32 323, i32 0, metadata !257, null}
!259 = metadata !{i32 336, i32 0, metadata !13, null}
!260 = metadata !{i32 338, i32 0, metadata !13, null}
!261 = metadata !{i32 349, i32 0, metadata !17, null}
!262 = metadata !{i32 357, i32 0, metadata !17, null}
!263 = metadata !{i32 358, i32 0, metadata !17, null}
!264 = metadata !{i32 364, i32 0, metadata !17, null}
!265 = metadata !{i32 365, i32 0, metadata !266, null}
!266 = metadata !{i32 786443, metadata !1, metadata !17, i32 364, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!267 = metadata !{i32 366, i32 0, metadata !266, null}
!268 = metadata !{i32 368, i32 0, metadata !17, null}
!269 = metadata !{i32 369, i32 0, metadata !17, null}
!270 = metadata !{i32 370, i32 0, metadata !17, null}
!271 = metadata !{i32 373, i32 0, metadata !17, null}
!272 = metadata !{i32 374, i32 0, metadata !17, null}
!273 = metadata !{i32 375, i32 0, metadata !274, null}
!274 = metadata !{i32 786443, metadata !1, metadata !17, i32 374, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!275 = metadata !{i32 376, i32 0, metadata !274, null}
!276 = metadata !{i32 378, i32 0, metadata !17, null}
!277 = metadata !{i32 379, i32 0, metadata !17, null}
!278 = metadata !{i32 380, i32 0, metadata !279, null}
!279 = metadata !{i32 786443, metadata !1, metadata !17, i32 379, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!280 = metadata !{i32 381, i32 0, metadata !279, null}
!281 = metadata !{i32 382, i32 0, metadata !279, null}
!282 = metadata !{i32 384, i32 0, metadata !17, null}
!283 = metadata !{i32 385, i32 0, metadata !284, null}
!284 = metadata !{i32 786443, metadata !1, metadata !17, i32 384, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!285 = metadata !{i32 388, i32 0, metadata !284, null}
!286 = metadata !{i32 389, i32 0, metadata !284, null}
!287 = metadata !{i32 399, i32 0, metadata !17, null}
!288 = metadata !{i32 400, i32 0, metadata !17, null}
!289 = metadata !{i32 401, i32 0, metadata !290, null}
!290 = metadata !{i32 786443, metadata !1, metadata !17, i32 401, i32 0, i32 13} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!291 = metadata !{i32 402, i32 0, metadata !292, null}
!292 = metadata !{i32 786443, metadata !1, metadata !290, i32 401, i32 0, i32 14} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!293 = metadata !{i32 406, i32 0, metadata !292, null}
!294 = metadata !{i32 407, i32 0, metadata !295, null}
!295 = metadata !{i32 786443, metadata !1, metadata !292, i32 406, i32 0, i32 15} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!296 = metadata !{i32 408, i32 0, metadata !295, null}
!297 = metadata !{i32 409, i32 0, metadata !295, null}
!298 = metadata !{i32 412, i32 0, metadata !17, null}
!299 = metadata !{i32 413, i32 0, metadata !17, null}
!300 = metadata !{i32 414, i32 0, metadata !301, null}
!301 = metadata !{i32 786443, metadata !1, metadata !17, i32 413, i32 0, i32 16} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!302 = metadata !{i32 415, i32 0, metadata !301, null}
!303 = metadata !{i32 420, i32 0, metadata !17, null}
!304 = metadata !{i32 422, i32 0, metadata !17, null}
!305 = metadata !{i32 425, i32 0, metadata !306, null}
!306 = metadata !{i32 786443, metadata !1, metadata !307, i32 425, i32 0, i32 18} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!307 = metadata !{i32 786443, metadata !1, metadata !17, i32 423, i32 0, i32 17} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!308 = metadata !{i32 426, i32 0, metadata !309, null}
!309 = metadata !{i32 786443, metadata !1, metadata !306, i32 425, i32 0, i32 19} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!310 = metadata !{i32 430, i32 0, metadata !17, null}
!311 = metadata !{i32 431, i32 0, metadata !312, null}
!312 = metadata !{i32 786443, metadata !1, metadata !17, i32 430, i32 0, i32 20} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!313 = metadata !{i32 432, i32 0, metadata !312, null}
!314 = metadata !{i32 433, i32 0, metadata !312, null}
!315 = metadata !{i32 438, i32 0, metadata !17, null}
!316 = metadata !{i32 439, i32 0, metadata !17, null}
!317 = metadata !{i32 440, i32 0, metadata !17, null}
!318 = metadata !{i32 441, i32 0, metadata !17, null}
!319 = metadata !{i32 442, i32 0, metadata !17, null}
!320 = metadata !{i32 443, i32 0, metadata !17, null}
!321 = metadata !{i32 445, i32 0, metadata !17, null}
!322 = metadata !{i32 446, i32 0, metadata !17, null}
!323 = metadata !{i32 448, i32 0, metadata !324, null}
!324 = metadata !{i32 786443, metadata !1, metadata !17, i32 448, i32 0, i32 21} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!325 = metadata !{i32 449, i32 0, metadata !326, null}
!326 = metadata !{i32 786443, metadata !1, metadata !324, i32 448, i32 0, i32 22} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!327 = metadata !{i32 450, i32 0, metadata !326, null}
!328 = metadata !{i32 451, i32 0, metadata !326, null}
!329 = metadata !{i32 452, i32 0, metadata !326, null}
!330 = metadata !{i32 453, i32 0, metadata !326, null}
!331 = metadata !{i32 454, i32 0, metadata !326, null}
!332 = metadata !{i32 457, i32 0, metadata !17, null}
!333 = metadata !{i32 479, i32 0, metadata !17, null}
!334 = metadata !{i32 481, i32 0, metadata !335, null}
!335 = metadata !{i32 786443, metadata !1, metadata !17, i32 481, i32 0, i32 23} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!336 = metadata !{i32 482, i32 0, metadata !337, null}
!337 = metadata !{i32 786443, metadata !1, metadata !335, i32 481, i32 0, i32 24} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!338 = metadata !{i32 486, i32 0, metadata !339, null}
!339 = metadata !{i32 786443, metadata !1, metadata !340, i32 486, i32 0, i32 26} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!340 = metadata !{i32 786443, metadata !1, metadata !337, i32 484, i32 0, i32 25} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!341 = metadata !{i32 487, i32 0, metadata !342, null}
!342 = metadata !{i32 786443, metadata !1, metadata !339, i32 486, i32 0, i32 27} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!343 = metadata !{i32 490, i32 0, metadata !340, null}
!344 = metadata !{i32 492, i32 0, metadata !340, null}
!345 = metadata !{i32 499, i32 0, metadata !346, null}
!346 = metadata !{i32 786443, metadata !1, metadata !347, i32 499, i32 0, i32 29} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!347 = metadata !{i32 786443, metadata !1, metadata !17, i32 496, i32 0, i32 28} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!348 = metadata !{i32 500, i32 0, metadata !349, null}
!349 = metadata !{i32 786443, metadata !1, metadata !346, i32 499, i32 0, i32 30} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!350 = metadata !{i32 502, i32 0, metadata !349, null}
!351 = metadata !{i32 505, i32 0, metadata !17, null}
!352 = metadata !{i32 533, i32 0, metadata !17, null}
!353 = metadata !{i32 534, i32 0, metadata !17, null}
!354 = metadata !{i32 535, i32 0, metadata !355, null}
!355 = metadata !{i32 786443, metadata !1, metadata !17, i32 534, i32 0, i32 31} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!356 = metadata !{i32 536, i32 0, metadata !355, null}
!357 = metadata !{i32 538, i32 0, metadata !17, null}
!358 = metadata !{i32 539, i32 0, metadata !17, null}
!359 = metadata !{i32 540, i32 0, metadata !360, null}
!360 = metadata !{i32 786443, metadata !1, metadata !17, i32 539, i32 0, i32 32} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!361 = metadata !{i32 541, i32 0, metadata !360, null}
!362 = metadata !{i32 542, i32 0, metadata !360, null}
!363 = metadata !{i32 544, i32 0, metadata !364, null}
!364 = metadata !{i32 786443, metadata !1, metadata !17, i32 544, i32 0, i32 33} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!365 = metadata !{i32 545, i32 0, metadata !366, null}
!366 = metadata !{i32 786443, metadata !1, metadata !364, i32 544, i32 0, i32 34} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!367 = metadata !{i32 546, i32 0, metadata !366, null}
!368 = metadata !{i32 547, i32 0, metadata !369, null}
!369 = metadata !{i32 786443, metadata !1, metadata !366, i32 546, i32 0, i32 35} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!370 = metadata !{i32 548, i32 0, metadata !369, null}
!371 = metadata !{i32 549, i32 0, metadata !369, null}
!372 = metadata !{i32 552, i32 0, metadata !17, null}
!373 = metadata !{i32 553, i32 0, metadata !17, null}
!374 = metadata !{i32 554, i32 0, metadata !375, null}
!375 = metadata !{i32 786443, metadata !1, metadata !17, i32 553, i32 0, i32 36} ; [ DW_TAG_lexical_block ] [/home/icefox/git/Benchmarks/def_use/blackscholes-parallel/blackscholes-parallel/blackscholes.m4.c]
!376 = metadata !{i32 555, i32 0, metadata !375, null}
!377 = metadata !{i32 561, i32 0, metadata !17, null}
!378 = metadata !{i32 562, i32 0, metadata !17, null}
!379 = metadata !{i32 568, i32 0, metadata !17, null}
!380 = metadata !{i32 13, i32 0, metadata !73, null}
!381 = metadata !{i32 14, i32 0, metadata !73, null}
!382 = metadata !{i32 15, i32 0, metadata !73, null}
!383 = metadata !{i32 15, i32 0, metadata !84, null}
!384 = metadata !{i32 16, i32 0, metadata !84, null}
!385 = metadata !{metadata !"int", metadata !386}
!386 = metadata !{metadata !"omnipotent char", metadata !387}
!387 = metadata !{metadata !"Simple C/C++ TBAA"}
!388 = metadata !{i32 21, i32 0, metadata !97, null}
!389 = metadata !{i32 27, i32 0, metadata !390, null}
!390 = metadata !{i32 786443, metadata !98, metadata !97, i32 21, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/icefox/workspace/inputGen/runtime/Intrinsic/klee_overshift_check.c]
!391 = metadata !{i32 29, i32 0, metadata !97, null}
!392 = metadata !{i32 16, i32 0, metadata !109, null}
!393 = metadata !{i32 17, i32 0, metadata !109, null}
!394 = metadata !{i32 19, i32 0, metadata !109, null}
!395 = metadata !{i32 22, i32 0, metadata !396, null}
!396 = metadata !{i32 786443, metadata !110, metadata !109, i32 21, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/icefox/workspace/inputGen/runtime/Intrinsic/klee_range.c]
!397 = metadata !{i32 25, i32 0, metadata !396, null}
!398 = metadata !{i32 26, i32 0, metadata !399, null}
!399 = metadata !{i32 786443, metadata !110, metadata !396, i32 25, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/icefox/workspace/inputGen/runtime/Intrinsic/klee_range.c]
!400 = metadata !{i32 27, i32 0, metadata !399, null}
!401 = metadata !{i32 28, i32 0, metadata !402, null}
!402 = metadata !{i32 786443, metadata !110, metadata !396, i32 27, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/icefox/workspace/inputGen/runtime/Intrinsic/klee_range.c]
!403 = metadata !{i32 29, i32 0, metadata !402, null}
!404 = metadata !{i32 32, i32 0, metadata !396, null}
!405 = metadata !{i32 34, i32 0, metadata !109, null}
!406 = metadata !{i32 16, i32 0, metadata !122, null}
!407 = metadata !{i32 17, i32 0, metadata !122, null}
!408 = metadata !{i32 18, i32 0, metadata !122, null}
!409 = metadata !{i32 16, i32 0, metadata !139, null}
!410 = metadata !{i32 19, i32 0, metadata !139, null}
!411 = metadata !{i32 20, i32 0, metadata !412, null}
!412 = metadata !{i32 786443, metadata !140, metadata !139, i32 19, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/icefox/workspace/inputGen/runtime/Intrinsic/memmove.c]
!413 = metadata !{i32 22, i32 0, metadata !414, null}
!414 = metadata !{i32 786443, metadata !140, metadata !139, i32 21, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/icefox/workspace/inputGen/runtime/Intrinsic/memmove.c]
!415 = metadata !{i32 24, i32 0, metadata !414, null}
!416 = metadata !{i32 23, i32 0, metadata !414, null}
!417 = metadata !{i32 28, i32 0, metadata !139, null}
!418 = metadata !{i32 15, i32 0, metadata !154, null}
!419 = metadata !{i32 16, i32 0, metadata !154, null}
!420 = metadata !{i32 17, i32 0, metadata !154, null}
!421 = metadata !{i32 13, i32 0, metadata !169, null}
!422 = metadata !{i32 14, i32 0, metadata !169, null}
!423 = metadata !{i32 15, i32 0, metadata !169, null}
