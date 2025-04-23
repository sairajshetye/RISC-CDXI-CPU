# AG Report mp_ooo_arch_im 2025-04-22T23:59:59-05:00 
Report generated at 2025-04-23T04:30:28-05:00, using commit ``4a6db8947f025d79683631ff4e2970a704c471c4``

Autograder Run ID: 4afe56c0-63d2-41e8-bdda-88e08e5266d9

Autograder Job ID: 9f3e48dd-6506-4370-bb0f-8a5ec2494d35

|Tests|Result|
|---|---|
|SRAM|✅|
|compile|✅|
|add|❌|
|addi|❌|
|and|❌|
|andi|❌|
|auipc|❌|
|beq|❌|
|bge|❌|
|bgeu|❌|
|blt|❌|
|bltu|❌|
|bne|❌|
|jal|❌|
|jalr|❌|
|lbu-align|❌|
|lb-align|❌|
|lhu-align|❌|
|lh-align|❌|
|lui|❌|
|lw-align|❌|
|misalign1-jalr|❌|
|or|❌|
|ori|❌|
|sb-align|❌|
|sh-align|❌|
|sll|❌|
|slli|❌|
|slt|❌|
|slti|❌|
|sltiu|❌|
|sltu|❌|
|sra|❌|
|srai|❌|
|srl|❌|
|srli|❌|
|sub|❌|
|sw-align|❌|
|xor|❌|
|xori|❌|
|div|❌|
|divu|❌|
|mul|❌|
|mulh|❌|
|mulhsu|❌|
|mulhu|❌|
|rem|❌|
|remu|❌|

### Logs
<details><summary>SRAM ✅</summary> 

 ``` 
 make clean
make[1]: Entering directory '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram'
rm -rf output
mkdir output
touch output/.gitkeep
make[1]: Leaving directory '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram'
python3 sram.py
sync
make -j4 
make[1]: Entering directory '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram'
make clean
make[2]: Entering directory '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram'
rm -rf output
mkdir output
touch output/.gitkeep
make[2]: Leaving directory '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram'
python3 sram.py
sync
make -j4 mp_cache_tag_array mp_cache_data_array
make[2]: Entering directory '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram'
make[2]: warning: -j4 forced in submake: resetting jobserver mode.
source /srv/ece411ag/OpenRAM/miniconda/bin/activate ;\
python3 /srv/ece411ag/OpenRAM/compiler/../sram_compiler.py /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.py
source /srv/ece411ag/OpenRAM/miniconda/bin/activate ;\
python3 /srv/ece411ag/OpenRAM/compiler/../sram_compiler.py /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array.py
|==============================================================================|
|=========                      OpenRAM v1.2.48                       =========|
|=========                                                            =========|
|=========               VLSI Design and Automation Lab               =========|
|=========        Computer Science and Engineering Department         =========|
|=========            University of California Santa Cruz             =========|
|=========                                                            =========|
|=========          Usage help: openram-user-group@ucsc.edu           =========|
|=========        Development help: openram-dev-group@ucsc.edu        =========|
|=========                See LICENSE for license info                =========|
|==============================================================================|
** Start: 04/23/2025 04:30:34
Technology: freepdk45
Total size: 4096 bits
Word size: 256
Words: 16
Banks: 1
Write size: 8
RW ports: 1
R-only ports: 0
W-only ports: 0
Design supply routing skipped. Supplies will have multiple must-connect pins. (route_supplies=True to enable supply routing).
DRC/LVS/PEX is only run on the top-level design to save run-time (inline_lvsdrc=True to do inline checking).
DRC/LVS/PEX is disabled (check_lvsdrc=True to enable).
Characterization is disabled (using analytical delay models) (analytical_delay=False to simulate).
Only generating nominal corner timing.
Words per row: None
Output files are: 
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array.lvs
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array.sp
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array.v
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array.lib
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array.py
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array.html
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array.log
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array.lef
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array.gds
|==============================================================================|
|=========                      OpenRAM v1.2.48                       =========|
|=========                                                            =========|
|=========               VLSI Design and Automation Lab               =========|
|=========        Computer Science and Engineering Department         =========|
|=========            University of California Santa Cruz             =========|
|=========                                                            =========|
|=========          Usage help: openram-user-group@ucsc.edu           =========|
|=========        Development help: openram-dev-group@ucsc.edu        =========|
|=========                See LICENSE for license info                =========|
|==============================================================================|
** Start: 04/23/2025 04:30:34
Technology: freepdk45
Total size: 368 bits
Word size: 23
Words: 16
Banks: 1
RW ports: 1
R-only ports: 0
W-only ports: 0
Design supply routing skipped. Supplies will have multiple must-connect pins. (route_supplies=True to enable supply routing).
DRC/LVS/PEX is only run on the top-level design to save run-time (inline_lvsdrc=True to do inline checking).
DRC/LVS/PEX is disabled (check_lvsdrc=True to enable).
Characterization is disabled (using analytical delay models) (analytical_delay=False to simulate).
Only generating nominal corner timing.
Words per row: None
Output files are: 
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.lvs
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.sp
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.v
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.lib
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.py
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.html
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.log
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.lef
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.gds
** Submodules: 1.6 seconds
** Placement: 0.0 seconds
** Routing: 0.0 seconds
** Verification: 0.0 seconds
** SRAM creation: 1.6 seconds
SP: Writing to /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.sp
** Spice writing: 0.1 seconds
DELAY: Writing stimulus...
** DELAY: 0.2 seconds
GDS: Writing to /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.gds
** GDS: 0.6 seconds
LEF: Writing to /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.lef
** LEF: 0.0 seconds
LVS: Writing to /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.lvs.sp
** LVS writing: 0.0 seconds
LIB: Characterizing... 
** Characterization: 0.2 seconds
Config: Writing to /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.py
** Config: 0.0 seconds
Datasheet: Writing to /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.html
** Datasheet: 0.0 seconds
Verilog: Writing to /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.v
** Verilog: 0.0 seconds
Extended Config: Writing to /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array_extended.py
** Extended Config: 0.0 seconds
** End: 2.8 seconds
sed -i -E 's/falling_edge/rising_edge/g' /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array_TT_1p0V_25C.lib
source /srv/ece411ag/OpenRAM/miniconda/bin/activate ;\
python3 /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/area.py /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.gds > /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.area.txt
cat ./output/mp_cache_tag_array/mp_cache_tag_array.area.txt | xargs -I {} sed -i -E 's/area : .*/area : {}/g' output/mp_cache_tag_array/mp_cache_tag_array_TT_1p0V_25C.lib
cd /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array ;\
lc_shell -x 'read_lib /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array_TT_1p0V_25C.lib; write_lib mp_cache_tag_array_TT_1p0V_25C_lib; exit' ;\
rm -f lc*.log lc*.txt

                             Library Compiler (TM)
                                 DesignWare (R)

                  Version W-2024.09 for linux64 - Aug 26, 2024
  This release has significant feature enhancements. Please review the Release
                       Notes associated with this release.

                    Copyright (c) 1988 - 2024 Synopsys, Inc.
   This software and the associated documentation are proprietary to Synopsys,
 Inc. This software may only be used in accordance with the terms and conditions
 of a written license agreement with Synopsys, Inc. All other use, reproduction,
   or distribution of this software is strictly prohibited.  Licensed Products
     communicate with Synopsys servers for the purpose of providing software
    updates, detecting software piracy and verifying that customers are using
    Licensed Products in conformity with the applicable License Key for such
  Licensed Products. Synopsys will use information gathered in connection with
    this process to deliver software updates and pursue software pirates and
                                   infringers.

 Inclusivity & Diversity - Visit SolvNetPlus to read the "Synopsys Statement on
            Inclusivity and Diversity" (Refer to article 000036315 at
                        https://solvnetplus.synopsys.com)
 
Initializing...
Reading '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array_TT_1p0V_25C.lib' ...
Warning: Line 1, The 'internal_power_calculation' attribute in char_config group is required for NLPM library. 
	No default can be applied to this attribute. (LBDB-366)
Information: Line 74, Cell 'mp_cache_tag_array', The cell 'mp_cache_tag_array' contiains memory/memory_read/memory_write groups which are deprecated, use the is_memory_cell attribute instead. (LIBG-280)
Technology library 'mp_cache_tag_array_TT_1p0V_25C_lib' read successfully
Wrote the 'mp_cache_tag_array_TT_1p0V_25C_lib' library to 'mp_cache_tag_array_TT_1p0V_25C_lib.db' successfully
Maximum memory usage for this session: 93.18 MB
CPU usage for this session:      2 seconds (  0.00 hours)
Elapsed time for this session:      2 seconds (  0.00 hours)
Thank you for using Library Compiler.

Thank you...
** Submodules: 22.9 seconds
** Placement: 1.7 seconds
** Routing: 0.0 seconds
** Verification: 0.0 seconds
** SRAM creation: 24.6 seconds
SP: Writing to /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array.sp
** Spice writing: 0.7 seconds
DELAY: Writing stimulus...
** DELAY: 1.2 seconds
GDS: Writing to /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array.gds
** GDS: 3.8 seconds
LEF: Writing to /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array.lef
** LEF: 0.0 seconds
LVS: Writing to /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array.lvs.sp
** LVS writing: 0.2 seconds
LIB: Characterizing... 
** Characterization: 1.6 seconds
Config: Writing to /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array.py
** Config: 0.0 seconds
Datasheet: Writing to /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array.html
** Datasheet: 0.0 seconds
Verilog: Writing to /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array.v
** Verilog: 0.0 seconds
Extended Config: Writing to /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array_extended.py
** Extended Config: 0.0 seconds
** End: 32.4 seconds
sed -i -E 's/falling_edge/rising_edge/g' /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array_TT_1p0V_25C.lib
source /srv/ece411ag/OpenRAM/miniconda/bin/activate ;\
python3 /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/area.py /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array.gds > /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array.area.txt
cat ./output/mp_cache_data_array/mp_cache_data_array.area.txt | xargs -I {} sed -i -E 's/area : .*/area : {}/g' output/mp_cache_data_array/mp_cache_data_array_TT_1p0V_25C.lib
cd /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array ;\
lc_shell -x 'read_lib /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array_TT_1p0V_25C.lib; write_lib mp_cache_data_array_TT_1p0V_25C_lib; exit' ;\
rm -f lc*.log lc*.txt

                             Library Compiler (TM)
                                 DesignWare (R)

                  Version W-2024.09 for linux64 - Aug 26, 2024
  This release has significant feature enhancements. Please review the Release
                       Notes associated with this release.

                    Copyright (c) 1988 - 2024 Synopsys, Inc.
   This software and the associated documentation are proprietary to Synopsys,
 Inc. This software may only be used in accordance with the terms and conditions
 of a written license agreement with Synopsys, Inc. All other use, reproduction,
   or distribution of this software is strictly prohibited.  Licensed Products
     communicate with Synopsys servers for the purpose of providing software
    updates, detecting software piracy and verifying that customers are using
    Licensed Products in conformity with the applicable License Key for such
  Licensed Products. Synopsys will use information gathered in connection with
    this process to deliver software updates and pursue software pirates and
                                   infringers.

 Inclusivity & Diversity - Visit SolvNetPlus to read the "Synopsys Statement on
            Inclusivity and Diversity" (Refer to article 000036315 at
                        https://solvnetplus.synopsys.com)
 
Initializing...
Reading '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram/output/mp_cache_data_array/mp_cache_data_array_TT_1p0V_25C.lib' ...
Warning: Line 1, The 'internal_power_calculation' attribute in char_config group is required for NLPM library. 
	No default can be applied to this attribute. (LBDB-366)
Information: Line 82, Cell 'mp_cache_data_array', The cell 'mp_cache_data_array' contiains memory/memory_read/memory_write groups which are deprecated, use the is_memory_cell attribute instead. (LIBG-280)
Technology library 'mp_cache_data_array_TT_1p0V_25C_lib' read successfully
Wrote the 'mp_cache_data_array_TT_1p0V_25C_lib' library to 'mp_cache_data_array_TT_1p0V_25C_lib.db' successfully
Maximum memory usage for this session: 93.17 MB
CPU usage for this session:      2 seconds (  0.00 hours)
Elapsed time for this session:      2 seconds (  0.00 hours)
Thank you for using Library Compiler.

Thank you...
make[2]: Leaving directory '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram'
make[1]: Leaving directory '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sram'
 
 ``` 

 </details> 
<details><summary>compile ✅</summary> 

 ``` 
 10000
0
mkdir -p vcs
python3 ../bin/rvfi_reference.py 8 +define+ECE411_NO_FLOAT
cd vcs && vcs /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../pkg/types.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/funct_units/branch_funct_unit.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/funct_units/int_funct_unit.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/funct_units/memory_funct_unit.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/funct_units/mul_div_funct_unit.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/regfiles/free_list.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/regfiles/prf.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/regfiles/prf_queue.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/regfiles/rat_arf.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/cpu.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/fifo.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/pcreg.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/robert.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/00_fetch.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/01_inst_q.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/100.1_rename_q.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/1000_writeback.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/1001_commit.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/100_rename_alloc.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/101_dispatch.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/10_decode.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/110.1_r_station.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/110_r_station.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/111.1_pre_wb_q.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/111_issue.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/11_decode_q.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/arbiter.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/elshank2_cache.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/elshank2_cache_mod.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/linebuffer.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/provided_cache.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/sp_ff_array.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/mem_itf.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/mon_itf.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/rvfimon.v /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/spike.so /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/dram_w_burst_frfcfs_controller.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/vcs/top_tb.sv /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../sram/output/mp_cache_data_array/mp_cache_data_array.v /srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../sram/output/mp_cache_tag_array/mp_cache_tag_array.v /software/Synopsys-2024_x86_64/icc/W-2024.09/dw/sim_ver/DW_mult_pipe.v /software/Synopsys-2024_x86_64/icc/W-2024.09/dw/sim_ver/DW02_mult.v /software/Synopsys-2024_x86_64/icc/W-2024.09/dw/sim_ver/DW_div_pipe.v /software/Synopsys-2024_x86_64/icc/W-2024.09/dw/sim_ver/DW_div.v +incdir+/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common  +define+ECE411_NO_FLOAT +define+DW_SUPPRESS_WARN +incdir+/software/Synopsys-2024_x86_64/icc/W-2024.09/dw/sim_ver +incdir+/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/vcs -licqueue -full64 -lca -sverilog -timescale=1ps/1ps -debug_acc+all -kdb -suppress=LCA_FEATURES_ENABLED -msg_config=../vcs_warn.config -xprop=../xprop.config -xprop=flowctrl -assert svaext -l compile.log -top top_tb -o top_tb
                         Chronologic VCS (TM)
         Version W-2024.09_Full64 -- Wed Apr 23 04:31:17 2025

                    Copyright (c) 1991 - 2024 Synopsys, Inc.
   This software and the associated documentation are proprietary to Synopsys,
 Inc. This software may only be used in accordance with the terms and conditions
 of a written license agreement with Synopsys, Inc. All other use, reproduction,
   or distribution of this software is strictly prohibited.  Licensed Products
     communicate with Synopsys servers for the purpose of providing software
    updates, detecting software piracy and verifying that customers are using
    Licensed Products in conformity with the applicable License Key for such
  Licensed Products. Synopsys will use information gathered in connection with
    this process to deliver software updates and pursue software pirates and
                                   infringers.

 Inclusivity & Diversity - Visit SolvNetPlus to read the "Synopsys Statement on
            Inclusivity and Diversity" (Refer to article 000036315 at
                        https://solvnetplus.synopsys.com)

Reading Config file '../xprop.config'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../pkg/types.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/funct_units/branch_funct_unit.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/funct_units/int_funct_unit.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/funct_units/memory_funct_unit.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/funct_units/mul_div_funct_unit.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/regfiles/free_list.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/regfiles/prf.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/regfiles/prf_queue.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/regfiles/rat_arf.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/cpu.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/fifo.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/pcreg.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/robert.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/00_fetch.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/01_inst_q.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/100.1_rename_q.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/1000_writeback.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/1001_commit.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/100_rename_alloc.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/101_dispatch.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/10_decode.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/110.1_r_station.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/110_r_station.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/111.1_pre_wb_q.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/111_issue.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/11_decode_q.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/arbiter.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/elshank2_cache.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/elshank2_cache_mod.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/linebuffer.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/provided_cache.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/sp_ff_array.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/mem_itf.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/mon_itf.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/rvfimon.v'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/dram_w_burst_frfcfs_controller.sv'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/vcs/top_tb.sv'
Parsing included file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh'.
Parsing included file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/rvfi_reference.svh'.
Back to file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh'.
Back to file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/vcs/top_tb.sv'.
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../sram/output/mp_cache_data_array/mp_cache_data_array.v'
Parsing design file '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../sram/output/mp_cache_tag_array/mp_cache_tag_array.v'
Parsing design file '/software/Synopsys-2024_x86_64/icc/W-2024.09/dw/sim_ver/DW_mult_pipe.v'
Parsing design file '/software/Synopsys-2024_x86_64/icc/W-2024.09/dw/sim_ver/DW02_mult.v'
Parsing design file '/software/Synopsys-2024_x86_64/icc/W-2024.09/dw/sim_ver/DW_div_pipe.v'
Parsing design file '/software/Synopsys-2024_x86_64/icc/W-2024.09/dw/sim_ver/DW_div.v'
Parsing included file '/software/Synopsys-2024_x86_64/icc/W-2024.09/dw/sim_ver/DW_div_function.inc'.
Back to file '/software/Synopsys-2024_x86_64/icc/W-2024.09/dw/sim_ver/DW_div.v'.
Top Level Modules:
       top_tb
TimeScale is 1 ps / 1 ps
Notice: Ports coerced to inout, use -notice for details
Starting vcs inline pass...
81 modules and 0 UDP read.
recompiling package rv32i_types
recompiling module integer_unit
recompiling module multiply_divide_unit
recompiling module free_list
recompiling module prf
recompiling module rat_arf
recompiling module cpu
recompiling module pcreg
recompiling module robert
recompiling module if_stage
recompiling module inst_q
recompiling module rename_q
recompiling module writeback
recompiling module rename_alloc
recompiling module dispatch
recompiling module id_stage
recompiling module r_station
recompiling module pre_wb_q
recompiling module decode_q
recompiling module arbiter
recompiling module cache_mod
recompiling module sp_ff_array
recompiling module monitor
recompiling module mem_itf_banked
recompiling module mon_itf
recompiling module riscv_formal_monitor_rv32imc
recompiling module riscv_formal_monitor_rv32imc_rob
recompiling module riscv_formal_monitor_rv32imc_isa_spec
recompiling module riscv_formal_monitor_rv32imc_insn_c_jr
recompiling module riscv_formal_monitor_rv32imc_insn_c_li
recompiling module riscv_formal_monitor_rv32imc_insn_c_lui
recompiling module riscv_formal_monitor_rv32imc_insn_c_lw
recompiling module riscv_formal_monitor_rv32imc_insn_c_lwsp
recompiling module riscv_formal_monitor_rv32imc_insn_c_mv
recompiling module riscv_formal_monitor_rv32imc_insn_c_or
recompiling module riscv_formal_monitor_rv32imc_insn_c_slli
recompiling module riscv_formal_monitor_rv32imc_insn_c_srai
recompiling module riscv_formal_monitor_rv32imc_insn_c_srli
recompiling module riscv_formal_monitor_rv32imc_insn_c_sub
recompiling module riscv_formal_monitor_rv32imc_insn_c_sw
recompiling module riscv_formal_monitor_rv32imc_insn_c_swsp
recompiling module riscv_formal_monitor_rv32imc_insn_c_xor
recompiling module riscv_formal_monitor_rv32imc_insn_divu
recompiling module riscv_formal_monitor_rv32imc_insn_jal
recompiling module riscv_formal_monitor_rv32imc_insn_jalr
recompiling module riscv_formal_monitor_rv32imc_insn_lb
recompiling module riscv_formal_monitor_rv32imc_insn_lbu
recompiling module riscv_formal_monitor_rv32imc_insn_lh
recompiling module riscv_formal_monitor_rv32imc_insn_lhu
recompiling module riscv_formal_monitor_rv32imc_insn_lui
50 of 81 modules done
recompiling module riscv_formal_monitor_rv32imc_insn_lw
recompiling module riscv_formal_monitor_rv32imc_insn_mul
recompiling module riscv_formal_monitor_rv32imc_insn_mulh
recompiling module riscv_formal_monitor_rv32imc_insn_mulhsu
recompiling module riscv_formal_monitor_rv32imc_insn_mulhu
recompiling module riscv_formal_monitor_rv32imc_insn_or
recompiling module riscv_formal_monitor_rv32imc_insn_ori
recompiling module riscv_formal_monitor_rv32imc_insn_remu
recompiling module riscv_formal_monitor_rv32imc_insn_sb
recompiling module riscv_formal_monitor_rv32imc_insn_sh
recompiling module riscv_formal_monitor_rv32imc_insn_sll
recompiling module riscv_formal_monitor_rv32imc_insn_slli
recompiling module riscv_formal_monitor_rv32imc_insn_slt
recompiling module riscv_formal_monitor_rv32imc_insn_slti
recompiling module riscv_formal_monitor_rv32imc_insn_sltiu
recompiling module riscv_formal_monitor_rv32imc_insn_sltu
recompiling module riscv_formal_monitor_rv32imc_insn_sra
recompiling module riscv_formal_monitor_rv32imc_insn_srai
recompiling module riscv_formal_monitor_rv32imc_insn_srl
recompiling module riscv_formal_monitor_rv32imc_insn_srli
recompiling module riscv_formal_monitor_rv32imc_insn_sub
recompiling module riscv_formal_monitor_rv32imc_insn_sw
recompiling module riscv_formal_monitor_rv32imc_insn_xor
recompiling module riscv_formal_monitor_rv32imc_insn_xori
recompiling module top_tb
recompiling module mp_cache_data_array
recompiling module mp_cache_tag_array
recompiling module DW_mult_pipe
recompiling module DW02_mult
recompiling module DW_div_pipe
recompiling module DW_div
All of 81 modules done
make[1]: Entering directory '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/vcs/csrc'
make[1]: Leaving directory '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/vcs/csrc'
make[1]: Entering directory '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/vcs/csrc'
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../top_tb ]; then chmod a-x ../top_tb; fi
g++  -o ../top_tb      -rdynamic  -Wl,-rpath='$ORIGIN'/top_tb.daidir -Wl,-rpath=./top_tb.daidir -Wl,-rpath=/software/Synopsys-2024_x86_64/vcs/W-2024.09/linux64/lib -L/software/Synopsys-2024_x86_64/vcs/W-2024.09/linux64/lib  -Wl,-rpath-link=./  /usr/lib64/libnuma.so.1   objs/amcQw_d.o   _48380_archive_1.so   SIM_l.o      rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs spike.so    -lvcsnew -lsimprofile -luclinative /software/Synopsys-2024_x86_64/vcs/W-2024.09/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive       ./../top_tb.daidir/vc_hdrs.o  _vcs_pli_stub_.o   /software/Synopsys-2024_x86_64/vcs/W-2024.09/linux64/lib/vcs_save_restore_new.o /software/Synopsys-2024_x86_64/verdi/W-2024.09/share/PLI/VCS/LINUX64/pli.a -ldl  -lc -lm -lpthread -ldl 
../top_tb up to date
make[1]: Leaving directory '/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/vcs/csrc'
CPU time: 6.714 seconds to compile + .679 seconds to elab + .634 seconds to link
Verdi KDB elaboration done and the database successfully generated
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/funct_units/int_funct_unit.sv:59 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/funct_units/int_funct_unit.sv:73 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/funct_units/int_funct_unit.sv:105 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/funct_units/mul_div_funct_unit.sv:63 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/funct_units/mul_div_funct_unit.sv:219 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/funct_units/mul_div_funct_unit.sv:299 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/regfiles/free_list.sv:74 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/regfiles/free_list.sv:97 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/regfiles/prf.sv:28 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/regfiles/prf.sv:40 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/regfiles/rat_arf.sv:38 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/regfiles/rat_arf.sv:61 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/regfiles/rat_arf.sv:132 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/cpu.sv:130 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/cpu.sv:143 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/cpu.sv:385 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/cpu.sv:465 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/cpu.sv:482 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/pcreg.sv:9 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/robert.sv:60 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/robert.sv:69 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/robert.sv:120 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/00_fetch.sv:24 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/00_fetch.sv:54 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/00_fetch.sv:63 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/01_inst_q.sv:75 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/01_inst_q.sv:99 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/100.1_rename_q.sv:75 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/100.1_rename_q.sv:99 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/1000_writeback.sv:36 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/100_rename_alloc.sv:49 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/100_rename_alloc.sv:65 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/100_rename_alloc.sv:120 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/101_dispatch.sv:76 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/101_dispatch.sv:80 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/101_dispatch.sv:85 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/101_dispatch.sv:91 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/101_dispatch.sv:105 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/10_decode.sv:48 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/10_decode.sv:121 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/110_r_station.sv:75 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/110_r_station.sv:125 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/110_r_station.sv:134 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/110_r_station.sv:138 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/110_r_station.sv:143 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/110_r_station.sv:149 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/111.1_pre_wb_q.sv:75 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/111.1_pre_wb_q.sv:101 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/11_decode_q.sv:75 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/stages/11_decode_q.sv:99 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/arbiter.sv:61 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/arbiter.sv:77 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/arbiter.sv:100 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/arbiter.sv:127 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/sp_ff_array.sv:22 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/sp_ff_array.sv:36 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../sram/output/mp_cache_data_array/mp_cache_data_array.v:42 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../sram/output/mp_cache_data_array/mp_cache_data_array.v:53 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../sram/output/mp_cache_tag_array/mp_cache_tag_array.v:38 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../sram/output/mp_cache_tag_array/mp_cache_tag_array.v:48 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/elshank2_cache_mod.sv:162 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/elshank2_cache_mod.sv:172 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/elshank2_cache_mod.sv:179 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/elshank2_cache_mod.sv:234 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/elshank2_cache_mod.sv:371 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/elshank2_cache_mod.sv:379 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/sp_ff_array.sv:22 YES
/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hdl/caches/sp_ff_array.sv:36 YES
==================================================
X P R O P   S T A T I S T I C S
instrumentable assignments:    681
instrumented assignments:      681
instrumentation success rate:  100%
[0;32mCompile Successful [0m
 
 ``` 

 </details> 
<details><summary>add ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/add/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/add/add.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:31 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/add/add.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/add/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/add/memory_32.lst
Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 33: top_tb: at time 10000005000 ps
TB Error: Timed out
Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 34: top_tb: at time 10000005000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 34.
Monitor: Total IPC: 0.000000
Monitor: Total Time:          10000005000
$finish at simulation time          10000005000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 10000005000 ps
CPU Time:     30.700 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:31:56 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>addi ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/addi/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/addi/addi.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:31 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/addi/addi.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/addi/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/addi/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 655000 ps
Spike Monitor Error at time 655000 channel 0 order 16
Expected order 0, got 16.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 665000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015625
Monitor: Total Time:               665000
$finish at simulation time               665000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 665000 ps
CPU Time:      0.420 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:31:57 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>and ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/and/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/and/and.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:31 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/and/and.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/and/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/and/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 655000 ps
Spike Monitor Error at time 655000 channel 0 order 16
Expected order 0, got 16.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 665000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015625
Monitor: Total Time:               665000
$finish at simulation time               665000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 665000 ps
CPU Time:      0.320 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:31:57 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>andi ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/andi/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/andi/andi.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:31 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/andi/andi.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/andi/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/andi/memory_32.lst
dut commit No.                   0, rd_s: x22, rd: 0xfffffffe

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 675000 ps
Spike Monitor Error at time 675000 channel 0 order 18
Expected order 2, got 18.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 685000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.045455
Monitor: Total Time:               685000
$finish at simulation time               685000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 685000 ps
CPU Time:      0.320 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:31:58 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>auipc ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/auipc/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/auipc/auipc.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:31 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/auipc/auipc.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/auipc/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/auipc/memory_32.lst
Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 33: top_tb: at time 10000005000 ps
TB Error: Timed out
Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 34: top_tb: at time 10000005000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 34.
Monitor: Total IPC: 0.000000
Monitor: Total Time:          10000005000
$finish at simulation time          10000005000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 10000005000 ps
CPU Time:     19.000 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:32:18 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>beq ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/beq/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/beq/beq.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:32 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/beq/beq.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/beq/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/beq/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 655000 ps
Spike Monitor Error at time 655000 channel 0 order 16
Expected order 0, got 16.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 665000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015625
Monitor: Total Time:               665000
$finish at simulation time               665000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 665000 ps
CPU Time:      0.350 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:32:19 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>bge ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bge/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bge/bge.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:32 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bge/bge.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bge/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bge/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 655000 ps
Spike Monitor Error at time 655000 channel 0 order 16
Expected order 0, got 16.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 665000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015625
Monitor: Total Time:               665000
$finish at simulation time               665000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 665000 ps
CPU Time:      0.340 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:32:19 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>bgeu ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bgeu/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bgeu/bgeu.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:32 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bgeu/bgeu.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bgeu/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bgeu/memory_32.lst
dut commit No.                   0, rd_s: x02, rd: 0x00000008

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 695000 ps
Spike Monitor Error at time 695000 channel 0 order 20
Expected order 3, got 20.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 705000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.058824
Monitor: Total Time:               705000
$finish at simulation time               705000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 705000 ps
CPU Time:      0.400 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:32:20 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>blt ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/blt/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/blt/blt.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:32 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/blt/blt.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/blt/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/blt/memory_32.lst
dut commit No.                   0, rd_s: x01, rd: 0x00000004

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 685000 ps
Spike Monitor Error at time 685000 channel 0 order 19
Expected order 3, got 19.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 695000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.059701
Monitor: Total Time:               695000
$finish at simulation time               695000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 695000 ps
CPU Time:      0.350 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:32:21 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>bltu ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bltu/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bltu/bltu.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:32 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bltu/bltu.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bltu/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bltu/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 655000 ps
Spike Monitor Error at time 655000 channel 0 order 16
Expected order 0, got 16.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 665000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015625
Monitor: Total Time:               665000
$finish at simulation time               665000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 665000 ps
CPU Time:      0.370 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:32:22 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>bne ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bne/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bne/bne.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:32 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bne/bne.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bne/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bne/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 655000 ps
Spike Monitor Error at time 655000 channel 0 order 16
Expected order 0, got 16.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 665000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015625
Monitor: Total Time:               665000
$finish at simulation time               665000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 665000 ps
CPU Time:      0.350 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:32:23 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>jal ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/jal/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/jal/jal.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:32 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/jal/jal.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/jal/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/jal/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 655000 ps
Spike Monitor Error at time 655000 channel 0 order 16
Expected order 0, got 16.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 665000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015625
Monitor: Total Time:               665000
$finish at simulation time               665000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 665000 ps
CPU Time:      0.500 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:32:24 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>jalr ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/jalr/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/jalr/jalr.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:32 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/jalr/jalr.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/jalr/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/jalr/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 695000 ps
Spike Monitor Error at time 695000 channel 0 order 20
Expected order 0, got 20.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 705000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.014706
Monitor: Total Time:               705000
$finish at simulation time               705000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 705000 ps
CPU Time:      0.400 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:32:25 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>lbu-align ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lbu-align/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lbu-align/lbu-align.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:32 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lbu-align/lbu-align.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lbu-align/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lbu-align/memory_32.lst
Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 33: top_tb: at time 10000005000 ps
TB Error: Timed out
Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 34: top_tb: at time 10000005000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 34.
Monitor: Total IPC: 0.000000
Monitor: Total Time:          10000005000
$finish at simulation time          10000005000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 10000005000 ps
CPU Time:     21.640 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:32:47 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>lb-align ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lb-align/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lb-align/lb-align.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:32 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lb-align/lb-align.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lb-align/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lb-align/memory_32.lst
Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 33: top_tb: at time 10000005000 ps
TB Error: Timed out
Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 34: top_tb: at time 10000005000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 34.
Monitor: Total IPC: 0.000000
Monitor: Total Time:          10000005000
$finish at simulation time          10000005000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 10000005000 ps
CPU Time:     20.990 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:33:08 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>lhu-align ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lhu-align/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lhu-align/lhu-align.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:33 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lhu-align/lhu-align.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lhu-align/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lhu-align/memory_32.lst
Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 33: top_tb: at time 10000005000 ps
TB Error: Timed out
Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 34: top_tb: at time 10000005000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 34.
Monitor: Total IPC: 0.000000
Monitor: Total Time:          10000005000
$finish at simulation time          10000005000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 10000005000 ps
CPU Time:     20.540 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:33:29 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>lh-align ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lh-align/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lh-align/lh-align.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:33 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lh-align/lh-align.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lh-align/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lh-align/memory_32.lst
Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 33: top_tb: at time 10000005000 ps
TB Error: Timed out
Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 34: top_tb: at time 10000005000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 34.
Monitor: Total IPC: 0.000000
Monitor: Total Time:          10000005000
$finish at simulation time          10000005000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 10000005000 ps
CPU Time:     18.020 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:33:48 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>lui ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lui/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lui/lui.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:33 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lui/lui.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lui/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lui/memory_32.lst
Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 33: top_tb: at time 10000005000 ps
TB Error: Timed out
Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 34: top_tb: at time 10000005000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 34.
Monitor: Total IPC: 0.000000
Monitor: Total Time:          10000005000
$finish at simulation time          10000005000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 10000005000 ps
CPU Time:     17.380 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:05 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>lw-align ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lw-align/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lw-align/lw-align.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:34 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lw-align/lw-align.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lw-align/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lw-align/memory_32.lst
Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 33: top_tb: at time 10000005000 ps
TB Error: Timed out
Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 34: top_tb: at time 10000005000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 34.
Monitor: Total IPC: 0.000000
Monitor: Total Time:          10000005000
$finish at simulation time          10000005000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 10000005000 ps
CPU Time:     17.080 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:23 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>misalign1-jalr ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/misalign1-jalr/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/misalign1-jalr/misalign1-jalr.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:34 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/misalign1-jalr/misalign1-jalr.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/misalign1-jalr/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/misalign1-jalr/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 655000 ps
Spike Monitor Error at time 655000 channel 0 order 16
Expected order 0, got 16.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 665000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015625
Monitor: Total Time:               665000
$finish at simulation time               665000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 665000 ps
CPU Time:      0.410 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:23 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>or ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/or/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/or/or.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:34 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/or/or.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/or/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/or/memory_32.lst
Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 33: top_tb: at time 10000005000 ps
TB Error: Timed out
Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 34: top_tb: at time 10000005000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 34.
Monitor: Total IPC: 0.000000
Monitor: Total Time:          10000005000
$finish at simulation time          10000005000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 10000005000 ps
CPU Time:     24.720 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:48 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>ori ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/ori/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/ori/ori.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:34 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/ori/ori.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/ori/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/ori/memory_32.lst
dut commit No.                   0, rd_s: x05, rd: 0xfffffdff

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 725000 ps
Spike Monitor Error at time 725000 channel 0 order 23
Expected order 4, got 23.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 735000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.070423
Monitor: Total Time:               735000
$finish at simulation time               735000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 735000 ps
CPU Time:      0.400 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:49 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>sb-align ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sb-align/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sb-align/sb-align.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:34 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sb-align/sb-align.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sb-align/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sb-align/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 665000 ps
Spike Monitor Error at time 665000 channel 0 order 17
Expected order 0, got 17.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 675000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015385
Monitor: Total Time:               675000
$finish at simulation time               675000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 675000 ps
CPU Time:      0.330 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:49 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>sh-align ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sh-align/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sh-align/sh-align.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:34 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sh-align/sh-align.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sh-align/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sh-align/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 665000 ps
Spike Monitor Error at time 665000 channel 0 order 17
Expected order 0, got 17.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 675000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015385
Monitor: Total Time:               675000
$finish at simulation time               675000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 675000 ps
CPU Time:      0.350 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:50 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>sll ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sll/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sll/sll.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:34 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sll/sll.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sll/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sll/memory_32.lst
dut commit No.                   0, rd_s: x16, rd: 0xffffff7f

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 745000 ps
Spike Monitor Error at time 745000 channel 0 order 22
Expected order 6, got 22.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 755000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.095890
Monitor: Total Time:               755000
$finish at simulation time               755000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 755000 ps
CPU Time:      0.320 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:51 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>slli ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slli/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slli/slli.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:34 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slli/slli.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slli/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slli/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 655000 ps
Spike Monitor Error at time 655000 channel 0 order 16
Expected order 0, got 16.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 665000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015625
Monitor: Total Time:               665000
$finish at simulation time               665000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 665000 ps
CPU Time:      0.320 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:51 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>slt ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slt/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slt/slt.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:34 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slt/slt.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slt/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slt/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 655000 ps
Spike Monitor Error at time 655000 channel 0 order 16
Expected order 0, got 16.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 665000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015625
Monitor: Total Time:               665000
$finish at simulation time               665000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 665000 ps
CPU Time:      0.410 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:52 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>slti ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slti/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slti/slti.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:34 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slti/slti.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slti/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slti/memory_32.lst
dut commit No.                   0, rd_s: x25, rd: 0xffffff7f

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 675000 ps
Spike Monitor Error at time 675000 channel 0 order 18
Expected order 2, got 18.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 685000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.045455
Monitor: Total Time:               685000
$finish at simulation time               685000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 685000 ps
CPU Time:      0.330 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:53 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>sltiu ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sltiu/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sltiu/sltiu.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:34 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sltiu/sltiu.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sltiu/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sltiu/memory_32.lst
dut commit No.                   0, rd_s: x23, rd: 0x00000400

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 885000 ps
Spike Monitor Error at time 885000 channel 0 order 27
Expected order 2, got 27.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 895000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.034483
Monitor: Total Time:               895000
$finish at simulation time               895000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 895000 ps
CPU Time:      0.380 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:54 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>sltu ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sltu/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sltu/sltu.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:34 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sltu/sltu.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sltu/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sltu/memory_32.lst
dut commit No.                   0, rd_s: x00, rd: 0x00000000

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 685000 ps
Spike Monitor Error at time 685000 channel 0 order 19
Expected order 3, got 19.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 695000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.059701
Monitor: Total Time:               695000
$finish at simulation time               695000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 695000 ps
CPU Time:      0.330 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:54 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>sra ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sra/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sra/sra.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:34 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sra/sra.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sra/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sra/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 655000 ps
Spike Monitor Error at time 655000 channel 0 order 16
Expected order 0, got 16.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 665000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015625
Monitor: Total Time:               665000
$finish at simulation time               665000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 665000 ps
CPU Time:      0.430 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:55 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>srai ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srai/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srai/srai.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:34 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srai/srai.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srai/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srai/memory_32.lst
dut commit No.                   0, rd_s: x31, rd: 0xfffffff7

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 725000 ps
Spike Monitor Error at time 725000 channel 0 order 23
Expected order 4, got 23.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 735000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.070423
Monitor: Total Time:               735000
$finish at simulation time               735000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 735000 ps
CPU Time:      0.300 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:56 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>srl ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srl/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srl/srl.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:34 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srl/srl.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srl/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srl/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 655000 ps
Spike Monitor Error at time 655000 channel 0 order 16
Expected order 0, got 16.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 665000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015625
Monitor: Total Time:               665000
$finish at simulation time               665000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 665000 ps
CPU Time:      0.360 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:57 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>srli ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srli/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srli/srli.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:34 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srli/srli.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srli/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srli/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 655000 ps
Spike Monitor Error at time 655000 channel 0 order 16
Expected order 0, got 16.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 665000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015625
Monitor: Total Time:               665000
$finish at simulation time               665000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 665000 ps
CPU Time:      0.320 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:57 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>sub ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sub/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sub/sub.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:34 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sub/sub.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sub/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sub/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 705000 ps
Spike Monitor Error at time 705000 channel 0 order 21
Expected order 0, got 21.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 715000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.014493
Monitor: Total Time:               715000
$finish at simulation time               715000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 715000 ps
CPU Time:      0.340 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:58 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>sw-align ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sw-align/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sw-align/sw-align.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:34 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sw-align/sw-align.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sw-align/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sw-align/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 665000 ps
Spike Monitor Error at time 665000 channel 0 order 17
Expected order 0, got 17.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 675000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015385
Monitor: Total Time:               675000
$finish at simulation time               675000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 675000 ps
CPU Time:      0.370 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:59 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>xor ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/xor/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/xor/xor.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:34 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/xor/xor.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/xor/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/xor/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 655000 ps
Spike Monitor Error at time 655000 channel 0 order 16
Expected order 0, got 16.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 665000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015625
Monitor: Total Time:               665000
$finish at simulation time               665000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 665000 ps
CPU Time:      0.320 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:34:59 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>xori ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/xori/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/xori/xori.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:35 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/xori/xori.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/xori/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/xori/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 655000 ps
Spike Monitor Error at time 655000 channel 0 order 16
Expected order 0, got 16.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 665000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015625
Monitor: Total Time:               665000
$finish at simulation time               665000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 665000 ps
CPU Time:      0.370 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:35:00 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>div ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/div/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/div/div.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:35 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/div/div.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/div/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/div/memory_32.lst
Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 33: top_tb: at time 10000005000 ps
TB Error: Timed out
Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 34: top_tb: at time 10000005000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 34.
Monitor: Total IPC: 0.000000
Monitor: Total Time:          10000005000
$finish at simulation time          10000005000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 10000005000 ps
CPU Time:     22.940 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:35:23 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>divu ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/divu/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/divu/divu.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:35 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/divu/divu.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/divu/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/divu/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 665000 ps
Spike Monitor Error at time 665000 channel 0 order 17
Expected order 0, got 17.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 675000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015385
Monitor: Total Time:               675000
$finish at simulation time               675000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 675000 ps
CPU Time:      0.380 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:35:24 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>mul ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mul/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mul/mul.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:35 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mul/mul.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mul/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mul/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 655000 ps
Spike Monitor Error at time 655000 channel 0 order 16
Expected order 0, got 16.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 665000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015625
Monitor: Total Time:               665000
$finish at simulation time               665000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 665000 ps
CPU Time:      0.350 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:35:24 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>mulh ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulh/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulh/mulh.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:35 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulh/mulh.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulh/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulh/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 675000 ps
Spike Monitor Error at time 675000 channel 0 order 18
Expected order 0, got 18.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 685000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.015152
Monitor: Total Time:               685000
$finish at simulation time               685000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 685000 ps
CPU Time:      0.330 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:35:25 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>mulhsu ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulhsu/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulhsu/mulhsu.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:35 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulhsu/mulhsu.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulhsu/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulhsu/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 695000 ps
Spike Monitor Error at time 695000 channel 0 order 20
Expected order 0, got 20.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 705000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.014706
Monitor: Total Time:               705000
$finish at simulation time               705000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 705000 ps
CPU Time:      0.320 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:35:26 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>mulhu ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulhu/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulhu/mulhu.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:35 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulhu/mulhu.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulhu/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulhu/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 685000 ps
Spike Monitor Error at time 685000 channel 0 order 19
Expected order 0, got 19.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 695000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.014925
Monitor: Total Time:               695000
$finish at simulation time               695000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 695000 ps
CPU Time:      0.350 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:35:26 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>rem ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/rem/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/rem/rem.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:35 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/rem/rem.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/rem/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/rem/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 865000 ps
Spike Monitor Error at time 865000 channel 0 order 25
Expected order 0, got 25.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 875000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.011765
Monitor: Total Time:               875000
$finish at simulation time               875000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 875000 ps
CPU Time:      0.390 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:35:27 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>remu ❌</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=0 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/remu/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/remu/remu.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 23 04:35 2025
using elf file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/remu/remu.elf
*Verdi* Loading libsscore_vcs202409.so
FSDB Dumper for VCS, Release Verdi_W-2024.09, Linux x86_64/64bit, 08/17/2024
(C) 1996 - 2024 by Synopsys, Inc.
*Verdi* : Create FSDB file 'dump.fsdb'
*Verdi* : Begin traversing the scope (top_tb.dut), layer (0).
*Verdi* : Enable +all dumping.
*Verdi* : End of traversing.
*Verdi* : fsdbDumpoff - All FSDB files at 0 ps.
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/remu/memory_32.lst
using memory file /srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/remu/memory_32.lst

Error: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/monitor.sv", 455: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 705000 ps
Spike Monitor Error at time 705000 channel 0 order 21
Expected order 0, got 21.

Fatal: "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 715000 ps
$finish called from file "/srv/tmp/9f3e48dd-6506-4370-bb0f-8a5ec2494d35/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.014493
Monitor: Total Time:               715000
$finish at simulation time               715000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 715000 ps
CPU Time:      0.370 seconds;       Data structure size:   1.2Mb
Wed Apr 23 04:35:28 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
