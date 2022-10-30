# Vector summation Performance results 
```
* (time (dotimes (i 5000) (normal-sum testv testv)))
Evaluation took:
  0.080 seconds of real time
  0.078830 seconds of total run time (0.078805 user, 0.000025 system)
  98.75% CPU
  283,252,428 processor cycles
  1,057,008 bytes consed
  
NIL
* (time (dotimes (i 5000) (unrolled-sum testv testv)))
Evaluation took:
  0.052 seconds of real time
  0.049612 seconds of total run time (0.049612 user, 0.000000 system)
  96.15% CPU
  178,266,456 processor cycles
  1,047,856 bytes consed
  
NIL
* (time (dotimes (i 5000) (normal-sum-declare testv testv)))
Evaluation took:
  0.044 seconds of real time
  0.046583 seconds of total run time (0.046583 user, 0.000000 system)
  106.82% CPU
  167,382,144 processor cycles
  1,047,840 bytes consed
  
NIL
* (time (dotimes (i 5000) (unrolled-sum-declare testv testv)))
Evaluation took:
  0.048 seconds of real time
  0.046119 seconds of total run time (0.046119 user, 0.000000 system)
  95.83% CPU
  165,714,120 processor cycles
  1,047,840 bytes consed
  
NIL
* (time (dotimes (i 10000) (normal-sum-declare testv testv)))
Evaluation took:
  0.096 seconds of real time
  0.093889 seconds of total run time (0.093889 user, 0.000000 system)
  97.92% CPU
  337,365,072 processor cycles
  2,079,328 bytes consed
  
NIL
* (time (dotimes (i 10000) (unrolled-sum-declare testv testv)))
Evaluation took:
  0.088 seconds of real time
  0.089314 seconds of total run time (0.089314 user, 0.000000 system)
  101.14% CPU
  320,939,496 processor cycles
  2,079,312 bytes consed
  
```
