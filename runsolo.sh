#! /bin/sh -x

###module swap tupa aux


#PBS -l walltime=01:00:00
#PBS -l mppwidth=1
#PBS -l mppdepth=1
#PBS -l mppnppn=16
#PBS -N ccatt
#PBS -j oe
#PBS -o /scratch1/grupos/catt-brams/home/ariane.frassoni/logs
#PBS -q pesq


cd /scratch1/grupos/catt-brams/home/ariane.frassoni

export OMP_NUM_THREADS=1

#export MPICH_PTL_UNEX_EVENTS=655360#327680 #163840
#export MPICH_MAX_SHORT_MSG_SIZE=1024
#export MPICH_FAST_MEMCPY=1
#export HUGETLB_MORECORE=yes
#export HUGETLB_DEFAULT_PAGE_SIZE=2MB
#export XT_SYMMETRIC_HEAP_SIZE=4MB

ulimit -s unlimited
ulimit -c unlimited


aprun -n 1 ./ccatt-brams4.3_kbcon_15 -f CHEMRAMSIN_fabi > ./logs/fabi.out


