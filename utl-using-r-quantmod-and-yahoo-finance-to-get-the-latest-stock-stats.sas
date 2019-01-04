Using R quantmod and yahoo finance to get the latest stock stats

github
https://tinyurl.com/ybmyf3pk
https://github.com/rogerjdeangelis/utl-using-r-quantmod-and-yahoo-finance-to-get-the-latest-stock-stats

StackOverflow
https://stackoverflow.com/questions/53980350/how-to-scrape-key-statistics-from-yahoo-finance-with-r

K. Peltzer
https://stackoverflow.com/users/10842883/k-peltzer

INPUT
=====

 Stocks

  XOM MSFT JNJ GE CVX WFC PG JPM VZ PFE T IBM MRK BAC DIS ORCL PM INTC SLB

  R  yahooQF function to query Yahoo Finance

EXAMPLE OUTPUT
--------------

 METRICS total obs=19

  TICKER         TRADE_TI         P_E_RATI    PRICE_EP    DIVIDEND        MARKET_C

   XOM      04JAN2019:16:00:36      13.089     13.7621    0.046342    $301,235,568,640
   MSFT     04JAN2019:16:00:01      41.981     20.2644    0.017659    $782,568,587,264
   JNJ      04JAN2019:16:00:55     224.657     14.8295    0.027681    $342,837,493,760
   GE       04JAN2019:16:00:11        .         9.6824    0.059553     $71,585,521,664
   CVX      04JAN2019:16:00:45      14.919     13.3679    0.040895    $211,751,534,592
   WFC      04JAN2019:16:00:34      11.325      9.3836    0.034357    $225,712,160,768
   PG       04JAN2019:16:00:48      24.161     19.5953    0.031046    $230,430,490,624
   JPM      04JAN2019:16:00:11      12.497      9.9990    0.025538    $334,788,231,168
   VZ       04JAN2019:16:02:25       7.203     11.9407    0.042209    $232,880,652,288
   PFE      04JAN2019:16:00:38      10.861     13.9610    0.031874    $248,560,205,824
   T        04JAN2019:16:00:30       5.891      8.4749    0.067613    $220,814,524,416
   IBM      04JAN2019:16:01:47      18.907      8.4342    0.054380    $106,619,707,392
   MRK      04JAN2019:16:00:43      61.757     16.1932    0.025797    $198,330,974,208
   BAC      04JAN2019:16:00:55      12.204      8.9441    0.020765    $251,047,247,872
   DIS      04JAN2019:16:02:11      13.111     14.5758    0.016176    $163,173,122,048
   ORCL     04JAN2019:16:01:41      46.617     12.7275    0.016972    $167,638,450,176
   PM       04JAN2019:16:01:24      16.182     13.1474    0.066526    $108,116,877,312
   INTC     04JAN2019:16:00:01      14.756     10.3326    0.026343    $215,512,072,192
   SLB      04JAN2019:16:05:31        .        20.2539    0.053191     $54,131,830,784


PROCESS
=======

%utl_submit_r64('
library(quantmod);
library(plyr);
library(SASxport);
what_metrics <- yahooQF(c("Price/Sales",
   "P/E Ratio",
   "Price/EPS Estimate Next Year",
   "PEG Ratio",
   "Dividend Yield",
   "Market Capitalization"));
Symbols<-c("XOM","MSFT","JNJ","GE","CVX","WFC","PG","JPM","VZ","PFE","T","IBM","MRK","BAC","DIS","ORCL","PM","INTC","SLB");
metrics <- getQuote(paste(Symbols, sep="", collapse=";"), what=what_metrics);
str(metrics);
metrics$ticker=rownames(metrics);
write.xport(metrics,file="d:/xpt/metrics.xpt");
');

libname xpt xport "d:/xpt/metrics.xpt";

data metrics;
  retain ticker;
  set xpt.metrics;
  format TRADE_TI datetime28. market_c $dollar18.;
run;quit;

OUTPUT
======
see above;




