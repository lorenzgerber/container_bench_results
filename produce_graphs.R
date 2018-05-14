createData<- function(){
  # Collecting Data for LINPACK Benchmark
  setwd('~/git/container_bench_results/linpack/docker')
  docker_compute<-read.table('results_simple_linpack.o', header=FALSE, stringsAsFactors = FALSE)
  setwd('~/git/container_bench_results/linpack/singularity')
  singularity_compute<-read.table('results_dock_ubuntu.o', header=FALSE, stringsAsFactors = FALSE)
  setwd('~/git/container_bench_results/linpack/vm')
  vm_compute<-read.table('results.o', header=FALSE, stringsAsFactors = FALSE)
  compute<-data.frame("VM"=vm_compute[,6], 'Docker'=docker_compute[,6], 'Singularity'=singularity_compute[,6])
  compute<-round(compute/1000000,3)
  boxplot(compute, ylab='MFlops')
  
  # Collecting Data for IOPERF Benchmark
  # next need to copy data from benchmark repo to
  # result repo. Further there is data on ioperf
  # in the VM directory
  setwd('~/git/container_bench_results/')
  
  
  rawData<-c(1,2,3,4)
  return(rawData)
}