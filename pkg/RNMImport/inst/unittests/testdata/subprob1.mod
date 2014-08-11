$PROB COMPUTE PERCENTAGE OF POP. WITH CP>5 AT DOSE=200, TIME=5
$INPUT ID TIME DOSE DV
$DATA dataB
$PRED
IF (ICALL.EQ.0) THEN
BIAS=0 ; initialize
TRUE=0
ENDIF
IF (ICALL.EQ.1) THEN
IF (IPROB.EQ.1.OR.IPROB.EQ.4) N=0 ; see rocm14
CALL SUPP (1,1)
ENDIF
KA=THETA(1)*EXP(ETA(1))
KE=THETA(2)*EXP(ETA(2))
V=THETA(3)*EXP(ETA(3))
A=EXP(-KE*TIME)
B=EXP(-KA*TIME)
C=KA-KE
D=A-B
E=KA*DOSE/(V*C)
F=E*D
Y=F+ERR(1)
IF (ICALL.EQ.4) THEN
IF (IPROB.EQ.1.OR.IPROB.EQ.4) THEN
IF (F.GT.5) N=N+1
IF (IREP.EQ.NREP) THEN ; see rocm10
PER=100.*N/NREP
IF (IPROB.EQ.1) TRUE=PER
IF (IPROB.EQ.4) THEN
BIAS=BIAS+(PER-TRUE)/TRUE
IF (S1IT.EQ.S1NIT) THEN
BIAS=BIAS/S1NIT
WRITE (42,*) BIAS
ENDIF
ENDIF
ENDIF
ENDIF
ENDIF
$THTA (.4,1.7,7) (.025,.102,.4) (10,29,80)
$OMEGA .04 .04 .04
$SIGMA 1.5
$SIM (5566898) ONLY SUB=1000
;
; $SUPER SCOPE=3 ITERATIONS=10
$PROB SIMULATION
$INPUT ID TIME DOSE DV
$DATA dataA
$THTA (.4,1.7,7) (.025,.102,.4) (10,29,80)
$OMEGA .04 .04 .04
$SIGMA 1.5
$SIM (-1) ONLY
$TABLE ID DV TIME DOSE FILE=simulation NOHEADER NOPRINT NOFORWARD
;
$PROB ESTIMATION
$INPUT ID TIME DOSE DV
$DATA simulation (4E12.0) NRECS=500 NOOPEN
$THTA (.4,1.7,7) (.025,.102,.4) (10,29,80)
$OMEGA .04 .04 .04
$SIGMA 1.5
$EST PRINT=0 MSFO=msf
;
$PROB ESTIMATE PERCENTAGE OF POP. WITH CP>5 AT DOSE=200, TIME=5
$INPUT ID TIME DOSE DV
$DATA dataB
$MSFI msf
$SIM (-1) ONLY SUB=100
