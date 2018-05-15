createData<- function(){
  #
  # LINPACK Benchmark Dataprep
  #
  setwd('~/git/container_bench_results/linpack/docker')
  docker_compute<-read.table('results_simple_linpack.o', header=FALSE, stringsAsFactors = FALSE)
  setwd('~/git/container_bench_results/linpack/singularity')
  singularity_compute<-read.table('results_dock_ubuntu.o', header=FALSE, stringsAsFactors = FALSE)
  setwd('~/git/container_bench_results/linpack/vm')
  vm_compute<-read.table('results.o', header=FALSE, stringsAsFactors = FALSE)
  compute<-data.frame("VM"=vm_compute[,6], 'Docker'=docker_compute[,6], 'Singularity'=singularity_compute[,6])
  compute<-round(compute/1000000,3)
  boxplot(compute, ylab='MFlops')
  
  
  #
  # IOPERF Benchmark Dataprep
  #
  setwd('~/git/container_bench_results/ioperf/vm')
  vm_ioperf<-read.table('docker_io.out', header=TRUE,skip=1)
  vm_ioperf<-vm_ioperf/1000000
  setwd('~/git/container_bench_results/ioperf/docker/')
  docker_nobind_ioperf<-read.table('no_bind.out', header=TRUE, skip=1)
  docker_nobind_ioperf<-docker_nobind_ioperf/1000000
  docker_bind_ioperf<-read.table('bind.out', header=TRUE, skip=1)
  docker_bind_ioperf<-docker_bind_ioperf/1000000
  setwd('~/git/container_bench_results/ioperf/singularity/')
  singularity_nobind_ioperf<-read.table('no_bind.out', header=TRUE, skip=1)
  singularity_nobind_ioperf<-singularity_nobind_ioperf/1000000
  singularity_bind_ioperf<-read.table('bind.out', header=TRUE, skip=1)
  singularity_bind_ioperf<-singularity_bind_ioperf/1000000
  
  #
  # Read/Write
  #
  ioperf_readwrite<-cbind(vm_ioperf[,3], 
                     docker_nobind_ioperf[,3], 
                     docker_bind_ioperf[,3],
                     singularity_nobind_ioperf[,3],
                     singularity_bind_ioperf[,3],
                     vm_ioperf[,5], 
                     docker_nobind_ioperf[,5], 
                     docker_bind_ioperf[,5],
                     singularity_nobind_ioperf[,5],
                     singularity_bind_ioperf[,5])
  
  bpCols=c('blue', 'red', 'orange', 'green', 'cyan')
  boxplot(ioperf_readwrite, 
          at=c(1,2,3,4,5,7,8,9,10,11),
          xaxt='n', ann=FALSE,
          col=bpCols,
          ylab='GB/sec')
  axis(1, at=c(3, 9), labels=c('read', 'write'))
  
  legend(1, 2.7, c('virtual machine', 
                       'docker no-bind', 
                       'docker bind',
                       'singularity no-bind',
                       'singularity bind'),
         lty=1,
         lwd=5,
         col=bpCols)
  
  #
  # Random Read/Write
  #
  ioperf_random_readwrite<-cbind(vm_ioperf[,7], 
                          docker_nobind_ioperf[,7], 
                          docker_bind_ioperf[,7],
                          singularity_nobind_ioperf[,7],
                          singularity_bind_ioperf[,7],
                          vm_ioperf[,8], 
                          docker_nobind_ioperf[,8], 
                          docker_bind_ioperf[,8],
                          singularity_nobind_ioperf[,8],
                          singularity_bind_ioperf[,8])
  
  bpCols=c('blue', 'red', 'orange', 'green', 'cyan')
  boxplot(ioperf_random_readwrite, 
          at=c(1,2,3,4,5,7,8,9,10,11),
          xaxt='n', ann=FALSE,
          col=bpCols,
          ylab='GB/sec')
  axis(1, at=c(3, 9), labels=c('random read', 'random write'))
  
  legend(3.5, 1.1, c('virtual machine', 
                   'docker no-bind', 
                   'docker bind',
                   'singularity no-bind',
                   'singularity bind'),
         lty=1,
         lwd=5,
         col=bpCols)
  
  
  #
  # Memory STREAM benchmark
  #
  setwd('~/git/container_bench_results/memory/vm')
  vm_stream<-read.table('docker_stream.out')
  setwd('~/git/container_bench_results/memory/docker')
  docker_stream<-read.table('stream_bench.out')
  setwd('~/git/container_bench_results/memory/singularity/')
  singularity_stream<-read.table('stream_bench.out')
  
  stream_copy<-cbind(vm_stream[seq(1,40,4),2], docker_stream[seq(1,40,4),2], singularity_stream[seq(1,40,4),2])
  stream_scale<-cbind(vm_stream[seq(2,40,4),2], docker_stream[seq(2,40,4),2], singularity_stream[seq(2,40,4),2])
  stream_add<-cbind(vm_stream[seq(3,40,4),2], docker_stream[seq(3,40,4),2], singularity_stream[seq(3,40,4),2])
  stream_triad<-cbind(vm_stream[seq(4,40,4),2], docker_stream[seq(4,40,4),2], singularity_stream[seq(4,40,4),2])
  stream_results<-cbind(stream_copy,stream_scale, stream_add, stream_triad) 
  
  
  bpCols=c('blue', 'red', 'green')
  boxplot(stream_results,
          at=c(1,2,3,5,6,7,9,10,11, 13,14,15),
          xaxt='n', ann=FALSE,
          col=bpCols,
          ylab='MB/sec')
  axis(1, at=c(2, 6, 10, 14), labels=c('copy', 'scale', 'add', 'triad'))
  
  legend(1, 11800, c('virtual machine', 
                     'docker', 
                     'singularity'),
         lty=1,
         lwd=5,
         col=bpCols)
  
  
  rawData<-c(1,2,3,4)
  return(rawData)
}