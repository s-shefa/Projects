DATA FINAL;
/* These data are systolic and diastolic blood pressure of 72 patients.
The records were scrambled up in an accident. He had three groups of 
patients: healthy, borderline and hypertensive. Could you place them 
in order for him?
*/ 
INPUT ID Group $ SYSBP DBP;                                                     
CONF=0.95;
CARDS;        
1	A	 117 	 70 
2	A	 124 	 70 
3	A	 123 	 74 
4	A	 125 	 71 
5	A	 123 	 70 
6	A	 122 	 73 
7	A	 119 	 73 
8	A	 119 	 71 
9	A	 120 	 74 
10	A	 121 	 73 
11	A	 120 	 72 
12	A	 120 	 69 
13	A	 120 	 71 
14	A	 120 	 74 
15	A	 116 	 73 
16	A	 123 	 71 
17	A	 118 	 71 
18	A	 116 	 69 
19	A	 120 	 73 
20	A	 122 	 73 
21	A	 118 	 73 
22	A	 117 	 72 
23	A	 119 	 72 
24	A	 120 	 72 
25	A	 117 	 75 
26	A	 115 	 68 
27	A	 118 	 69 
28	A	 113 	 72 
29	A	 122 	 73 
30	A	 113 	 73 
31	B	 131 	 79 
32	B	 128 	 81 
33	B	 132 	 78 
34	B	 124 	 77 
35	B	 133 	 78 
36	B	 131 	 82 
37	B	 130 	 78 
38	B	 130 	 81 
39	B	 129 	 78 
40	B	 129 	 78 
41	B	 129 	 82 
42	B	 132 	 79 
43	B	 133 	 77 
44	B	 121 	 81 
45	B	 128 	 81 
46	B	 130 	 78 
47	B	 132 	 81 
48	B	 129 	 79 
49	B	 130 	 80 
50	B	 130 	 84 
51	B	 125 	 79 
52	B	 126 	 81 
53	B	 132 	 80 
54	B	 128 	 80 
55	C	 135 	 87 
56	C	 140 	 88 
57	C	 131 	 80 
58	C	 133 	 83 
59	C	 132 	 83 
60	C	 130 	 85 
61	C	 135 	 83 
62	C	 130 	 84 
63	C	 137 	 87 
64	C	 135 	 86 
65	C	 137 	 84 
66	C	 139 	 84 
67	C	 136 	 85 
68	C	 130 	 84 
69	C	 133 	 85 
70	C	 137 	 86 
71	C	 136 	 83 
72	C	 133 	 86 
;    
PROC CORR DATA=FINAL;                                                                      
 VAR SYSBP DBP;                                                          
 RUN;
proc glm data=FINAL; 
      class GROUP; 
      model SYSBP DBP = GROUP ; 
      manova h=_all_ / printe printh; 
   run;
proc cluster method=ward outtree=clust1;
	var SYSBP DBP ; 
	id ID;
	run;
proc tree horizontal nclusters=3 out=clust2;
	id ID;
	run;
proc print data=clust1;
proc print data=clust2;
data test;
  input SYSBP DBP ;
  cards;
130.0 85.0
;
proc discrim data=FINAL pool=yes crossvalidate testdata=test testout=a;
  class Group;
  var SYSBP DBP;
  priors "A"=0.417 "B"=0.333 "C"=0.250;
  run;
