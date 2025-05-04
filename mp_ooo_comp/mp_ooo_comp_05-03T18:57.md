# AG Report mp_ooo_comp 2025-05-03T18:57:19-05:00 
Report generated at 2025-05-03T19:01:21-05:00, using commit ``ab2cbc9c9e8c7dcbe2effb65de9d6a1e8083e8e9``

Autograder Run ID: 4615cde4-0e18-448d-88fa-747a0e9e3650

Autograder Job ID: 1aeaf228-56f7-45f0-b2a3-a259cff211c1

|Tests|Result|IPC|Delay (μs)|Power (mW)|PD<sup>4</sup>|
|---|---|--:|--:|--:|--:|
|SRAM|❌|

### Logs
<details><summary>SRAM ❌</summary> 

 ``` 
 make clean
make[1]: Entering directory '/srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram'
rm -rf output
mkdir output
touch output/.gitkeep
make[1]: Leaving directory '/srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram'
python3 sram.py
sync
make -j1 
make[1]: Entering directory '/srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram'
make clean
make[2]: Entering directory '/srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram'
rm -rf output
mkdir output
touch output/.gitkeep
make[2]: Leaving directory '/srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram'
python3 sram.py
sync
make -j1 mp_cache_tag_array mp_cache_data_array
make[2]: Entering directory '/srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram'
source /srv/ece411ag/OpenRAM/miniconda/bin/activate ;\
python3 /srv/ece411ag/OpenRAM/compiler/../sram_compiler.py /srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.py
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
** Start: 05/03/2025 19:02:50
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
/srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.lvs
/srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.sp
/srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.v
/srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.lib
/srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.py
/srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.html
/srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.log
/srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.lef
/srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.gds
** Submodules: 1.3 seconds
** Placement: 0.0 seconds
** Routing: 0.0 seconds
** Verification: 0.0 seconds
** SRAM creation: 1.3 seconds
SP: Writing to /srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.sp
** Spice writing: 0.1 seconds
DELAY: Writing stimulus...
** DELAY: 0.1 seconds
GDS: Writing to /srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.gds
** GDS: 0.6 seconds
LEF: Writing to /srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.lef
** LEF: 0.0 seconds
LVS: Writing to /srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.lvs.sp
** LVS writing: 0.0 seconds
LIB: Characterizing... 
** Characterization: 0.2 seconds
Config: Writing to /srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.py
** Config: 0.0 seconds
Datasheet: Writing to /srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.html
** Datasheet: 0.0 seconds
Verilog: Writing to /srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.v
** Verilog: 0.0 seconds
Extended Config: Writing to /srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array_extended.py
** Extended Config: 0.0 seconds
** End: 2.4 seconds
sed -i -E 's/falling_edge/rising_edge/g' /srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array_TT_1p0V_25C.lib
source /srv/ece411ag/OpenRAM/miniconda/bin/activate ;\
python3 /srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/area.py /srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.gds > /srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.area.txt
cat ./output/mp_cache_tag_array/mp_cache_tag_array.area.txt | xargs -I {} sed -i -E 's/area : .*/area : {}/g' output/mp_cache_tag_array/mp_cache_tag_array_TT_1p0V_25C.lib
cd /srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array ;\
lc_shell -x 'read_lib /srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array_TT_1p0V_25C.lib; write_lib mp_cache_tag_array_TT_1p0V_25C_lib; exit' ;\
rm -f lc*.log lc*.txt
/bin/bash: line 1: lc_shell: command not found
make[2]: *** [Makefile:24: mp_cache_tag_array] Error 127
make[2]: Leaving directory '/srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram'
make[1]: *** [Makefile:17: all] Error 2
make[1]: Leaving directory '/srv/tmp/1aeaf228-56f7-45f0-b2a3-a259cff211c1/dut/sram'
make: *** [Makefile:17: all] Error 2
 
 ``` 

 </details> 
