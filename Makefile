# Makefile for hardware implementation on Xilinx FPGAs and ASICs
# Author: Andreas Ehliar <ehliar@isy.liu.se>
# 
# T is the testbench file for this project
# S is the synthesizable sources for this project
# U is the UCF file
# PART is the part

# Important makefile targets:
# make proj1.sim	GUI simulation
# make proj1.simc	batch simulation
# make proj1.synth	Synthesize
# make proj1.route	Route the design
# make proj1.bitgen	Generate bit file
# make proj1.timing	Generate timing report
# make proj1.clean	Use whenever you change settings in the Makefile!
# make proj1.prog	Downloads the bitfile to the FPGA. NOTE: Does not
#                       rebuild bitfile if source files have changed!
# make clean            Removes all generated files for all projects. Also
#                       backup files (*~) are removed.
# 
# VIKTIG NOTERING: Om du ändrar vilka filer som finns med i projektet så måste du köra
#                  make proj1.clean
#
# Syntesrapporten ligger i proj1-synthdir/xst/synth/design.syr
# Maprapporten (bra att kolla i för arearapportens skull) ligger i proj1-synthdir/layoutdefault/design_map.mrp
# Timingrapporten (skapas av make proj1.timing) ligger i proj1-synthdir/layoutdefault/design.trw

# (Or proj2.simc, proj2.sim, etc, depending on the name of the
# project)

XILINX_INIT = source /sw/xilinx/ise_12.4i/ISE_DS/settings32.sh;
PART=xc6slx16-3-csg324


counter.%: S=counter.vhd
counter.%: T=counter_tb.vhd
counter.%: U=Nexys3_Master.ucf

prng.%: S=prng.vhd counter.vhd
prng.%: T=prng_tb.vhd
prng.%: U=

hej.%: S=alu.vhd constant.vhd
hej.%: T=alu_tb.vhd
hej.%: U=Nexys3_Master.ucf

gpu.%: S=gpu.vhd sprite.vhd counter.vhd mapmem.vhd tilemem.vhd
gpu.%: T=gpu_tb.vhd
gpu.%: U=gpu.ucf

ps2.%: S=ps2.vhd counter.vhd
ps2.%: T=
ps2.%: U=ps2.ucf

cpu.%: S= cpu.vhd k1.vhd k2.vhd k3.vhd gp_reg_8.vhd gp_reg_16.vhd micromem.vhd data_reg.vhd alu.vhd primmem.vhd constants.vhd
cpu.%: T=cpu_tb.vhd
cpu.%: U=Nexys3_Master.ucf

roej.%: S=roej.vhd prng.vhd gpu.vhd sprite.vhd ps2.vhd counter.vhd mapmem.vhd tilemem.vhd cpu.vhd k1.vhd k2.vhd k3.vhd gp_reg_8.vhd gp_reg_16.vhd micromem.vhd data_reg.vhd alu.vhd primmem.vhd constants.vhd realtime_counter.vhd
roej.%: T=roej_tb.vhd
roej.%: U=gpu.ucf

berika.%: S=realtime_counter.vhd counter.vhd
berika.%: T=realtime_counter_tb.vhd
berika.%: U=gpu.ucf

# Det här är ett exempel på hur man kan skriva en testbänk som är
# relevant, även om man kör en simulering i batchläge (make batchlab.simc)
# batchlab.%: S=lab.vhd leddriver.vhd
# batchlab.%: T=batchlab_tb.vhd tb_print7seg.vhd
# batchlab.%: U=lab.ucf


# Misc functions that are good to have
include build/util.mk
# Setup simulation environment
include build/vsim.mk
# Setup synthesis environment
include build/xst.mk
# Setup backend flow environment
include build/xilinx-par.mk
# Setup tools for programming the FPGA
include build/digilentprog.mk



# Alternative synthesis methods
# The following is for ASIC synthesis
#include design_compiler.mk
# The following is for synthesis to a Xilinx target using Precision.
#include precision-xilinx.mk



