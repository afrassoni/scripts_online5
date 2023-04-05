function linear (args)
*
* USAGE:
*        scatter_fit_stats xvar yvar [1]
* Specify "1" to solve a slope for y-intercept = 0.
*
* This uses the statistics produced from gxout stats to compute a linear fit for
* the x and y variables that have been previously plotted on a scatter diagram.
* The fit line is plotted along with a 1:1 line (if in the range of the data).
* Summary Statistics are also included. Since these are stripped from the
* Stats output, area weighting is not considered. 
* It is highly recommended that users double check the calculations to better understand
* how this works and that it does suit your needs.
* this has been tested with X,Y space and T space
*
* The script is provided free, but you use it at your own risk. Please contact the 
* originator with any improvements, suggestions or corrections.
* Mike.Bosilovich@gmail.com, Sept 19, 2008
*---
 
xvar1=subwrd(args,1)
yvar1=subwrd(args,2)
doab=subwrd(args,3)
 
'define xvar='xvar1
'define yvar='yvar1
'set gxout stat'
 
'd xvar-yvar'
bias=sublin(result,11);bias=subwrd(bias,2)
stddiff=sublin(result,13);stddiff=subwrd(stddiff,2)
 
'd xvar'
xbar=sublin(result,11);xbar=subwrd(xbar,2)
dtmin=sublin(result,9);dtmin=subwrd(dtmin,5)
dtmax=sublin(result,9);dtmax=subwrd(dtmax,6)
ncnt=sublin(result,7);ncnt=subwrd(ncnt,8)
xsig2=sublin(result,13);xsig2=subwrd(xsig2,2)
 
'd yvar'
ybar=sublin(result,11);ybar=subwrd(ybar,2)
 
'set gxout line'
'q dims'
XRef=sublin(result,2) 
YRef=sublin(result,3)
TRef=sublin(result,5)

xi=subwrd(XRef,11)
xf=subwrd(XRef,13)

yi=subwrd(YRef,11)
yf=subwrd(YRef,13)

varying=subwrd(result,8)
tim1=sublin(result,5)
t1=subwrd(tim1,6)
t2=subwrd(tim1,8)

if (varying = "varying" )
   'd scorr(xvar,yvar,x='xi',x='xf',y='yi',y='yf')'
   xycorr=subwrd(result,4)
else
   'set t 't1
   'd tcorr(xvar,yvar,time='t1',time='t2')'
   xycorr=subwrd(result,14)
   'set time 't1' 't2
endif
 
'set gxout stat'
if(doab=1)
   say "  Linear fit intercept = 0 "
   'd xvar*xvar'
   xsqbar=sublin(result,11);xsqbar=subwrd(xsqbar,2)
   'd yvar*xvar'
   xybar=sublin(result,11);xybar=subwrd(xybar,2)
   b=xybar/xsqbar
   a=0
else
   say " Linear fit with intercept "
   'd (xvar-'xbar')*(yvar-'ybar')'
   sxy1=sublin(result,10);sxy1=subwrd(sxy1,2)
   'd (xvar-'xbar')*(xvar-'xbar')'
   sxx1=sublin(result,10);sxx1=subwrd(sxx1,2)
   b=sxy1/sxx1
   a=ybar-b*xbar
endif
 
say 'Y = 'a' + 'b'*X'
 
* Draw lines
* ----------
'q gxinfo'
lim=sublin(result,3)
xlim1=subwrd(lim,4)
xlim2=subwrd(lim,6)
lim=sublin(result,4)
ylim1=subwrd(lim,4)
ylim2=subwrd(lim,6)
col1=4
if(doab=1)
   col1=3
endif
 
* Calculate coordinates to draw the fit line and the 1:1 line
* Both lines are constrained to stay inside the diagram
* -----------------------------------------------------------
'q xy2w 'xlim1' 'ylim1
x1a=subwrd(result,3)
y1a=subwrd(result,6)
y1=a+b*x1a
if(y1<y1a)
   x1=(y1a-a)/b
   y1=y1a
else
   x1=x1a
endif
 
if(x1a<y1a)
   x1a=y1a
else
   y1a=x1a
endif
 
'q w2xy 'x1' 'y1
xx1=subwrd(result,3)
yy1=subwrd(result,6)
 
'q xy2w 'xlim2' 'ylim2
x2a=subwrd(result,3)
y2a=subwrd(result,6)
y2=a+b*x2a
if(y2>y2a)
   x2=(y2a-a)/b
   y2=y2a
else
   x2=x2a
endif
 
if(x2a>y2a)
   x2a=y2a
else
   y2a=x2a
endif
 
'q w2xy 'x2' 'y2
xx2=subwrd(result,3)
yy2=subwrd(result,6)
'set line 'col1' 1 6'
'draw line 'xx1' 'yy1' 'xx2' 'yy2
 
* Draw 1:1 line
* -------------
'q w2xy 'x1a' 'y1a
xx1=subwrd(result,3)
yy1=subwrd(result,6)
 
'q w2xy 'x2a' 'y2a
xx2=subwrd(result,3)
yy2=subwrd(result,6)
 
'set line 2 2 6'
'draw line 'xx1' 'yy1' 'xx2' 'yy2
 
* Write the statistics to the diagram
* -----------------------------------
 
bout=substr(b,1,6)
xycout=substr(xycorr,1,6)
aout=substr(a,1,6)
 
* xlo from 16 will put the stats right outside
* Xlo from 14 will put the stats left side inside the scatter
* -----------------------------------------------------------
'q gxinfo'
xlo=subwrd(result,14)
yhi=subwrd(result,22)
 
xlo=xlo+0.1
dy=0.2
yhi=yhi-dy
 
'set string 4 tl'
if(doab = 1);  'set string 3 tl'  ;endif
'set strsiz 0.15'
yhi1=yhi
'draw string 'xlo' 'yhi1' b = 'bout
yhi1=yhi1-dy
'draw string 'xlo' 'yhi1' yint  = 'aout
yhi1=yhi1-dy
'draw string 'xlo' 'yhi1' count = 'ncnt
yhi1=yhi1-dy
'draw string 'xlo' 'yhi1' bias X-Y  = 'bias
yhi1=yhi1-dy
'draw string 'xlo' 'yhi1' std diff = 'stddiff
yhi1=yhi1-dy
'draw string 'xlo' 'yhi1' xycorr = 'xycout
'set gxout scatter'
 
