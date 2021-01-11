============================
 yosys-examples user manual
============================

+-------------------+----------------------------------------------------------+
| **Title**         | yosys-examples (Verilog projects for simulation and      |
|                   | synthesis)                                               |
+-------------------+----------------------------------------------------------+
| **Author**        | Nikolaos Kavvadias                                       |
|                   |                                                          |
|                   | ``countbits`` example based on work by Guy Eschemann     |
+-------------------+----------------------------------------------------------+
| **Contact**       | nikolaos.kavvadias@gmail.com                             |
+-------------------+----------------------------------------------------------+
| **Website**       | http://www.nkavvadias.com                                |
+-------------------+----------------------------------------------------------+
| **Release Date**  | 13 April 2020                                            |
+-------------------+----------------------------------------------------------+
| **Version**       | 0.0.2                                                    |
+-------------------+----------------------------------------------------------+
| **Rev. history**  |                                                          |
+-------------------+----------------------------------------------------------+
|        **v0.0.2** | 2020-04-13                                               |
|                   |                                                          |
|                   | Update for yosys-0.7 and iverilog-0.10. Avoid            |
|                   | duplication of the cell library.                         |
+-------------------+----------------------------------------------------------+
|        **v0.0.1** | 2016-02-28                                               |
|                   |                                                          |
|                   | First version.                                           |
+-------------------+----------------------------------------------------------+


1. Introduction
---------------

This is a collection of Verilog (mostly) projects. Icarus Verilog 
(http://iverilog.icarus.com) is used for simulation and YOSYS (0.10 
and 0.7 tested, respectively) from http://clifford.at/yosys/ for logic
synthesis.

2. Setup
--------

First edit the ``setup.sh`` script to set the Icarus Verilog path 
(``IVERILOG_PATH``) and the path to the YOSYS binary (``YOSYS_PATH``) to the 
correct location for your setup. The script is located in the top-level 
directory.

Then source the script::

  $ source setup.sh

3. Run
------

To run the simulation and the logic synthesis process for the supplied 
benchmarks, use the ``run.sh`` script from the top-level directory::

  $ ./run.sh
