# AG Report mp_ooo_arch_im 2025-04-24T23:59:59-05:00 
Report generated at 2025-04-25T14:07:09-05:00, using commit ``7b6a9f371c3036dd45bb84ee345fc74bb4c8da9c``

Autograder Run ID: f4d7c48d-179e-4c8e-89a5-b32a75dd4ee2

Autograder Job ID: 7c2c330f-4bc0-4eca-b513-2802ae3034b9

|Tests|Result|
|---|---|
|SRAM|✅|
|compile|✅|
|add|✅|
|addi|✅|
|and|✅|
|andi|✅|
|auipc|✅|
|beq|❌|
|bge|❌|
|bgeu|❌|
|blt|❌|
|bltu|❌|
|bne|❌|
|jal|❌|
|jalr|❌|
|lbu-align|✅|
|lb-align|✅|
|lhu-align|✅|
|lh-align|✅|
|lui|✅|
|lw-align|✅|
|misalign1-jalr|✅|
|or|✅|
|ori|✅|
|sb-align|✅|
|sh-align|✅|
|sll|✅|
|slli|✅|
|slt|✅|
|slti|✅|
|sltiu|✅|
|sltu|✅|
|sra|✅|
|srai|✅|
|srl|✅|
|srli|✅|
|sub|✅|
|sw-align|✅|
|xor|✅|
|xori|✅|
|div|✅|
|divu|✅|
|mul|✅|
|mulh|✅|
|mulhsu|✅|
|mulhu|✅|
|rem|✅|
|remu|✅|

### Logs
<details><summary>SRAM ✅</summary> 

 ``` 
 make clean
make[1]: Entering directory '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram'
rm -rf output
mkdir output
touch output/.gitkeep
make[1]: Leaving directory '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram'
python3 sram.py
sync
make -j4 
make[1]: Entering directory '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram'
make clean
make[2]: Entering directory '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram'
rm -rf output
mkdir output
touch output/.gitkeep
make[2]: Leaving directory '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram'
python3 sram.py
sync
make -j4 mp_cache_tag_array mp_cache_data_array
make[2]: Entering directory '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram'
make[2]: warning: -j4 forced in submake: resetting jobserver mode.
source /srv/ece411ag/OpenRAM/miniconda/bin/activate ;\
python3 /srv/ece411ag/OpenRAM/compiler/../sram_compiler.py /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.py
source /srv/ece411ag/OpenRAM/miniconda/bin/activate ;\
python3 /srv/ece411ag/OpenRAM/compiler/../sram_compiler.py /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array.py
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
** Start: 04/25/2025 14:07:13
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
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.lvs
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.sp
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.v
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.lib
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.py
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.html
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.log
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.lef
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.gds
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
** Start: 04/25/2025 14:07:13
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
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array.lvs
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array.sp
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array.v
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array.lib
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array.py
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array.html
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array.log
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array.lef
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array.gds
** Submodules: 1.1 seconds
** Placement: 0.0 seconds
** Routing: 0.0 seconds
** Verification: 0.0 seconds
** SRAM creation: 1.1 seconds
SP: Writing to /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.sp
** Spice writing: 0.1 seconds
DELAY: Writing stimulus...
** DELAY: 0.1 seconds
GDS: Writing to /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.gds
** GDS: 0.4 seconds
LEF: Writing to /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.lef
** LEF: 0.0 seconds
LVS: Writing to /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.lvs.sp
** LVS writing: 0.0 seconds
LIB: Characterizing... 
** Characterization: 0.2 seconds
Config: Writing to /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.py
** Config: 0.0 seconds
Datasheet: Writing to /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.html
** Datasheet: 0.0 seconds
Verilog: Writing to /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.v
** Verilog: 0.0 seconds
Extended Config: Writing to /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array_extended.py
** Extended Config: 0.0 seconds
** End: 2.0 seconds
sed -i -E 's/falling_edge/rising_edge/g' /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array_TT_1p0V_25C.lib
source /srv/ece411ag/OpenRAM/miniconda/bin/activate ;\
python3 /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/area.py /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.gds > /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.area.txt
cat ./output/mp_cache_tag_array/mp_cache_tag_array.area.txt | xargs -I {} sed -i -E 's/area : .*/area : {}/g' output/mp_cache_tag_array/mp_cache_tag_array_TT_1p0V_25C.lib
cd /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array ;\
lc_shell -x 'read_lib /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array_TT_1p0V_25C.lib; write_lib mp_cache_tag_array_TT_1p0V_25C_lib; exit' ;\
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
Reading '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array_TT_1p0V_25C.lib' ...
Warning: Line 1, The 'internal_power_calculation' attribute in char_config group is required for NLPM library. 
	No default can be applied to this attribute. (LBDB-366)
Information: Line 74, Cell 'mp_cache_tag_array', The cell 'mp_cache_tag_array' contiains memory/memory_read/memory_write groups which are deprecated, use the is_memory_cell attribute instead. (LIBG-280)
Technology library 'mp_cache_tag_array_TT_1p0V_25C_lib' read successfully
Wrote the 'mp_cache_tag_array_TT_1p0V_25C_lib' library to 'mp_cache_tag_array_TT_1p0V_25C_lib.db' successfully
Maximum memory usage for this session: 93.18 MB
CPU usage for this session:      1 seconds (  0.00 hours)
Elapsed time for this session:      2 seconds (  0.00 hours)
Thank you for using Library Compiler.

Thank you...
** Submodules: 17.1 seconds
** Placement: 1.6 seconds
** Routing: 0.0 seconds
** Verification: 0.0 seconds
** SRAM creation: 18.7 seconds
SP: Writing to /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array.sp
** Spice writing: 0.6 seconds
DELAY: Writing stimulus...
** DELAY: 1.0 seconds
GDS: Writing to /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array.gds
** GDS: 3.2 seconds
LEF: Writing to /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array.lef
** LEF: 0.0 seconds
LVS: Writing to /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array.lvs.sp
** LVS writing: 0.1 seconds
LIB: Characterizing... 
** Characterization: 1.1 seconds
Config: Writing to /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array.py
** Config: 0.0 seconds
Datasheet: Writing to /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array.html
** Datasheet: 0.0 seconds
Verilog: Writing to /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array.v
** Verilog: 0.0 seconds
Extended Config: Writing to /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array_extended.py
** Extended Config: 0.0 seconds
** End: 24.9 seconds
sed -i -E 's/falling_edge/rising_edge/g' /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array_TT_1p0V_25C.lib
source /srv/ece411ag/OpenRAM/miniconda/bin/activate ;\
python3 /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/area.py /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array.gds > /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array.area.txt
cat ./output/mp_cache_data_array/mp_cache_data_array.area.txt | xargs -I {} sed -i -E 's/area : .*/area : {}/g' output/mp_cache_data_array/mp_cache_data_array_TT_1p0V_25C.lib
cd /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array ;\
lc_shell -x 'read_lib /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array_TT_1p0V_25C.lib; write_lib mp_cache_data_array_TT_1p0V_25C_lib; exit' ;\
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
Reading '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram/output/mp_cache_data_array/mp_cache_data_array_TT_1p0V_25C.lib' ...
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
make[2]: Leaving directory '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram'
make[1]: Leaving directory '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sram'
 
 ``` 

 </details> 
<details><summary>compile ✅</summary> 

 ``` 
 10000
1
mkdir -p vcs
python3 ../bin/rvfi_reference.py 8 +define+ECE411_NO_FLOAT
cd vcs && vcs /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../pkg/types.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/cpu.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/fifo.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/pcreg.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/robert.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/00_fetch.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/01_inst_q.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/100.1_rename_q.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/1000_writeback.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/1001_commit.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/100_rename_alloc.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/101_dispatch.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/10_decode.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/1000.1_br_writeback.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/110.2_ld_store_q.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/110_r_station_shift.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/11_decode_q.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/old/110_r_station.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/old/110_r_station_new.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/old/111.1_pre_wb_q.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/old/111.2_pre_wb_q.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/old/111_issue.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/arbiter2.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/arbiter.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/elshank2_cache.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/elshank2_cache_mod.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/linebuffer.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/provided_cache.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/sp_ff_array.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/branch_funct_unit.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/int_funct_unit.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/memory_funct_unit.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/mul_div_funct_unit.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/regfiles/free_list.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/regfiles/prf.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/regfiles/prf_queue.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/regfiles/rat_arf.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/monitor.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/mem_itf.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/mon_itf.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/rvfimon.v /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/spike.so /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/dram_w_burst_frfcfs_controller.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/vcs/top_tb.sv /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../sram/output/mp_cache_data_array/mp_cache_data_array.v /srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../sram/output/mp_cache_tag_array/mp_cache_tag_array.v /software/Synopsys-2024_x86_64/icc/W-2024.09/dw/sim_ver/DW_mult_pipe.v /software/Synopsys-2024_x86_64/icc/W-2024.09/dw/sim_ver/DW02_mult.v /software/Synopsys-2024_x86_64/icc/W-2024.09/dw/sim_ver/DW_div_pipe.v /software/Synopsys-2024_x86_64/icc/W-2024.09/dw/sim_ver/DW_div.v +incdir+/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common  +define+ECE411_NO_FLOAT +define+DW_SUPPRESS_WARN +incdir+/software/Synopsys-2024_x86_64/icc/W-2024.09/dw/sim_ver +incdir+/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/vcs -licqueue -full64 -lca -sverilog -timescale=1ps/1ps -debug_acc+all -kdb -suppress=LCA_FEATURES_ENABLED -msg_config=../vcs_warn.config -xprop=../xprop.config -xprop=flowctrl -assert svaext -l compile.log -top top_tb -o top_tb
                         Chronologic VCS (TM)
         Version W-2024.09_Full64 -- Fri Apr 25 14:07:47 2025

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
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../pkg/types.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/cpu.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/fifo.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/pcreg.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/robert.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/00_fetch.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/01_inst_q.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/100.1_rename_q.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/1000_writeback.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/1001_commit.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/100_rename_alloc.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/101_dispatch.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/10_decode.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/1000.1_br_writeback.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/110.2_ld_store_q.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/110_r_station_shift.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/11_decode_q.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/old/110_r_station.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/old/110_r_station_new.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/old/111.1_pre_wb_q.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/old/111.2_pre_wb_q.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/old/111_issue.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/arbiter2.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/arbiter.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/elshank2_cache.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/elshank2_cache_mod.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/linebuffer.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/provided_cache.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/sp_ff_array.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/branch_funct_unit.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/int_funct_unit.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/memory_funct_unit.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/mul_div_funct_unit.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/regfiles/free_list.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/regfiles/prf.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/regfiles/prf_queue.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/regfiles/rat_arf.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/monitor.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/mem_itf.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/mon_itf.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/rvfimon.v'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/dram_w_burst_frfcfs_controller.sv'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/vcs/top_tb.sv'
Parsing included file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh'.
Parsing included file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/rvfi_reference.svh'.
Back to file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh'.
Back to file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/vcs/top_tb.sv'.
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../sram/output/mp_cache_data_array/mp_cache_data_array.v'
Parsing design file '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../sram/output/mp_cache_tag_array/mp_cache_tag_array.v'
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
86 modules and 0 UDP read.
recompiling package rv32i_types
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
recompiling module br_writeback
recompiling module lds_q
recompiling module r_station_shift
recompiling module decode_q
recompiling module arbiter2
recompiling module arbiter
recompiling module cache
recompiling module cache_mod
recompiling module sp_ff_array
recompiling module branch_unit
recompiling module integer_unit
recompiling module load_store_unit
recompiling module multiply_divide_unit
recompiling module free_list
recompiling module prf
recompiling module rat_arf
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
50 of 86 modules done
recompiling module riscv_formal_monitor_rv32imc_insn_lb
recompiling module riscv_formal_monitor_rv32imc_insn_lbu
recompiling module riscv_formal_monitor_rv32imc_insn_lh
recompiling module riscv_formal_monitor_rv32imc_insn_lhu
recompiling module riscv_formal_monitor_rv32imc_insn_lui
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
All of 86 modules done
make[1]: Entering directory '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/vcs/csrc'
make[1]: Leaving directory '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/vcs/csrc'
make[1]: Entering directory '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/vcs/csrc'
rm -f _cuarc*.so _csrc*.so pre_vcsobj_*.so share_vcsobj_*.so
if [ -x ../top_tb ]; then chmod a-x ../top_tb; fi
g++  -o ../top_tb      -rdynamic  -Wl,-rpath='$ORIGIN'/top_tb.daidir -Wl,-rpath=./top_tb.daidir -Wl,-rpath=/software/Synopsys-2024_x86_64/vcs/W-2024.09/linux64/lib -L/software/Synopsys-2024_x86_64/vcs/W-2024.09/linux64/lib  -Wl,-rpath-link=./  /usr/lib64/libnuma.so.1   objs/amcQw_d.o   _262385_archive_1.so   SIM_l.o      rmapats_mop.o rmapats.o rmar.o rmar_nd.o  rmar_llvm_0_1.o rmar_llvm_0_0.o            -lvirsim -lerrorinf -lsnpsmalloc -lvfs spike.so    -lvcsnew -lsimprofile -luclinative /software/Synopsys-2024_x86_64/vcs/W-2024.09/linux64/lib/vcs_tls.o   -Wl,-whole-archive  -lvcsucli    -Wl,-no-whole-archive       ./../top_tb.daidir/vc_hdrs.o  _vcs_pli_stub_.o   /software/Synopsys-2024_x86_64/vcs/W-2024.09/linux64/lib/vcs_save_restore_new.o /software/Synopsys-2024_x86_64/verdi/W-2024.09/share/PLI/VCS/LINUX64/pli.a -ldl  -lc -lm -lpthread -ldl 
../top_tb up to date
make[1]: Leaving directory '/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/vcs/csrc'
CPU time: 5.703 seconds to compile + .546 seconds to elab + .458 seconds to link
Verdi KDB elaboration done and the database successfully generated
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/cpu.sv:174 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/cpu.sv:187 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/cpu.sv:198 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/cpu.sv:211 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/cpu.sv:473 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/cpu.sv:486 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/cpu.sv:818 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/cpu.sv:840 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/pcreg.sv:9 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/robert.sv:94 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/robert.sv:186 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/00_fetch.sv:29 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/00_fetch.sv:82 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/01_inst_q.sv:79 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/100.1_rename_q.sv:79 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/1000_writeback.sv:36 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/100_rename_alloc.sv:51 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/100_rename_alloc.sv:73 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/100_rename_alloc.sv:144 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/101_dispatch.sv:92 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/101_dispatch.sv:96 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/101_dispatch.sv:102 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/101_dispatch.sv:119 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/101_dispatch.sv:137 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/101_dispatch.sv:143 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/101_dispatch.sv:148 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/101_dispatch.sv:164 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/10_decode.sv:54 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/10_decode.sv:174 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/1000.1_br_writeback.sv:40 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/110.2_ld_store_q.sv:54 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/110.2_ld_store_q.sv:128 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/110.2_ld_store_q.sv:174 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/110_r_station_shift.sv:57 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/110_r_station_shift.sv:76 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/110_r_station_shift.sv:109 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/110_r_station_shift.sv:134 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/110_r_station_shift.sv:179 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/110_r_station_shift.sv:224 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/stages/11_decode_q.sv:79 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/arbiter2.sv:61 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/arbiter2.sv:85 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/arbiter.sv:63 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/arbiter.sv:76 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/arbiter.sv:92 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/arbiter.sv:121 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/arbiter.sv:148 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/sp_ff_array.sv:22 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/sp_ff_array.sv:36 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/branch_funct_unit.sv:59 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/branch_funct_unit.sv:74 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/branch_funct_unit.sv:107 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/int_funct_unit.sv:59 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/int_funct_unit.sv:73 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/int_funct_unit.sv:105 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/memory_funct_unit.sv:56 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/memory_funct_unit.sv:70 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/memory_funct_unit.sv:102 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/mul_div_funct_unit.sv:61 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/mul_div_funct_unit.sv:92 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/mul_div_funct_unit.sv:104 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/mul_div_funct_unit.sv:327 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/mul_div_funct_unit.sv:411 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/funct_units/mul_div_funct_unit.sv:435 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/regfiles/free_list.sv:77 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/regfiles/free_list.sv:104 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/regfiles/prf.sv:45 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/regfiles/prf.sv:96 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/regfiles/rat_arf.sv:43 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/regfiles/rat_arf.sv:198 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/regfiles/rat_arf.sv:221 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/regfiles/rat_arf.sv:247 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../sram/output/mp_cache_data_array/mp_cache_data_array.v:42 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../sram/output/mp_cache_data_array/mp_cache_data_array.v:53 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../sram/output/mp_cache_tag_array/mp_cache_tag_array.v:38 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../sram/output/mp_cache_tag_array/mp_cache_tag_array.v:48 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/elshank2_cache_mod.sv:163 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/elshank2_cache_mod.sv:173 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/elshank2_cache_mod.sv:180 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/elshank2_cache_mod.sv:235 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/elshank2_cache_mod.sv:372 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/elshank2_cache_mod.sv:380 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/elshank2_cache.sv:150 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/elshank2_cache.sv:202 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/elshank2_cache.sv:320 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/elshank2_cache.sv:328 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/sp_ff_array.sv:22 YES
/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hdl/caches/sp_ff_array.sv:36 YES
==================================================
X P R O P   S T A T I S T I C S
instrumentable assignments:    1279
instrumented assignments:      1279
instrumentation success rate:  100%
[0;32mCompile Successful [0m
 
 ``` 

 </details> 
<details><summary>add ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/add/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/add/add.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:07 2025
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
dut commit No.                   0, rd_s: x04, rd: 0x80000000
dut commit No.                1000, rd_s: x10, rd: 0xffff5000
dut commit No.                2000, rd_s: x11, rd: 0x55555554
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.389763
Monitor: Total Time:             65475000
$finish at simulation time             65475000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 65475000 ps
CPU Time:      1.400 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:07:55 2025
0.389763
65475000
 
 ``` 

 </details> 
<details><summary>addi ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/addi/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/addi/addi.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:07 2025
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
dut commit No.                   0, rd_s: x20, rd: 0x20000000
dut commit No.                1000, rd_s: x11, rd: 0x0000b531
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.388545
Monitor: Total Time:             38785000
$finish at simulation time             38785000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 38785000 ps
CPU Time:      0.870 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:07:56 2025
0.388545
38785000
 
 ``` 

 </details> 
<details><summary>and ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/and/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/and/and.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:07 2025
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
dut commit No.                   0, rd_s: x24, rd: 0x00004000
dut commit No.                1000, rd_s: x11, rd: 0x33333332
dut commit No.                2000, rd_s: x10, rd: 0x00000004
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.389231
Monitor: Total Time:             65025000
$finish at simulation time             65025000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 65025000 ps
CPU Time:      1.300 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:07:58 2025
0.389231
65025000
 
 ``` 

 </details> 
<details><summary>andi ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/andi/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/andi/andi.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:07 2025
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
dut commit No.                1000, rd_s: x10, rd: 0x0000b000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.388703
Monitor: Total Time:             38795000
$finish at simulation time             38795000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 38795000 ps
CPU Time:      0.940 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:00 2025
0.388703
38795000
 
 ``` 

 </details> 
<details><summary>auipc ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/auipc/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/auipc/auipc.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x12, rd: 0xaaaaa000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.374757
Monitor: Total Time:              5175000
$finish at simulation time              5175000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 5175000 ps
CPU Time:      0.490 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:01 2025
0.374757
5175000
 
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
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/beq/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/beq/beq.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x19, rd: 0x55555000

Error: "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/monitor.sv", 461: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 1015000 ps
Spike Monitor Error at time 1015000 channel 0 order 14
-------begin spike mismatch--------
signal     diff       dut     spike
inst       ---> h00000013 h02e00063 beq     x0, x14, pc + 32
rs1_addr               00        00
rs1_rdata       h00000000 h00000000
rs2_addr   --->        00        14
rs2_rdata  ---> h00000000 hffff4afc
rd_addr                00        00
rd_wdata        h00000000 h00000000
pc_rdata        haaaaa848 haaaaa848
pc_wdata        haaaaa84c haaaaa84c
mem_addr        h00000000 h00000000
mem_rmask           b0000     b0000
mem_wmask           b0000     b0000
mem_rdata       h00000000 h00000000
mem_wdata       h00000000 h00000000
-------end spike mismatch----------

Fatal: "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 1025000 ps
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.150000
Monitor: Total Time:              1025000
$finish at simulation time              1025000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 1025000 ps
CPU Time:      0.410 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:01 2025
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
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bge/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bge/bge.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x27, rd: 0x00010000

Error: "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/monitor.sv", 461: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 765000 ps
Spike Monitor Error at time 765000 channel 0 order 7
-------begin spike mismatch--------
signal     diff       dut     spike
inst       ---> h00000663 h00200693 li      x13, 2
rs1_addr               00        00
rs1_rdata       h00000000 h00000000
rs2_addr               00        00
rs2_rdata       h00000000 h00000000
rd_addr    --->        00        13
rd_wdata   ---> h00000000 h00000002
pc_rdata        haaaaa220 haaaaa220
pc_wdata   ---> haaaaa22c haaaaa224
mem_addr        h00000000 h00000000
mem_rmask           b0000     b0000
mem_wmask           b0000     b0000
mem_rdata       h00000000 h00000000
mem_wdata       h00000000 h00000000
-------end spike mismatch----------

Fatal: "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 775000 ps
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.106667
Monitor: Total Time:               775000
$finish at simulation time               775000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 775000 ps
CPU Time:      0.320 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:02 2025
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
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bgeu/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bgeu/bgeu.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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

Error: "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/monitor.sv", 461: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 785000 ps
Spike Monitor Error at time 785000 channel 0 order 11
-------begin spike mismatch--------
signal     diff       dut     spike
inst       ---> h20000063 h203ff063 bgeu    x31, x3, pc + 512
rs1_addr   --->        00        31
rs1_rdata  ---> h00000000 hffffffbf
rs2_addr   --->        00        03
rs2_rdata  ---> h00000000 hffffffbf
rd_addr                00        00
rd_wdata        h00000000 h00000000
pc_rdata        haaaaa044 haaaaa044
pc_wdata        haaaaa244 haaaaa244
mem_addr        h00000000 h00000000
mem_rmask           b0000     b0000
mem_wmask           b0000     b0000
mem_rdata       h00000000 h00000000
mem_wdata       h00000000 h00000000
-------end spike mismatch----------

Fatal: "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 795000 ps
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.155844
Monitor: Total Time:               795000
$finish at simulation time               795000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 795000 ps
CPU Time:      0.360 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:03 2025
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
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/blt/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/blt/blt.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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

Error: "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/monitor.sv", 461: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 1655000 ps
Spike Monitor Error at time 1655000 channel 0 order 28
-------begin spike mismatch--------
signal     diff       dut     spike
inst       ---> h02000063 h039a4063 blt     x20, x25, pc + 32
rs1_addr   --->        00        20
rs1_rdata  ---> h00000000 hffefffff
rs2_addr   --->        00        25
rs2_rdata  ---> h00000000 h00000001
rd_addr                00        00
rd_wdata        h00000000 h00000000
pc_rdata        haaaaa124 haaaaa124
pc_wdata        haaaaa144 haaaaa144
mem_addr        h00000000 h00000000
mem_rmask           b0000     b0000
mem_wmask           b0000     b0000
mem_rdata       h00000000 h00000000
mem_wdata       h00000000 h00000000
-------end spike mismatch----------

Fatal: "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 1665000 ps
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.176829
Monitor: Total Time:              1665000
$finish at simulation time              1665000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 1665000 ps
CPU Time:      0.330 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:04 2025
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
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bltu/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bltu/bltu.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x17, rd: 0x20000000

Error: "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/monitor.sv", 461: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 1385000 ps
Spike Monitor Error at time 1385000 channel 0 order 22
-------begin spike mismatch--------
signal     diff       dut     spike
inst       ---> h00000663 hfe7ae8e3 bltu    x21, x7, pc - 16
rs1_addr   --->        00        21
rs1_rdata  ---> h00000000 h7fffffff
rs2_addr   --->        00        07
rs2_rdata  ---> h00000000 h7fffffff
rd_addr                00        00
rd_wdata        h00000000 h00000000
pc_rdata        haaaaab2c haaaaab2c
pc_wdata   ---> haaaaab38 haaaaab30
mem_addr        h00000000 h00000000
mem_rmask           b0000     b0000
mem_wmask           b0000     b0000
mem_rdata       h00000000 h00000000
mem_wdata       h00000000 h00000000
-------end spike mismatch----------

Fatal: "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 1395000 ps
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.167883
Monitor: Total Time:              1395000
$finish at simulation time              1395000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 1395000 ps
CPU Time:      0.360 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:04 2025
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
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bne/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/bne/bne.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x16, rd: 0x55555000

Error: "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/monitor.sv", 461: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 1395000 ps
Spike Monitor Error at time 1395000 channel 0 order 21
-------begin spike mismatch--------
signal     diff       dut     spike
inst       ---> h10000063 h11a71063 bne     x14, x26, pc + 256
rs1_addr   --->        00        14
rs1_rdata  ---> h00000000 hfffff7ff
rs2_addr   --->        00        26
rs2_rdata  ---> h00000000 hffffffef
rd_addr                00        00
rd_wdata        h00000000 h00000000
pc_rdata        haaaaa464 haaaaa464
pc_wdata        haaaaa564 haaaaa564
mem_addr        h00000000 h00000000
mem_rmask           b0000     b0000
mem_wmask           b0000     b0000
mem_rdata       h00000000 h00000000
mem_wdata       h00000000 h00000000
-------end spike mismatch----------

Fatal: "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 1405000 ps
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.159420
Monitor: Total Time:              1405000
$finish at simulation time              1405000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 1405000 ps
CPU Time:      0.370 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:05 2025
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
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/jal/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/jal/jal.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x00, rd: 0x00000000
Error: "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", 33: top_tb: at time 10000005000 ps
TB Error: Timed out
Fatal: "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", 34: top_tb: at time 10000005000 ps
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 34.
Monitor: Total IPC: 0.000002
Monitor: Total Time:          10000005000
$finish at simulation time          10000005000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 10000005000 ps
CPU Time:     19.850 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:25 2025
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
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/jalr/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/jalr/jalr.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x25, rd: 0xaaaaa000

Error: "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/monitor.sv", 461: top_tb.monitor.unnamed$$_15.unnamed$$_17: at time 1995000 ps
Spike Monitor Error at time 1995000 channel 0 order 40
-------begin spike mismatch--------
signal     diff       dut     spike
inst       ---> h00000697 h00000797 auipc   x15, 0x0
rs1_addr               00        00
rs1_rdata       h00000000 h00000000
rs2_addr               00        00
rs2_rdata       h00000000 h00000000
rd_addr    --->        13        15
rd_wdata        haaaaa0e0 haaaaa0e0
pc_rdata        haaaaa0e0 haaaaa0e0
pc_wdata        haaaaa0e4 haaaaa0e4
mem_addr        h00000000 h00000000
mem_rmask           b0000     b0000
mem_wmask           b0000     b0000
mem_rdata       h00000000 h00000000
mem_wdata       h00000000 h00000000
-------end spike mismatch----------

Fatal: "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", 37: top_tb: at time 2005000 ps
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 37.
Monitor: Total IPC: 0.207071
Monitor: Total Time:              2005000
$finish at simulation time              2005000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 2005000 ps
CPU Time:      0.340 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:26 2025
make: *** [Makefile:33: run_vcs_top_tb] Error 3
 
 ``` 

 </details> 
<details><summary>lbu-align ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lbu-align/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lbu-align/lbu-align.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x09, rd: 0xaaaac000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.358156
Monitor: Total Time:              2845000
$finish at simulation time              2845000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 2845000 ps
CPU Time:      0.360 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:27 2025
0.358156
2845000
 
 ``` 

 </details> 
<details><summary>lb-align ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lb-align/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lb-align/lb-align.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x10, rd: 0xaaaac000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.361111
Monitor: Total Time:              2905000
$finish at simulation time              2905000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 2905000 ps
CPU Time:      0.400 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:28 2025
0.361111
2905000
 
 ``` 

 </details> 
<details><summary>lhu-align ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lhu-align/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lhu-align/lhu-align.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x14, rd: 0xaaaac000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.358156
Monitor: Total Time:              2845000
$finish at simulation time              2845000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 2845000 ps
CPU Time:      0.370 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:29 2025
0.358156
2845000
 
 ``` 

 </details> 
<details><summary>lh-align ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lh-align/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lh-align/lh-align.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x03, rd: 0xaaaac000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.358156
Monitor: Total Time:              2845000
$finish at simulation time              2845000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 2845000 ps
CPU Time:      0.360 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:29 2025
0.358156
2845000
 
 ``` 

 </details> 
<details><summary>lui ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lui/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lui/lui.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x08, rd: 0x00000000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.376471
Monitor: Total Time:              1725000
$finish at simulation time              1725000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 1725000 ps
CPU Time:      0.340 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:30 2025
0.376471
1725000
 
 ``` 

 </details> 
<details><summary>lw-align ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lw-align/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/lw-align/lw-align.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x12, rd: 0xaaaac000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.358156
Monitor: Total Time:              2845000
$finish at simulation time              2845000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 2845000 ps
CPU Time:      0.360 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:31 2025
0.358156
2845000
 
 ``` 

 </details> 
<details><summary>misalign1-jalr ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/misalign1-jalr/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/misalign1-jalr/misalign1-jalr.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x11, rd: 0xaaaaa000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.203390
Monitor: Total Time:               615000
$finish at simulation time               615000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 615000 ps
CPU Time:      0.310 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:32 2025
0.203390
615000
 
 ``` 

 </details> 
<details><summary>or ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/or/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/or/or.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x08, rd: 0x00100000
dut commit No.                1000, rd_s: x10, rd: 0xffff5000
dut commit No.                2000, rd_s: x11, rd: 0x55555554
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.389763
Monitor: Total Time:             65475000
$finish at simulation time             65475000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 65475000 ps
CPU Time:      1.290 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:34 2025
0.389763
65475000
 
 ``` 

 </details> 
<details><summary>ori ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/ori/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/ori/ori.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                1000, rd_s: x10, rd: 0x0000b505
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.389436
Monitor: Total Time:             38645000
$finish at simulation time             38645000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 38645000 ps
CPU Time:      0.940 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:35 2025
0.389436
38645000
 
 ``` 

 </details> 
<details><summary>sb-align ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sb-align/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sb-align/sb-align.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x01, rd: 0xaaaac000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.366748
Monitor: Total Time:             12295000
$finish at simulation time             12295000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 12295000 ps
CPU Time:      0.550 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:36 2025
0.366748
12295000
 
 ``` 

 </details> 
<details><summary>sh-align ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sh-align/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sh-align/sh-align.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x04, rd: 0xaaaac000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.375618
Monitor: Total Time:             12165000
$finish at simulation time             12165000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 12165000 ps
CPU Time:      0.540 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:37 2025
0.375618
12165000
 
 ``` 

 </details> 
<details><summary>sll ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sll/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sll/sll.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.384040
Monitor: Total Time:              8045000
$finish at simulation time              8045000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 8045000 ps
CPU Time:      0.430 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:38 2025
0.384040
8045000
 
 ``` 

 </details> 
<details><summary>slli ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slli/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slli/slli.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x17, rd: 0xc0000000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.383244
Monitor: Total Time:              5635000
$finish at simulation time              5635000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 5635000 ps
CPU Time:      0.390 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:39 2025
0.383244
5635000
 
 ``` 

 </details> 
<details><summary>slt ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slt/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slt/slt.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x18, rd: 0x66666000
dut commit No.                1000, rd_s: x10, rd: 0xffff4afc
dut commit No.                2000, rd_s: x12, rd: 0x00000001
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.389606
Monitor: Total Time:             65065000
$finish at simulation time             65065000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 65065000 ps
CPU Time:      1.350 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:41 2025
0.389606
65065000
 
 ``` 

 </details> 
<details><summary>slti ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slti/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/slti/slti.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                1000, rd_s: x10, rd: 0x0000b505
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.389277
Monitor: Total Time:             38635000
$finish at simulation time             38635000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 38635000 ps
CPU Time:      0.910 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:42 2025
0.389277
38635000
 
 ``` 

 </details> 
<details><summary>sltiu ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sltiu/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sltiu/sltiu.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                1000, rd_s: x10, rd: 0x00000004
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.389709
Monitor: Total Time:             47445000
$finish at simulation time             47445000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 47445000 ps
CPU Time:      1.040 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:44 2025
0.389709
47445000
 
 ``` 

 </details> 
<details><summary>sltu ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sltu/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sltu/sltu.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                1000, rd_s: x11, rd: 0x66666667
dut commit No.                2000, rd_s: x10, rd: 0x0000b503
dut commit No.                3000, rd_s: x11, rd: 0xaaaab000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.389569
Monitor: Total Time:             79215000
$finish at simulation time             79215000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 79215000 ps
CPU Time:      1.510 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:46 2025
0.389569
79215000
 
 ``` 

 </details> 
<details><summary>sra ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sra/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sra/sra.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x16, rd: 0x80000000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.386335
Monitor: Total Time:              8075000
$finish at simulation time              8075000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 8075000 ps
CPU Time:      0.440 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:47 2025
0.386335
8075000
 
 ``` 

 </details> 
<details><summary>srai ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srai/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srai/srai.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.382143
Monitor: Total Time:              5625000
$finish at simulation time              5625000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 5625000 ps
CPU Time:      0.390 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:48 2025
0.382143
5625000
 
 ``` 

 </details> 
<details><summary>srl ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srl/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srl/srl.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x26, rd: 0xffc00000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.385922
Monitor: Total Time:              8265000
$finish at simulation time              8265000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 8265000 ps
CPU Time:      0.550 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:49 2025
0.385922
8265000
 
 ``` 

 </details> 
<details><summary>srli ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srli/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/srli/srli.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x30, rd: 0xffff5000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.381693
Monitor: Total Time:              5815000
$finish at simulation time              5815000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 5815000 ps
CPU Time:      0.410 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:50 2025
0.381693
5815000
 
 ``` 

 </details> 
<details><summary>sub ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sub/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sub/sub.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x24, rd: 0x55555000
dut commit No.                1000, rd_s: x12, rd: 0xffff4af7
dut commit No.                2000, rd_s: x12, rd: 0x9999999e
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.389496
Monitor: Total Time:             65905000
$finish at simulation time             65905000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 65905000 ps
CPU Time:      1.300 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:51 2025
0.389496
65905000
 
 ``` 

 </details> 
<details><summary>sw-align ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sw-align/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/sw-align/sw-align.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x02, rd: 0xaaaac000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.370968
Monitor: Total Time:             11805000
$finish at simulation time             11805000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 11805000 ps
CPU Time:      0.550 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:53 2025
0.370968
11805000
 
 ``` 

 </details> 
<details><summary>xor ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/xor/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/xor/xor.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x27, rd: 0x66666000
dut commit No.                1000, rd_s: x10, rd: 0xffff5000
dut commit No.                2000, rd_s: x11, rd: 0x55555000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.389483
Monitor: Total Time:             65445000
$finish at simulation time             65445000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 65445000 ps
CPU Time:      1.330 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:54 2025
0.389483
65445000
 
 ``` 

 </details> 
<details><summary>xori ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/xori/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/i/xori/xori.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x24, rd: 0x33333000
dut commit No.                1000, rd_s: x10, rd: 0x0000b505
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.388917
Monitor: Total Time:             39005000
$finish at simulation time             39005000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 39005000 ps
CPU Time:      1.000 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:56 2025
0.388917
39005000
 
 ``` 

 </details> 
<details><summary>div ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/div/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/div/div.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x01, rd: 0xaaaae000
dut commit No.                1000, rd_s: x29, rd: 0x33333000
dut commit No.                2000, rd_s: x31, rd: 0x00000000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.389087
Monitor: Total Time:             70215000
$finish at simulation time             70215000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 70215000 ps
CPU Time:      1.470 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:08:58 2025
0.389087
70215000
 
 ``` 

 </details> 
<details><summary>divu ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/divu/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/divu/divu.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:08 2025
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
dut commit No.                   0, rd_s: x11, rd: 0xaaaaf000
dut commit No.                1000, rd_s: x12, rd: 0x00000000
dut commit No.                2000, rd_s: x11, rd: 0x66666666
dut commit No.                3000, rd_s: x12, rd: 0x00000001
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.389412
Monitor: Total Time:             79735000
$finish at simulation time             79735000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 79735000 ps
CPU Time:      1.730 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:09:00 2025
0.389412
79735000
 
 ``` 

 </details> 
<details><summary>mul ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mul/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mul/mul.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:09 2025
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
dut commit No.                   0, rd_s: x04, rd: 0xaaaae000
dut commit No.                1000, rd_s: x11, rd: 0x0000b504
dut commit No.                2000, rd_s: x11, rd: 0x33333000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.389101
Monitor: Total Time:             65355000
$finish at simulation time             65355000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 65355000 ps
CPU Time:      1.420 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:09:02 2025
0.389101
65355000
 
 ``` 

 </details> 
<details><summary>mulh ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulh/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulh/mulh.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:09 2025
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
dut commit No.                   0, rd_s: x04, rd: 0xaaaae000
dut commit No.                1000, rd_s: x10, rd: 0xffff4afc
dut commit No.                2000, rd_s: x12, rd: 0x00000000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.389126
Monitor: Total Time:             65505000
$finish at simulation time             65505000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 65505000 ps
CPU Time:      1.460 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:09:04 2025
0.389126
65505000
 
 ``` 

 </details> 
<details><summary>mulhsu ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulhsu/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulhsu/mulhsu.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:09 2025
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
dut commit No.                   0, rd_s: x17, rd: 0xaaaae000
dut commit No.                1000, rd_s: x10, rd: 0x66666000
dut commit No.                2000, rd_s: x10, rd: 0x33333000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.389160
Monitor: Total Time:             71795000
$finish at simulation time             71795000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 71795000 ps
CPU Time:      1.610 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:09:06 2025
0.389160
71795000
 
 ``` 

 </details> 
<details><summary>mulhu ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulhu/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/mulhu/mulhu.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:09 2025
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
dut commit No.                   0, rd_s: x17, rd: 0xaaaaf000
dut commit No.                1000, rd_s: x10, rd: 0x66666000
dut commit No.                2000, rd_s: x12, rd: 0x00004867
dut commit No.                3000, rd_s: x10, rd: 0x00010000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.389252
Monitor: Total Time:             79665000
$finish at simulation time             79665000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 79665000 ps
CPU Time:      1.720 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:09:08 2025
0.389252
79665000
 
 ``` 

 </details> 
<details><summary>rem ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/rem/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/rem/rem.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:09 2025
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
dut commit No.                   0, rd_s: x26, rd: 0xaaaae000
dut commit No.                1000, rd_s: x10, rd: 0xffff5000
dut commit No.                2000, rd_s: x10, rd: 0x00000004
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.388940
Monitor: Total Time:             65485000
$finish at simulation time             65485000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 65485000 ps
CPU Time:      1.430 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:09:10 2025
0.388940
65485000
 
 ``` 

 </details> 
<details><summary>remu ✅</summary> 

 ``` 
 mkdir -p spike
rm -f vcs/dump.fsdb
cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
	+NO_DUMP_ALL_ECE411 \
	+TIMEOUT_ECE411=1000000 \
	+CLOCK_PERIOD_PS_ECE411=10000 \
	+BRAM_0_ON_X_ECE411=1 \
	+MEMLST_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/remu/memory_32.lst" \
	+ELF_ECE411="/srv/ece411ag/ag/given/mp_ooo/testcode/arch/m/remu/remu.elf"
Chronologic VCS simulator copyright 1991-2024
Contains Synopsys proprietary information.
Compiler version W-2024.09_Full64; Runtime version W-2024.09_Full64;  Apr 25 14:09 2025
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
dut commit No.                   0, rd_s: x19, rd: 0xaaaaf000
dut commit No.                1000, rd_s: x10, rd: 0x66666666
dut commit No.                2000, rd_s: x10, rd: 0x0000b000
dut commit No.                3000, rd_s: x11, rd: 0x0000b000
$finish called from file "/srv/tmp/7c2c330f-4bc0-4eca-b513-2802ae3034b9/dut/sim/../hvl/common/top_tb.svh", line 30.
Monitor: Total IPC: 0.389252
Monitor: Total Time:             79665000
$finish at simulation time             79665000
           V C S   S i m u l a t i o n   R e p o r t 
Time: 79665000 ps
CPU Time:      1.630 seconds;       Data structure size:   1.2Mb
Fri Apr 25 14:09:12 2025
0.389252
79665000
 
 ``` 

 </details> 
