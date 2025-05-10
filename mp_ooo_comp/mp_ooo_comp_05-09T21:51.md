# AG Report mp_ooo_comp 2025-05-09T21:51:18-05:00 
Report generated at 2025-05-09T22:28:52-05:00, using commit ``8f07a55b21ac519b77b1533686f1c0a031008f73``

Autograder Run ID: ```cd8b6fbe-884b-4c76-8b50-475eaa716042```

Autograder Job ID: ```415800c1-fb7f-4544-8b31-2c7384767ee4```

|Tests|Result|IPC|Delay (μs)|Power (mW)|PD<sup>4</sup>|
|---|---|--:|--:|--:|--:|
|SRAM|❌|

### Logs
<details><summary>SRAM ❌</summary> 

 ``` 
 make clean
make[1]: Entering directory '/srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram'
rm -rf output
mkdir output
touch output/.gitkeep
make[1]: Leaving directory '/srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram'
python3 sram.py
sync
make -j1 
make[1]: Entering directory '/srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram'
make clean
make[2]: Entering directory '/srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram'
rm -rf output
mkdir output
touch output/.gitkeep
make[2]: Leaving directory '/srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram'
python3 sram.py
sync
make -j1 mp_cache_tag_array mp_cache_data_array
make[2]: Entering directory '/srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram'
source /srv/ece411ag/OpenRAM/miniconda/bin/activate ;\
python3 /srv/ece411ag/OpenRAM/compiler/../sram_compiler.py /srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.py
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
** Start: 05/09/2025 22:28:58
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
/srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.lvs
/srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.sp
/srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.v
/srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.lib
/srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.py
/srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.html
/srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.log
/srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.lef
/srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.gds
** Submodules: 1.3 seconds
** Placement: 0.0 seconds
** Routing: 0.0 seconds
** Verification: 0.0 seconds
** SRAM creation: 1.3 seconds
SP: Writing to /srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.sp
Traceback (most recent call last):
  File "/srv/ece411ag/OpenRAM/compiler/../sram_compiler.py", line 76, in <module>
    s.save()
  File "/srv/ece411ag/OpenRAM/compiler/sram.py", line 113, in save
    self.sp_write(spname)
  File "/srv/ece411ag/OpenRAM/compiler/sram.py", line 73, in sp_write
    self.s.sp_write(name, lvs, trim)
  File "/srv/ece411ag/OpenRAM/compiler/modules/sram_1bank.py", line 710, in sp_write
    sp = open(sp_name, 'w')
OSError: [Errno 28] No space left on device: '/srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram/output/mp_cache_tag_array/mp_cache_tag_array.sp'
make[2]: *** [Makefile:20: mp_cache_tag_array] Error 1
make[2]: Leaving directory '/srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram'
make[1]: *** [Makefile:17: all] Error 2
make[1]: Leaving directory '/srv/tmp/415800c1-fb7f-4544-8b31-2c7384767ee4/dut/sram'
make: *** [Makefile:17: all] Error 2
 
 ``` 

 </details> 
